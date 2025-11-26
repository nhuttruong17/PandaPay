#!/usr/bin/env python3
"""Upload Robot test results to AIO - using form data like successful CURL"""

import requests
import os
import json
import xml.etree.ElementTree as ET

# Config
base_url = "https://tcms.aiojiraapps.com/aio-tcms/api/v1"
token = "YWVkNmMxMTEtYjBmNC0zMmIxLWEzMGEtOTMyZTM2ZjUyM2M1LjcyODZmMzM2LTAwNTUtNGJhNC1iZjQ3LTg1ODBmOTk2ZDgyMQ=="
project_key = "PPPA"
cycle_key = "PPPA-CY-6"

# Find output.xml
output_xml = "output.xml"
if not os.path.exists(output_xml):
    print(f"ERROR: {output_xml} not found")
    exit(1)

file_size = os.path.getsize(output_xml)
print(f"File: {output_xml}")
print(f"Size: {file_size} bytes")

if file_size == 0:
    print("ERROR: File is empty")
    exit(1)

# Validate XML
try:
    tree = ET.parse(output_xml)
    root = tree.getroot()
    print(f"XML valid. Root tag: {root.tag}")
    print(f"Generator: {root.get('generator')}")
except Exception as e:
    print(f"ERROR: Invalid XML - {e}")
    exit(1)

# Upload URL and headers (from successful CURL)
url = f"{base_url}/project/{project_key}/testcycle/{cycle_key}/import/results"

headers = {
    "Authorization": f"AioAuth {token}",
    "Accept": "application/json;charset=utf-8"
}

params = {
    "type": "Robot"
}

# Form data matching CURL --form (not JSON body)
data = {
    'createNewRun': 'true',
    'addCaseToCycle': 'true',
    'createCase': 'true'
}

print(f"\nUploading to: {url}\n")

# Attempt 1: Standard upload
print("[Attempt 1] Standard upload")
print(f"Params: {params}")
print(f"Form data: {data}\n")

with open(output_xml, 'rb') as f:
    files = {'file': ('output.xml', f, 'application/xml')}
    response = requests.post(url, params=params, headers=headers, files=files, data=data, timeout=30)

print(f"Status: {response.status_code}")

try:
    resp_json = response.json()
    print(f"Response: {json.dumps(resp_json, indent=2)}\n")
except json.JSONDecodeError:
    print(f"Response (raw): {response.text[:300]}\n")
    resp_json = {}

# Check if success
if resp_json.get('status') == 'SUCCESS':
    print(f"✅ SUCCESS!")
    print(f"   Processed: {resp_json.get('requestCount')} cases")
    print(f"   Success: {resp_json.get('successCount')}")
    exit(0)

# Check if steps mismatch or case not found
errors = resp_json.get('errors', {})
has_steps_mismatch = any("steps don't match" in str(err.get('message', '')).lower() for err in errors.values())
has_no_case_error = any("No case found" in str(err.get('message', '')) for err in errors.values())

if (has_steps_mismatch or has_no_case_error) and resp_json.get('status') == 'FAILED':
    print("[Attempt 2] Retrying with forceUpdateCase=true\n")
    
    data_2 = {
        'createNewRun': 'true',
        'addCaseToCycle': 'true',
        'createCase': 'true',
        'forceUpdateCase': 'true'
    }
    
    with open(output_xml, 'rb') as f:
        files = {'file': ('output.xml', f, 'application/xml')}
        response = requests.post(url, params=params, headers=headers, files=files, data=data_2, timeout=30)
    
    print(f"Status: {response.status_code}")
    try:
        resp_json = response.json()
        print(f"Response: {json.dumps(resp_json, indent=2)}\n")
    except json.JSONDecodeError:
        print(f"Response (raw): {response.text[:300]}\n")

# Final result
if resp_json.get('status') == 'SUCCESS':
    print(f"✅ SUCCESS!")
    print(f"   Processed: {resp_json.get('requestCount')} cases")
    print(f"   Success: {resp_json.get('successCount')}")
    exit(0)
else:
    print(f"❌ FAILED")
    print(f"   Status: {resp_json.get('status')}")
    print(f"   Success: {resp_json.get('successCount')}, Error: {resp_json.get('errorCount')}")
    if errors:
        print(f"   Error details:")
        for key, err in errors.items():
            print(f"     - {key}: {err.get('message')}")
    exit(1)
