from typing import Any, Callable, List, Optional, Union
import flet as ft

from flet import (
    UserControl,
    Page,
    alignment,
    Text,
    Container,
    Row,
    colors,
    margin,
    Column,
    MainAxisAlignment,
    CrossAxisAlignment,
    ResponsiveRow,
    ControlEvent,
    BoxShadow,
    Checkbox,
    ListView,
    TextButton,
    ButtonStyle,
    MaterialState,
    ElevatedButton,
    icons,
    RoundedRectangleBorder,
    DragTargetAcceptEvent,
    AlertDialog,
    TextField,
)

import time, threading
from flet_core.buttons import ButtonStyle

from flet_core.control import Control, OptionalNumber
from flet_core.ref import Ref
from flet_core.types import (
    AnimationValue,
    ClipBehavior,
    OffsetValue,
    ResponsiveNumber,
    RotateValue,
    ScaleValue,
)
from components.tree_components import Folder, File

button_style = ButtonStyle(
    color={MaterialState.PRESSED: colors.BLUE},
    shape={MaterialState.DEFAULT: RoundedRectangleBorder(radius=5)},
)
rounded_button_style = ButtonStyle(
    shape={MaterialState.DEFAULT: RoundedRectangleBorder(radius=5)}
)
selected_button_style = ButtonStyle(
    shape={MaterialState.DEFAULT: RoundedRectangleBorder(radius=5)},
    bgcolor={MaterialState.DEFAULT: colors.RED_300},
)
color_snuff = "#dbdaea"


class SelectableButton(TextButton):
    def __init__(
        self, selected: bool | None = None, on_click: Any | None = None, *args, **kwargs
    ):
        super().__init__(*args, **kwargs)
        self._is_selected = selected
        self.capture_on_click = on_click
        self.on_click = self._handle_on_click

    @property
    def is_selected(self):
        return self._is_selected

    @is_selected.setter
    def is_selected(self, is_selected: bool):
        self._is_selected = is_selected
        if self.is_selected:
            self.style = selected_button_style
        else:
            self.style = rounded_button_style

    def _handle_on_click(self, e):
        # self.toggle_is_selected()
        self.capture_on_click(e)
        # self.is_selected = not self.is_selected

        self.update()


class PresetSelections(UserControl):
    selected_preset = None

    def __init__(self, page: Page):
        super().__init__()
        self.page = page
        self.list_view: ListView[TextButton] = ListView(
            expand=1, spacing=5, padding=10, auto_scroll=True
        )
        self.container = Column(
            alignment=alignment.center,
            controls=[
                ResponsiveRow(
                    columns=2,
                    controls=[
                        ElevatedButton(
                            "Add Preset",
                            icon=icons.ADD,
                            col=1,
                            style=rounded_button_style,
                            on_click=self.add_preset,
                        ),
                        ElevatedButton(
                            "Remove Preset",
                            icon=icons.DELETE,
                            col=1,
                            style=rounded_button_style,
                            on_click=self.remove_preset,
                        ),
                    ],
                    alignment=alignment.center,
                ),
                self.list_view,
            ],
        )

    def select_preset(self, e: ControlEvent):
        event_button = e.control
        self.reset_selected()
        for btn in self.list_view.controls:
            if event_button.data == btn.data:
                btn.is_selected = not btn.is_selected
                self.selected_preset = event_button.data
        self.update()

    def reset_selected(self):
        for btn in self.list_view.controls:
            btn.is_selected = False
            btn.update()
        self.update()

    def handle_add_preset(self, name: str):
        index = len(self.list_view.controls)
        self.reset_selected()
        btn = SelectableButton(
            text=name if name is not None else f"Preset {index+1}",
            style=button_style,
            data=str(index),
            selected=True,
            on_click=self.select_preset,
        )
        self.list_view.controls.append(btn)
        self.update()
        btn.update()

    def add_preset(self, e: ControlEvent):
        # Present a popover window to add name

        preset_name_modal = ModalBox(
            self.page,
            self.handle_add_preset,
            "Preset Name",
            "Please add a preset name.",
        )
        self.page.dialog = preset_name_modal
        preset_name_modal.open_alert()

    def remove_preset(self, e: ControlEvent):
        for i, btn in enumerate(self.list_view.controls):
            if btn.is_selected == True:
                self.list_view.controls.pop(i)
        self.update()

    def build(self):
        self.list_view.controls = [
            SelectableButton(
                text=f"Preset {i+1}",
                style=button_style,
                data=str(i),
                selected=True if i == 1 else False,
                on_click=self.select_preset,
            )
            for i in range(0, 5)
        ]
        return self.container


class PresetTreeView(UserControl):
    def __init__(self, page: Page):
        super().__init__()
        self.page = page

    def build(self):
        self.list_view = ListView(
            col=8,
            expand=1,
            spacing=5,
            padding=10,
            auto_scroll=True,
        )
        self.list_view.controls += [
            Folder(f"test {i+1}", self.handle_drag) for i in range(0, 5)
        ]
        self.list_view.controls += [
            File(f"test asdfsefsefsefeaefaefeafef{i+1}", "") for i in range(0, 5)
        ]
        # self.list_view.controls += [
        #     Folder("idk", self.handle_drag, children=[File("test who", "")])
        # ]

        col = Column(
            alignment=MainAxisAlignment.CENTER,
            expand=True,
            controls=[
                # Text("Tree view"),
                # ResponsiveRow(controls=[Container(col=4),
                ResponsiveRow(
                    # columns=3,
                    controls=[
                        ElevatedButton(
                            "Add File",
                            icon=icons.FILE_COPY,
                            col=3,
                            style=rounded_button_style,
                            width=10,
                            on_click=self.add_file,
                        ),
                        ElevatedButton(
                            "Add Folder",
                            icon=icons.CREATE_NEW_FOLDER,
                            col=3,
                            style=rounded_button_style,
                            on_click=self.add_folder,
                        ),
                        ElevatedButton(
                            "Create Action",
                            icon=icons.LOCAL_ATTRACTION,
                            col=3,
                            style=rounded_button_style,
                            # on_click=self.remove_preset,
                        ),
                    ],
                    alignment=MainAxisAlignment.CENTER,
                ),
                self.list_view
                #  ]),
            ],
            horizontal_alignment=CrossAxisAlignment.CENTER,
        )
        return col

    def add_file(self, e):
        self.list_view.controls.append(File(f"test add file", ""))
        self.update()

    def add_folder(self, e):
        self.list_view.controls.append(Folder("test add", self.handle_drag))
        self.update()

    def create_action(self, e):
        print("Action Created")

    def handle_drag(self, e: DragTargetAcceptEvent):
        print("Treeview call: ", e.control, e.target, e.src_id)
        src_item = self.page.get_control(e.src_id)
        for index, control in enumerate(self.list_view.controls):
            if type(control) == Folder:
                target_folder_uid = control.controls[0].content.uid
                if target_folder_uid == e.target:
                    target_folder = control

            for child in control.controls:
                if child.uid == e.src_id:
                    source_control = self.list_view.controls[index]

        target_folder.add_item_to_folder(
            File(source_control.file_name, source_control.data)
        )
        # del source_control
        e.control.update()
        self.list_view.update()

        # self.update()


class StructuresPage(Column):
    def __init__(self, page: Page):
        super().__init__()
        self.page = page
        self.page.on_resize = self.resize_page_items

        self.presets = PresetSelections(self.page)
        self.tree_view = PresetTreeView(self.page)
        self.left_container = Container(
            alignment=alignment.center,
            border_radius=5,
            border=ft.border.all(1, colors.BLACK12),
            padding=5,
            bgcolor=color_snuff,
            shadow=[
                BoxShadow(
                    spread_radius=5.0,
                    blur_radius=5.0,
                    color=colors.BLUE_GREY_300,
                    offset=ft.Offset(1, 5),
                    blur_style=ft.ShadowBlurStyle.NORMAL,
                )
            ],
            margin=margin.Margin(10, 5, 2, 5),
            content=self.presets,
        )
        self.right_container = Container(
            alignment=alignment.center,
            border=ft.border.all(1, colors.BLACK12),
            border_radius=5,
            padding=5,
            bgcolor=color_snuff,
            shadow=[
                BoxShadow(
                    spread_radius=5.0,
                    blur_radius=5.0,
                    color=colors.BLUE_GREY_300,
                    offset=ft.Offset(0, 5),
                    blur_style=ft.ShadowBlurStyle.NORMAL,
                )
            ],
            margin=margin.Margin(2, 5, 10, 5),
            content=self.tree_view,
        )

        self.controls.append(
            ResponsiveRow(
                alignment=alignment.center,
                # spacing=1,
                expand=True,
                controls=[
                    Column(
                        col=4,
                        controls=[self.left_container],
                    ),
                    Column(
                        col=8,
                        controls=[self.right_container],
                    ),
                ],
            ),
        )

    def resize_page_items(self, e: ControlEvent):
        self.window_width, self.window_height = [float(x) for x in e.data.split(",")]
        print(f"Width: {self.window_width}, Height: {self.window_height}")
        self.left_container.height = self.window_height * 0.9 - 150
        self.right_container.height = self.window_height * 0.9 - 150
        self.update()
        self.page.update()

    def build(self):
        self.update()
        print(self.page.width, self.page.height)
        print(f"({self.width},{self.height})")

        return self
        # self.update()
        # self.page.update()
        # return self


class ModalBox(UserControl):
    def __init__(
        self,
        page: Page,
        callback: Callable[[str], None],
        title: str = "",
        content: str = "",
    ):
        super().__init__()
        self.page = page
        self.callback_fn = callback
        self.preset_name_text = None
        self.preset_name = TextField(label=content)
        self.alert = AlertDialog(
            modal=True,
            title=ft.Text(title),
            content=Column(height=100, controls=[self.preset_name]),
            actions=[
                ft.TextButton("Confirm", on_click=self.close_dlg_yes),
                ft.TextButton("Cancel", on_click=self.close_dlg_no),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
            on_dismiss=lambda e: print("Modal dialog dismissed!"),
        )

    def build(self):
        return self.alert

    def close_dlg_yes(self, e: ControlEvent):
        self.callback_fn(self.preset_name.value)
        self.alert.open = False
        self.update()
        self.page.update()

    def close_dlg_no(self, e: ControlEvent):
        self.alert.open = False
        self.update()
        self.page.update()

    def open_alert(self):
        self.alert.open = True
        self.update()
        self.page.update()
