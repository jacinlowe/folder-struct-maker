from __future__ import annotations
import json
from typing import Any, Union
from pydantic import BaseModel
from pydantic.dataclasses import dataclass
from uuid import uuid1
from pathlib import Path


def create_preset_id() -> str:
    return str(uuid1())


PRESET_FILE_PATH = Path(__file__).parent / r"presets.json"
ATTRIBUTE_FILE_PATH = Path(__file__).parent / r"attributes.json"


@dataclass
class File:
    file_name: str
    extension: str
    data: Union[Any, None] = None

    @property
    def get_file_name(self):
        if self.extension[0] != ".":
            self.extension = f".{self.extension}"
        return self.file_name + self.extension


class Folder(BaseModel):
    folder_name: str
    children: list[Union[Folder, File]] = None


@dataclass
class Preset:
    id: str
    preset_name: str
    structure: Union[list[Union[File, Folder]], None] = None


class PresetData(BaseModel):
    presets: list[Preset]


class AttributeService:
    def __init__(self):
        self.variables = []
        self.attribute_file = ATTRIBUTE_FILE_PATH

    def __del__(self):
        print(f"destroying object: {type(self)}")
        self.save_attributes()

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
        data_saver = DataService(self.attribute_file)
        data_saver.save_data(self.variables)

    def load(self):
        data_load = DataService(self.attribute_file)
        self.variables = [
            {"key": key, "value": str(value)}
            for key, value in dict(data_load.load_data()).items()
        ]
        print(f"attribute data: {self.variables} loaded from: {self.attribute_file}")


class PresetService:
    file_path = PRESET_FILE_PATH

    def __init__(self) -> None:
        self._presets: PresetData = PresetData(presets=[])
        self.load()

    def __del__(self):
        print(f"deleting service: {type(self)}")
        try:
            self.save_preset()
        except IOError:
            print(f"cannot save {self.file_path.name} file quitting")

    def add_preset(self, preset: Preset):
        self._presets.presets.append(preset)
        self.save_preset()

    def get_presets(self) -> list[Preset]:
        return self._presets.presets

    def clear_presets(self):
        self._presets = PresetData(presets=[])

    def update_preset(self, preset_update: Preset):
        for index, preset in enumerate(self._presets.presets):
            if preset.id == preset_update.id:
                self._presets.presets.pop(index)
                self._presets.presets.insert(index, preset_update)

    def get_preset_names(self) -> list[str]:
        result = []
        for i in self._presets.presets:
            result.append(i.preset_name)
        return result

    def save_preset(self):
        data_saver = DataService(self.file_path)
        data_saver.save_data(self._presets.model_dump())

    def load(self):
        data_load = DataService(self.file_path)
        data = data_load.load_data()
        if data:
            self._presets = PresetData.model_validate(data)
            print(f"preset data {self._presets} loaded from: {self.file_path}")


class DataService:
    def __init__(self, file_path: str):
        self.file_path: str = file_path

    def save_data(self, data):
        with open(self.file_path, "w") as file:
            json.dump(data, file, indent=4)

    def load_data(self):
        try:
            print(self.file_path)
            with open(self.file_path, "r") as file:
                return json.load(file)
        except FileNotFoundError as e:
            print(e)
            return None


# def save_presets(presets: list[Preset]):
#     dataservice = DataService("./src/Services/presets.json")
#     data = PresetData(presets=presets)
#     dataservice.save_data(data.model_dump())


# def load_presets() -> PresetData:
#     dataservice = DataService("./src/Services/presets.json")
#     data = dataservice.load_data()
#     return PresetData.model_validate(data)


def create_blank_preset(name: str):
    return Preset(id=create_preset_id(), preset_name=name)


if __name__ == "__main__":
    preset = Preset(
        preset_name="test",
        id=create_preset_id(),
        structure=[
            Folder(
                folder_name="test folder",
                children=[File(file_name="test file 2", extension=".txt")],
            ),
            File(file_name="test file", extension=".txt"),
        ],
    )
    preset2 = Preset(
        preset_name="test2",
        id=create_preset_id(),
        structure=[
            Folder(
                folder_name="test folder",
                children=[File(file_name="test file 2", extension=".txt")],
            ),
            File(file_name="test file", extension=".txt"),
        ],
    )
    preset_service = PresetService()
    preset_service.add_preset(preset)
    preset_service.add_preset(preset2)
    preset2.preset_name = "THis is an update"
    preset_service.update_preset(preset2)
    preset_service.save_preset()
    # print(str(get_unique_id()))
