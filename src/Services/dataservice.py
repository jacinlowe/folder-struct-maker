import json


class AttributeService:
    def __init__(self):
        self.variables = []

    def add_attribute(self, key, value):
        self.variables.append({"key": key, "value": value})

    def get_attributes(self) -> list[dict[str]]:
        return self.variables

    def clear_attributes(self):
        self.variables = []

    def update_attribute(self, index, key, value):
        if 0 <= index < len(self.variables):
            self.variables[index]["key"] = key
            self.variables[index]["value"] = value

    def save_attributes(self):
        data_saver = DataService(r"src\Services\attributes.json")
        data_saver.save_data(self.variables)

    def load(self):
        attribute_file = r"src\Services\attributes.json"
        data_load = DataService(attribute_file)
        self.variables = [
            {"key": key, "value": value}
            for key, value in dict(data_load.load_data()).items()
        ]
        print(f"attribute data: {self.variables} loaded from: {attribute_file}")


class DataService:
    def __init__(self, file_path):
        self.file_path = file_path

    def save_data(self, data):
        with open(self.file_path, "w") as file:
            json.dump(data, file, indent=4)

    def load_data(self):
        try:
            with open(self.file_path, "r") as file:
                return json.load(file)
        except FileNotFoundError:
            return []


if __name__ == "__main__":
    data_service = AttributeService()
    data_service.load()
    # print(data_service.load())
    # to Save data
