#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token (retrieved from environment variables)
USERNAME="$username"
TOKEN="$token"

# User and Repository information
REPO_OWNER="$1"
REPO_NAME="$2"

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"
    
    # Send a GET request to the GitHub API with authentication, checking for errors
    response=$(curl -s -u "${USERNAME}:${TOKEN}" "$url")
    
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to fetch data from GitHub API."
        exit 1
    fi
    
    echo "$response"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Ensure repository owner and name are provided
if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
    echo "Usage: $0 <repo_owner> <repo_name>"
    exit 1
fi

# Main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access

