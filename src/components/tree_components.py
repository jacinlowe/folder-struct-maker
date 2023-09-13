from __future__ import annotations
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
    Icon,
    IconButton,
    Draggable,
    DragTarget,
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

folder = icons.FOLDER_OUTLINED
file = icons.INSERT_DRIVE_FILE_OUTLINED

arrow_right = icons.KEYBOARD_ARROW_RIGHT
arrow_down = icons.KEYBOARD_ARROW_DOWN

rounded_button_style = ButtonStyle(
    shape={MaterialState.DEFAULT: RoundedRectangleBorder(radius=5)}
)


class Folder(UserControl):
    def __init__(
        self,
        folder_name: str,
        # page: Page,
        handle_drag: Callable[[ControlEvent], None] | None = None,
        children: list[Folder | File] = None,
    ):
        super().__init__()
        # self.page = page

        self.is_open = False
        self.text = Text(folder_name)
        self.arrow = Icon(name=arrow_right)
        self.expand = True
        self.btn = TextButton(
            # width=150,
            on_click=self.handle_click,
            style=rounded_button_style,
            content=Row(
                alignment=MainAxisAlignment.START,
                controls=[self.arrow, Icon(name=folder), self.text],
            ),
        )
        self.children: Column = Column(visible=False, controls=children)
        self.drag_target_data = None
        self.component = Draggable(
            group="Folder",
            content=DragTarget(
                group="Folder",
                data=self.drag_target_data,
                content=Column(controls=[self.btn, self.children]),
                on_accept=self.drag_accept,
            ),
        )

        self.drag_handler_callback = handle_drag
        if children:
            self.open_folder()

    def add_item_to_folder(self, item: Folder | File):
        self.children.controls.append(item)
        self.update()

    def remove_item_from_folder(self, item):
        for index, i in enumerate(self.children.controls):
            if item == i:
                self.children.controls.pop(index)
        self.update()

    def drag_accept(self, e: ControlEvent):
        self.drag_handler_callback(e)
        if len(self.children.controls) > 0:
            self.children.visible = True
        # self.children.update()
        # self.update()

    def open_folder(self):
        self.arrow = Icon(name=arrow_down)
        self.btn.content.controls[0] = self.arrow
        self.children.visible = True
        self.is_open = True

    def close_folder(self):
        self.arrow = Icon(name=arrow_right)
        self.btn.content.controls[0] = self.arrow
        self.children.visible = False
        self.is_open = False

    def handle_click(self, e):
        print("clicked")
        if self.is_open:
            self.close_folder()
        else:
            self.open_folder()

        self.update()

    def _update_drag_target_data(self):
        self.drag_target_data = self.uid

    def build(self):
        self._update_drag_target_data()
        return self.component


class File(UserControl):
    def __init__(self, file_name: str, data: Any):
        super().__init__()
        self.file_name = file_name
        self.text = Text(self.file_name)
        self.icon = Icon(name=file)
        self.expand = True
        self.data = data
        self.btn = TextButton(
            # width=150,
            style=rounded_button_style,
            content=Row(
                alignment=MainAxisAlignment.START,
                controls=[Container(width=40), self.icon, self.text],
            ),
        )
        self.component = Draggable(content=self.btn, data=self.uid, group="Folder")

    def build(self):
        return self.component
