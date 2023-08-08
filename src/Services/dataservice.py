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
            {"key": key, "value": str(value)}
            for key, value in dict(data_load.load_data()).items()
        ]
        print(f"attribute data: {self.variables} loaded from: {attribute_file}")


class PresetService:
    file_path = r"src\Services\presets.json"

    def __init__(self) -> None:
        self.presets: dict = {}

    def add_preset(self, key, value):
        self.presets[key] = value

    def get_presets(self) -> dict[str]:
        return self.presets

    def clear_presets(self):
        self.presets = {}

    def update_preset(self, key: str, value: any):
        self.presets[key] = value

    def save_preset(self):
        data_saver = DataService(self.file_path)
        data_saver.save_data(self.presets)

    def load(self):
        data_load = DataService(self.file_path)
        self.presets = dict(data_load.load_data())
        print(f"preset data {self.presets} loaded from: {self.file_path}")


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
