# MUnit Testing Guide for ACB Carryover Calculation API

## Overview

This document describes the MUnit test suite for the ACB Carryover Calculation API. The tests are designed to validate the API functionality without interfering with CI/CD pipeline builds.

## Test Structure

### Test Files

1. **`src/test/munit/acb-carryover-calc-api-test-suite.xml`**
   - Main test suite with comprehensive API endpoint tests
   - Happy path scenarios
   - Error handling tests
   - Parameter validation tests
   - APIKit error handler tests

2. **`src/test/munit/acb-carryover-calc-integration-test-suite.xml`**
   - Integration tests for end-to-end functionality
   - Data transformation validation
   - Performance tests
   - Logger execution tests

### Test Data Files

- **`src/test/resources/sample-data/carryover-request-valid.json`** - Valid request data
- **`src/test/resources/sample-data/carryover-response-expected.json`** - Expected response data
- **`src/test/resources/sample-data/error-responses.json`** - Error response templates

## Test Categories

### 1. Happy Path Tests
- ✅ Valid carryover calculation requests
- ✅ Successful response validation
- ✅ Proper status codes (200)
- ✅ Response data structure validation
- ✅ Direct flow testing

### 2. Error Scenario Tests
- ❌ Missing required parameters (year, month)
- ❌ Invalid parameter types
- ❌ Boundary condition testing
- ❌ Error response validation (400, 500 status codes)

### 3. APIKit Error Handler Tests
- 🔧 APIKIT:BAD_REQUEST (400)
- 🔧 APIKIT:NOT_FOUND (404)
- 🔧 APIKIT:METHOD_NOT_ALLOWED (405)
- 🔧 APIKIT:NOT_ACCEPTABLE (406)
- 🔧 APIKIT:UNSUPPORTED_MEDIA_TYPE (415)
- 🔧 APIKIT:NOT_IMPLEMENTED (501)

### 4. Integration Tests
- 🔄 End-to-end API flow testing
- 🔄 Data transformation validation
- 🔄 Logger execution verification
- 🔄 Performance testing (multiple calls)

### 5. Console Endpoint Tests
- 📋 API console accessibility
- 📋 Console endpoint response validation

## Running Tests

### Option 1: Using the Test Runner Script (Recommended)

```bash
# Make sure the script is executable
chmod +x run-munit-tests.sh

# Run all MUnit tests
./run-munit-tests.sh
```

### Option 2: Using Maven Directly

```bash
# Run MUnit tests (skip by default in CI/CD)
mvn clean test -DskipMunitTests=false

# Run specific test suite
mvn clean test -DskipMunitTests=false -Dmunit.test=acb-carryover-calc-api-test-suite.xml

# Run tests with verbose output
mvn clean test -DskipMunitTests=false -X
```

### Option 3: Using Anypoint Studio

1. Right-click on the test file in Package Explorer
2. Select "Run As" > "MUnit Test"
3. View results in the MUnit Test Results view

## Test Configuration

### Maven Configuration

The MUnit tests are configured in `pom.xml` with the following key settings:

```xml
<!-- MUnit plugin configured to skip tests by default -->
<plugin>
    <groupId>com.mulesoft.munit.tools</groupId>
    <artifactId>munit-maven-plugin</artifactId>
    <version>3.2.1</version>
    <configuration>
        <!-- Skip MUnit tests by default (CI/CD builds) -->
        <skipMunitTests>true</skipMunitTests>
    </configuration>
</plugin>

<!-- Property to control test execution -->
<properties>
    <skipMunitTests>true</skipMunitTests>
</properties>
```

### CI/CD Integration

**Important:** MUnit tests are configured to **NOT run** during CI/CD pipeline builds by default. This ensures:

- 🚀 Faster CI/CD pipeline execution
- 🔒 No interference with deployment processes  
- 🎯 Tests run only when explicitly requested by developers

To enable tests in CI/CD (if needed):
```bash
mvn clean install -DskipMunitTests=false
```

## Test Results and Reports

### Viewing Test Results

1. **Console Output**: Real-time test execution status
2. **Surefire Reports**: `target/surefire-reports/` (XML format)
3. **MUnit Reports**: `target/munit-reports/` (HTML format)

### HTML Report

Open the detailed HTML report:
```bash
open target/munit-reports/munit-report.html
```

The HTML report includes:
- Test execution summary
- Individual test case results
- Code coverage metrics
- Execution timeline
- Error details and stack traces

## Best Practices

### Running Tests During Development

1. **Before committing code**: Run full test suite
```bash
./run-munit-tests.sh
```

2. **During development**: Run specific test categories
```bash
mvn test -DskipMunitTests=false -Dtest="*integration*"
```

3. **Debugging tests**: Use Studio's debug mode or add breakpoints

### Maintaining Tests

1. **Update tests** when API changes
2. **Add new tests** for new endpoints or functionality  
3. **Keep test data current** with business requirements
4. **Review test coverage** regularly

## Troubleshooting

### Common Issues

1. **Tests not running**
   - Verify `skipMunitTests` property is set to `false`
   - Check Maven configuration

2. **Connection errors**
   - Ensure no other applications are using port 8081
   - Verify HTTP connector configuration

3. **Assertion failures**
   - Check expected vs actual data
   - Verify API response structure
   - Update test data if business logic changed

### Debug Mode

Enable debug logging:
```bash
mvn test -DskipMunitTests=false -Dmule.test.debug=true
```

## Coverage Metrics

The test suite provides coverage for:
- ✅ All API endpoints
- ✅ Error handling scenarios  
- ✅ Data transformation logic
- ✅ APIKit routing
- ✅ Response formatting

Target coverage: 95%+ of critical business logic

## Test Inventory

### Main Test Suite (17 tests total)
1. `get-carryover-success-test` - Happy path HTTP request
2. `get-carryover-flow-direct-test` - Direct flow testing
3. `get-carryover-missing-year-parameter-test` - Missing year parameter
4. `get-carryover-missing-month-parameter-test` - Missing month parameter
5. `get-carryover-invalid-year-parameter-test` - Invalid year parameter
6. `get-carryover-invalid-month-parameter-test` - Invalid month parameter
7. `test-apikit-bad-request-error-handler` - APIKit BAD_REQUEST handler
8. `test-apikit-not-found-error-handler` - APIKit NOT_FOUND handler
9. `test-apikit-method-not-allowed-error-handler` - APIKit METHOD_NOT_ALLOWED handler
10. `test-api-console-access` - Console endpoint access
11. `get-carryover-boundary-year-test` - Boundary year testing
12. `get-carryover-boundary-month-test` - Boundary month testing

### Integration Test Suite (4 tests total)
1. `integration-test-full-api-flow` - End-to-end API flow
2. `integration-test-data-transformation` - Data structure validation
3. `integration-test-logger-execution` - Logger verification
4. `performance-test-multiple-calls` - Performance testing

## Support

For questions or issues with MUnit tests:
1. Check this documentation first
2. Review Maven and MUnit logs for specific errors
3. Consult MuleSoft MUnit documentation
4. Contact development team lead

## Version Information

- **MUnit Version**: 3.2.1
- **Mule Runtime**: 4.11.0
- **Test Suite Version**: 1.0
- **Last Updated**: March 2026