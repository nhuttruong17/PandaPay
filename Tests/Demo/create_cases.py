#!/usr/bin/env python3
"""Create test cases in AIO TCMS before uploading results"""

import requests
import json

# Config
base_url = "https://tcms.aiojiraapps.com/aio-tcms/api/v1"
token = "YWVkNmMxMTEtYjBmNC0zMmIxLWEzMGEtOTMyZTM2ZjUyM2M1LjcyODZmMzM2LTAwNTUtNGJhNC1iZjQ3LTg1ODBmOTk2ZDgyMQ=="
project_key = "PPPA"
cycle_key = "PPPA-CY-6"

headers = {
    "Authorization": f"AioAuth {token}",
    "Content-Type": "application/json",
    "Accept": "application/json"
}

# Test cases to create
cases = [
    {
        "name": "Compare one to one Pass",
        "automationKey": "Demo/Demo_importJira.robot:Compare_one_to_one_Pass",
        "description": "Case này pass"
    },
    {
        "name": "Compare one to two Fail",
        "automationKey": "Demo/Demo_importJira.robot:Compare_one_to_two_Fail",
        "description": "Case này fail để demo"
    }
]

# Create cases
url = f"{base_url}/project/{project_key}/testcase"

print("Creating test cases in AIO...\n")

for case in cases:
    print(f"Creating: {case['name']}")
    print(f"  Automation Key: {case['automationKey']}")
    
    payload = {
        "name": case["name"],
        "automationKey": case["automationKey"],
        "description": case["description"],
        "title": case["name"]
    }
    
    try:
        response = requests.post(url, json=payload, headers=headers, timeout=10)
        print(f"  Status: {response.status_code}")
        
        if response.status_code in [200, 201]:
            resp_json = response.json()
            case_id = resp_json.get("id") or resp_json.get("key")
            print(f"  Response: {json.dumps(resp_json, indent=2)}")
            print(f"  ✅ Created: {case_id}")
            
            # Add to cycle
            if case_id:
                add_url = f"{base_url}/project/{project_key}/testcycle/{cycle_key}/testcase/{case_id}"
                add_response = requests.post(add_url, headers=headers, timeout=10)
                print(f"  Added to cycle: {add_response.status_code}")
        else:
            print(f"  ❌ Failed: {response.text[:300]}")
    
    except Exception as e:
        print(f"  ❌ Error: {e}")
    
    print()

print("✅ Done!")
