#!/bin/bash
# /Users/apple/Downloads/School/PycharmProjects/PandaPay/Tests/Demo/run_and_upload_simple.sh
# Simple script to run test and upload to Jira

cd /Users/apple/Downloads/School/PycharmProjects/PandaPay

echo "=========================================="
echo "Running Robot Framework tests..."
echo "=========================================="
python3 -m robot Tests/Demo/Demo_importJira.robot

echo ""
echo "=========================================="
echo "Uploading results to Jira AIO Tests..."
echo "=========================================="
python3 Tests/Demo/test_upload.py

echo ""
echo "=========================================="
echo "Done! Check Jira for results."
echo "=========================================="
