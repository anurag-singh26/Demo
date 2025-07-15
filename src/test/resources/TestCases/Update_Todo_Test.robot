*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}          https://hasura.io/learn/graphql
${GRAPHQL_UPDATE}    {"query": "mutation { update_todos(where: {id: {_eq: 457238}}, _set: {is_completed: true, title: \"Software Engineer\"}) { affected_rows returning { id title is_completed } } }"}
${TOKEN}             Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY4NWQyNjViYzg1ZjJhNDFhOTYwMDFmNSJ9LCJuaWNrbmFtZSI6ImFudXJhZy5zaW5naCIsIm5hbWUiOiJhbnVyYWcuc2luZ2hAc3Vud2FyZXRlY2hub2xvZ2llcy5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvODdjZTdmNWFiOGM0NGJhNDcyZDQ4NmZiZTBiOGMzY2E_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZhbi5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyNS0wNy0wOFQwODo1NDozNy4xOTdaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJzdWIiOiJhdXRoMHw2ODVkMjY1YmM4NWYyYTQxYTk2MDAxZjUiLCJpYXQiOjE3NTIxMjY4NTIsImV4cCI6MTc1MjE2Mjg1Miwic2lkIjoidTNXTEdEQzdQLVF4SjRqUGJnQ1B4Y183REo2QWI0V3AiLCJhdF9oYXNoIjoiN05meElVV09Gc0MyWW1SMU5UcjQzQSIsIm5vbmNlIjoidTcxNXppcDZvb21BNjFkMDExSkM2UnpTRm9WOUROWTMifQ.m_Gep9bTLCJBz1qgHaSLLUTbdxnFjfXel_BJEFayR8QIFciQsZMS0kEQcdMnwg_5Ds1_29gzgkNfd9MaYiVvY1xSjbHy5gL9THH7PXQxUQLiaRJl-V-AoWRxaLPpqZpcnqcF9Oqrl6EauV2A3YhK-rk952e56F_W1CCwaBJCwEgoi45NgngzIS5wT3bDWkkahkCD-XOMw89i6S-fRPqHExE-v5loSdb-UzsDAq0IymekGCzJCstI0SfLLWm28mGjbZGjxJ7jndUg7u_Yw2q31L9P1Cvw-I5Lf8iJQTbYbwCk8dljRpLMI34NRerPuzy4iz3Fr7ShHlpBdSM2HMTNXw
${INVALID_TOKEN}    Bearer INVALID_TOKEN

*** Test Cases ***

# Test Case 1: GraphQL Mutation to Update Todo
Update Todo Test
    [Tags]  Regression
    [Documentation]    Test GraphQL mutation to update an existing todo item and validate the updated data.

    # Create session with Authorization Header for Bearer Token
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    Create Session    graphql_session    ${BASE_URL}    headers=${headers}

    # Create the GraphQL mutation string
    ${json_string}=    Catenate
    ...  mutation{
    ...  update_todos(where: {id: {_eq: 457386}}, _set: {is_completed: true, title: "Software developer"}) {
    ...      affected_rows
    ...      returning {
    ...          id
    ...          title
    ...          is_completed
    ...      }
    ...  }
    ...  }

    # Prepare request body and headers
    ${body}=    Create Dictionary    query=${json_string}
    ${header}=    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json

    # Send GraphQL mutation request to update the todo item
    ${response}=    POST Request    graphql_session    ${BASE_URL}    data=${body}    headers=${header}

    # Log the response for debugging
    Log to console    Response Status Code: ${response.status_code}
    Log to console    Response Content: ${response.content}

    log to console   ********* 1. Status code assertion  **********

    # Status code assertion
    ${status_code}=    Convert to String    ${response.status_code}
    Should Be Equal    ${status_code}    200

# Test Case 2: Invalid Token Test
Invalid Token Test
    [Tags]  Regression

    [Documentation]    Test GraphQL mutation with an invalid token and check for unauthorized error.

    # Create session with Authorization Header for invalid Token

    ${headers}=    Create Dictionary    Authorization=${INVALID_TOKEN}    Content-Type=application/json
    Create Session    graphql_session    ${BASE_URL}    headers=${headers}

    # Create the GraphQL mutation string
    ${json_string}=    Catenate
        ...  mutation{
        ...    update_todos(where: {id: {_eq: 457386}}, _set: {is_completed: true, title: "Invalid Token"}) {
        ...      affected_rows
        ...      returning {
        ...          id
        ...          title
        ...          is_completed
        ...      }
        ...  }
        ...  }

    # Prepare request body and headers
    ${body}=    Create Dictionary    query=${json_string}
    ${header}=    Create Dictionary    Authorization=${invalid_token}    Content-Type=application/json

    # Send GraphQL mutation request with invalid token
    ${response}=    POST Request    graphql_session    ${BASE_URL}    data=${body}    headers=${header}

    # Log the response for debugging
    Log to console    Response Status Code: ${response.status_code}
    Log to console    Response Content: ${response.content}

    # Status code assertion for Unauthorized error
    Should Be Equal As Numbers    ${response.status_code}    200

    ${response_body}=    Convert to String    ${response.content}
    Should Contain    ${response_body}    unauthorized

# Test Case 3: Invalid Query Test
Invalid Query Test
    [Documentation]    Test GraphQL mutation with an invalid query syntax and check for errors.

    # Create session with Authorization Header for Bearer Token
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    Create Session    graphql_session    ${BASE_URL}    headers=${headers}

    # Create an invalid GraphQL mutation string
    ${json_string}=    Catenate
        ...  mutation{
        ...    update_todos(where: {id: {_eq: 457386}}, _set: {wrong_field: "invalid"}) {
        ...      affected_rows
        ...      returning {
        ...          id
        ...          title
        ...          is_completed
        ...      }
        ...  }
        ...  }

    # Prepare request body and headers
    ${body}=    Create Dictionary    query=${json_string}
    ${header}=    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json

    # Send GraphQL mutation request with invalid query
    ${response}=    POST Request    graphql_session    ${BASE_URL}    data=${body}    headers=${header}

    # Log the response for debugging
    Log to console    Response Status Code: ${response.status_code}
    Log to console    Response Content: ${response.content}

    # Status code assertion for Bad Query
    Should Be Equal As Numbers    ${response.status_code}    200

    ${response_body}=    Convert to String    ${response.content}
    Should Contain    ${response_body}    wrong_field

# Test Case 4: Missing Token Test
Missing Token Test
    [Tags]  Regression
    [Documentation]    Test GraphQL mutation without Authorization header (missing token).

    # Create session without Authorization Header
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    graphql_session    ${BASE_URL}    headers=${headers}

    # Create the GraphQL mutation string
    ${json_string}=    Catenate
        ...  mutation{
        ...    update_todos(where: {id: {_eq: 457386}}, _set: {is_completed: true, title: "Missing Token Test"}) {
        ...      affected_rows
        ...      returning {
        ...          id
        ...          title
        ...          is_completed
        ...      }
        ...  }
        ...  }

    # Prepare request body and headers
    ${body}=    Create Dictionary    query=${json_string}
    ${header}=    Create Dictionary    Content-Type=application/json

    # Send GraphQL mutation request without token
    ${response}=    POST Request    graphql_session    ${BASE_URL}    data=${body}    headers=${header}

    # Log the response for debugging
    Log to console    Response Status Code: ${response.status_code}
    Log to console    Response Content: ${response.content}

    # Status code assertion for Missing Token error
    Should Be Equal As Numbers    ${response.status_code}    200

    ${response_body}=    Convert to String    ${response.content}
    Should Contain    ${response_body}    unauthorized
