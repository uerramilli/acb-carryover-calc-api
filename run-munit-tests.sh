#!/bin/bash

# MUnit Test Runner Script for ACB Carryover Calculation API
# This script runs MUnit tests outside of the CI/CD pipeline

echo "=========================================="
echo "ACB Carryover Calculation API - MUnit Tests"
echo "=========================================="

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "ERROR: Maven is not installed or not in PATH"
    exit 1
fi

echo "Starting MUnit test execution..."
echo "Note: Tests are configured to skip during CI/CD builds"

# Run MUnit tests with explicit flag to enable them
mvn clean test -DrunMunitTests=false -DskipMunitTests=false

# Check the exit code
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✓ All MUnit tests completed successfully!"
    echo "=========================================="
else
    echo ""
    echo "=========================================="
    echo "✗ Some MUnit tests failed!"
    echo "Check the output above for details."
    echo "=========================================="
    exit 1
fi

echo ""
echo "Test Results Location:"
echo "- Surefire Reports: target/surefire-reports/"
echo "- MUnit Reports: target/munit-reports/"
echo ""
echo "To view detailed test results:"
echo "  open target/munit-reports/munit-report.html"