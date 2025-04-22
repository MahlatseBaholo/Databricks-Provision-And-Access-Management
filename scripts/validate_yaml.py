import yaml
import sys

with open(sys.argv[1], 'r') as f:
    try:
        config = yaml.safe_load(f)
        assert isinstance(config, dict), "Root of YAML must be a dictionary"
        print("YAML structure is valid.")
    except Exception as e:
        print(f"Invalid YAML: {e}")
        sys.exit(1)