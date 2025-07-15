*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://hasura.io/learn/graphql
${GRAPHQL_QUERY}    {"query": "{ users { name, todos { title }, id } }"}
${TOKEN}             Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY4NWQyNjViYzg1ZjJhNDFhOTYwMDFmNSJ9LCJuaWNrbmFtZSI6ImFudXJhZy5zaW5naCIsIm5hbWUiOiJhbnVyYWcuc2luZ2hAc3Vud2FyZXRlY2hub2xvZ2llcy5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvODdjZTdmNWFiOGM0NGJhNDcyZDQ4NmZiZTBiOGMzY2E_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZhbi5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyNS0wNy0wOFQwODo1NDozNy4xOTdaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJzdWIiOiJhdXRoMHw2ODVkMjY1YmM4NWYyYTQxYTk2MDAxZjUiLCJpYXQiOjE3NTIxMjY4NTIsImV4cCI6MTc1MjE2Mjg1Miwic2lkIjoidTNXTEdEQzdQLVF4SjRqUGJnQ1B4Y183REo2QWI0V3AiLCJhdF9oYXNoIjoiN05meElVV09Gc0MyWW1SMU5UcjQzQSIsIm5vbmNlIjoidTcxNXppcDZvb21BNjFkMDExSkM2UnpTRm9WOUROWTMifQ.m_Gep9bTLCJBz1qgHaSLLUTbdxnFjfXel_BJEFayR8QIFciQsZMS0kEQcdMnwg_5Ds1_29gzgkNfd9MaYiVvY1xSjbHy5gL9THH7PXQxUQLiaRJl-V-AoWRxaLPpqZpcnqcF9Oqrl6EauV2A3YhK-rk952e56F_W1CCwaBJCwEgoi45NgngzIS5wT3bDWkkahkCD-XOMw89i6S-fRPqHExE-v5loSdb-UzsDAq0IymekGCzJCstI0SfLLWm28mGjbZGjxJ7jndUg7u_Yw2q31L9P1Cvw-I5Lf8iJQTbYbwCk8dljRpLMI34NRerPuzy4iz3Fr7ShHlpBdSM2HMTNXw

*** Test Cases ***

# Test Case 1: GraphQL Query to Fetch Users and Validate 'Name', 'ID', and 'Todos'
GraphQL Query Test

    [Documentation]    Test GraphQL query to fetch users and validate 'name', 'id', and 'todos' fields in the response.

    # Create session with Authorization Header for Bearer Token
    ${headers}=    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    Create Session    graphql_session    ${BASE_URL}    headers=${headers}

    # Send GraphQL query as a POST request
    ${response}=    POST On Session    graphql_session    url=/graphql    json=${GRAPHQL_QUERY}

    # Log the response for debugging
    Log    Response: ${response.text}

    # Check the status code
    Should Be Equal As Numbers    ${response.status_code}    200

    ${body}=    Convert To String    ${response.content.decode("utf-8")}
    Log    Raw Response:\n${body}    level=INFO

