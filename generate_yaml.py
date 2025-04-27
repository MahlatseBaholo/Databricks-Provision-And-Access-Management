import yaml
import json
import sys

def terraform_to_yaml(terraform_vars_file):
    # Read the terraform.tfvars
    with open(terraform_vars_file, 'r') as f:
        terraform_vars = json.load(f)

    catalog_definitions = terraform_vars['catalog_definitions']
    access_config = {}

    for catalog, details in catalog_definitions.items():
        # Define catalog info
        catalog_info = {
            'schema_names': details['schema_names'],
            'catalog_access': details['catalog_access'],
            'schema_access': {}
        }

        # Add schema-specific access
        for schema, access in details['schema_access'].items():
            catalog_info['schema_access'][schema] = access
        
        access_config[catalog] = catalog_info

    # Write the YAML file
    with open('access_config.yaml', 'w') as yaml_file:
        yaml.dump(access_config, yaml_file, default_flow_style=False)

if __name__ == "__main__":
    terraform_to_yaml(sys.argv[1])
