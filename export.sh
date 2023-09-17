#!/bin/bash

# List all resource types you want to export
resource_types=("pods" "services" "deployments" "configmaps" "secrets" "ingresses")

# Loop through each resource type
for resource_type in "${resource_types[@]}"; do
    # Use `kubectl get` to fetch resources and save them to YAML files
    kubectl get "$resource_type" --all-namespaces -o yaml > "${resource_type}_export.yaml"
done