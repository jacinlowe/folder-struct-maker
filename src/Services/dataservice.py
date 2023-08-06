import json


class VariableService:
    def __init__(self):
        self.variables = []

    def add_variable(self, key, value):
        self.variables.append({"key": key, "value": value})

    def get_variables(self) -> list[dict[str]]:
        return self.variables

    def clear_variables(self):
        self.variables = []

    def update_variable(self, index, key, value):
        if 0 <= index < len(self.variables):
            self.variables[index]["key"] = key
            self.variables[index]["value"] = value


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
    data_service = DataService("data.json")

    # to Save data
