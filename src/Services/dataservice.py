from __future__ import annotations
import json
from pathlib import Path
import shutil
from typing import Any, Optional, Union, overload
from pydantic import BaseModel
from pydantic.dataclasses import dataclass
from uuid import uuid1

PRESET_FILE_PATH = Path(__file__).parent / "data_store" / r"presets.json"
ATTRIBUTE_FILE_PATH = Path(__file__).parent / "data_store" / r"attributes.json"


def create_preset_id() -> str:
    return str(uuid1())


def create_nested_files(folder: Folder, root_path: Path) -> None:
    for item in folder.children:
        if isinstance(item, File):
            file_path = root_path.joinpath(
                f'{item.file_name}.{item.extension.lstrip(".")}'
            )
            # create parents if they dont exist
            file_path.parent.mkdir(
                exist_ok=True,
            )
            file_path.touch(exist_ok=True)
            # TODO: ADD WRITE DATA INTO FILE
            if item.data != None:
                with open(file_path, "w+") as f:
                    f.write(item.data)

        elif isinstance(item, Folder) and len(item.children) >= 1:
            # Has children
            folder_name = root_path.joinpath(item.folder_name)
            folder_name.mkdir(parents=True, exist_ok=True)
            create_nested_files(item, folder_name)
        else:
            folder_name = root_path.joinpath(item.folder_name)
            folder_name.mkdir(parents=True, exist_ok=True)


def create_structure(preset: Preset, root_path: Path | str) -> None:
    if isinstance(root_path, str):
        root_path = Path(root_path)
    for item in preset.structure:
        if isinstance(item, File):
            file_path = root_path.joinpath(
                f'{item.file_name}.{item.extension.lstrip(".")}'
            )
            # create parents
            file_path.parent.mkdir(
                exist_ok=True,
            )
            file_path.touch(exist_ok=True)

            if item.file_ref is not None:
                # TODO: Check to see if the file exist, Handle the error if it doesnt exist
                try:
                    shutil.copy2(item.file_ref, file_path)
                except FileNotFoundError as e:
                    print(f"File Cannot be found: {e}, Please update the file and path")

            elif item.data != None:
                with open(file_path, "w+") as f:
                    f.write(item.data)

        elif isinstance(item, Folder) and len(item.children) >= 1:
            folder_path = root_path.joinpath(item.folder_name)
            create_nested_files(item, folder_path)
        else:
            folder_path = root_path.joinpath(item.folder_name)
            folder_path.mkdir(exist_ok=True, parents=True)


@dataclass
class File:
    """
    file_ref Must be an absolute path to the file

    Returns:
        _type_: _description_
    """

    file_name: str
    extension: str
    data: Union[Any, None] = None
    file_ref: Union[Path, None] = None

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


@dataclass()
class Attribute:
    key: str
    value: str


class AttributeData(BaseModel):
    attributes: list[Attribute]


class AttributeService:
    def __init__(self):
        self.variables: AttributeData = None
        self.attribute_file = ATTRIBUTE_FILE_PATH
        self.load()

    # def __del__(self):
    #     print(f"destroying object: {type(self)}")
    #     self.save_attributes()

    def add_attribute(
        self,
        attribute: Attribute = None,
        k: str = None,
        v: str = None,
    ) -> None:
        print(k, v, attribute)
        if attribute is None:
            self.variables.attributes.append(Attribute(k, v))

        else:
            self.variables.attributes.append(attribute)

    def get_attributes(self) -> list[Attribute]:
        return self.variables.attributes

    def clear_attributes(self) -> None:
        self.variables.attributes = []

    def update_attribute(self, index, key, value) -> None:
        # TODO: Want to change this and just run a search for the items in dict.
        # may not even need to use a list at all
        if 0 <= index < len(self.variables):
            self.variables.attributes[index].key = key
            self.variables.attributes[index].value = value

    def save_attributes(self):
        data_saver = DataService(self.attribute_file)

        data_saver.save_data(self.variables.model_dump())

    def load(self):
        data_load = DataService(self.attribute_file)
        # try:
        data = data_load.load_data()

        self.variables = AttributeData.model_validate(data)
        # print(data)
        # self.variables.attributes = [
        #     Attribute(key, str(value)) for key, value in dict(data).items()
        # ]
        print(f"attribute data: {self.variables} loaded from: {self.attribute_file}")

    # except TypeError as e:
    #     self.variables = AttributeData(attributes=[])
    #     print(
    #         f"No attribute data: {self.variables} loaded from: {self.attribute_file}"
    #     )


class PresetService:
    file_path = PRESET_FILE_PATH

    def __init__(self) -> None:
        self._presets: PresetData = PresetData(presets=[])
        self.load()

    # def __del__(self):
    #     print(f"deleting service: {type(self)}")

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
        self.file_path: str | Path = file_path

    def save_data(self, data):
        if isinstance(self.file_path, Path):
            self.file_path.parent.mkdir(exist_ok=True, parents=True)
        with open(self.file_path, "w") as file:
            json.dump(data, file, indent=4)

    def load_data(self):
        try:
            with open(self.file_path, "r") as file:
                return json.load(file)
        except FileNotFoundError as e:
            print(e)
            return None

        except PermissionError as e:
            print(f"Permission Error: {e}")
            return None


# def save_presets(presets: list[Preset]):
#     dataservice = DataService("./src/Services/presets.json")
#     data = PresetData(presets=presets)
#     dataservice.save_data(data.model_dump())


# def load_presets() -> PresetData:
#     dataservice = DataService("./src/Services/presets.json")
#     data = dataservice.load_data()
#     return PresetData.model_validate(data)


def seed_attributes() -> None:
    attribute = Attribute("project_name", "Happy go lucky")
    attribute2 = Attribute("Client", "Mosaic Group")
    attribute3 = Attribute("User", "AL_2")
    attribute4 = Attribute("User2", "AL_adfsweff")
    attribute_service = AttributeService()
    attribute_service.add_attribute(k="test", v="blue")
    attribute_service.add_attribute(attribute)

    attribute_service.add_attribute(attribute2)
    attribute_service.add_attribute(attribute3)
    attribute_service.add_attribute(attribute4)
    attribute_service.save_attributes()


def seed_presets() -> None:
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


def test_create_folders() -> None:
    preset_service = PresetService()
    first_preset = preset_service.get_presets()[0]
    test_folder = Path().cwd().joinpath("test_folder")
    test_folder.mkdir(parents=True, exist_ok=True)
    create_structure(first_preset, test_folder)


def read_byte_data() -> None:
    with open(Path.cwd() / "dummy data/dummy project.aep", "r") as f:
        print([i.decode("utf-8") for i in f.readlines()])


if __name__ == "__main__":
    seed_attributes()
    # read_byte_data()
