import json
from jinja2 import Template

def load_devices(filename):
    with open(filename, "r", encoding="utf-8") as file:
        return json.load(file)

def load_template(filename):
    with open(filename, "r", encoding="utf-8") as file:
        return Template(file.read())

def generate_configs(devices, template):
    for device in devices:
        output = template.render(**device)
        filename = f"{device['name']}.txt"

        with open(filename, "w", encoding="utf-8") as file:
            file.write(output)

        print(f"Generated configuration file: {filename}")

def main():
    # Identification for submission screenshot
    print("Student: Jonnathan MacKinnon")
    print("Course: CPT201 - Week 2 Learning Activity 1\n")

    devices = load_devices("devices.json")
    template = load_template("config_template.j2")
    generate_configs(devices, template)

if __name__ == "__main__":
    main()