import inspect
from typing import Any, List, Optional, Union, Literal
import flet

from flet import (
    Container,
    UserControl,
    Icon,
    Page,
    Text,
    AppBar,
    PopupMenuButton,
    PopupMenuItem,
    colors,
    icons,
    margin,
    CrossAxisAlignment,
    View,
    padding,
    TemplateRoute,
    TextField,
    ElevatedButton,
    AlertDialog,
    Column,
    Row,
    Card,
    ResponsiveRow,
    ControlEvent,
    border_radius,
    border,
    NavigationRail,
    NavigationRailDestination,
    NavigationRailLabelType,
    ElevatedButton,
    animation,
    alignment,
    MainAxisAlignment,
    Draggable,
    DragTarget,
    TextStyle,
    TextDecoration,
    DragTargetAcceptEvent,
)
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


class TreeItem(UserControl):
    def __init__(
        self, type: Union[Literal["file"], Literal["folder"]], text: str = None
    ):
        super().__init__()
        self.type = type
        self.text = text

    def build(self):
        if self.type == "folder":
            return DragTarget(
                content=Container(
                    Row(
                        [
                            Icon(name=folder),
                            Text(value=self.text),
                        ]
                    )
                ),
                on_accept=self._drag_accept,
                on_leave=self._drag_leave,
                on_will_accept=self._drag_will_accept,
            )
        return Draggable(
            content=Row(
                [
                    Icon(name=file),
                    Text(value=self.text),
                ]
            ),
            content_feedback=Container(
                border_radius=5,
                border=border.all(2, colors.BLACK45),
                content=Row(
                    [
                        Icon(name=file),
                        Text(
                            value=self.text,
                            size=14,
                            color=colors.BLACK45,
                            style=TextStyle(decoration=TextDecoration.NONE),
                        ),
                    ]
                ),
            ),
        )

    def _drag_will_accept(self, e):
        color = colors.BLACK45 if e.data == "true" else colors.RED
        print(e.data, color)
        e.control.content.border = border.all(2, color=color)
        e.control.content.border_radius = border_radius.all(5)
        e.control.update()

    def _drag_accept(self, e):
        print(self._id, e.src_id)
        e.control.content.border = None
        e.control.update()

    def _drag_leave(self, e):
        e.control.content.border = None
        e.control.update()


class Sidebar(UserControl):
    def __init__(self, layout: UserControl):
        super().__init__()
        self.layout = layout

    def build(self):
        self.container = Container(
            ElevatedButton(
                "Hello world",
                width=len("hello world") * 20,
            ),
            padding=padding.only(top=20, right=5, left=5, bottom=5),
            alignment=alignment.top_center,
            width=200,
            bgcolor=colors.GREEN,
            on_click=self.on_click,
            expand=True,
            border_radius=border_radius.only(top_right=10, bottom_right=10),
            animate=animation.Animation(500, "easeInOutQuart"),
        )

        return self.container

    def on_click(self, e):
        if self.container.width != 500:
            self.container.width = 500

        else:
            self.container.width = 200

        self.update()
        self.layout.update()
        self.layout.page.update()

    def update_height(self, height):
        self.container.height = height
        self.update()


def color_lookup(color: str) -> str:
    color_mod = inspect.getmembers(colors)
    result = color
    for c in color_mod:
        if filter_uppercase_name(c):
            if color == c[1]:
                result = c[1] + str(100)
    return result


class Layout(UserControl):
    def __init__(self, page: Page):
        super().__init__()
        self.page = page
        self.page.on_resize = self.resize_page_items
        self.window_height = 200.0
        self.sidebar = Sidebar(self)

    def resize_page_items(self, e: ControlEvent):
        self.window_width, self.window_height = [float(x) for x in e.data.split(",")]

        self.controllable_container.height = float(self.window_height) / 2
        self.sidebar.update_height(float(self.window_height) - 5.0)
        self.update()
        self.page.update()
        print(self.window_height)

    def build(self):
        self.controllable_container = Container(
            Text("Column 1"),
            padding=5,
            bgcolor=colors.YELLOW,
            col={"sm": 6, "md": 4, "xl": 2},
            border_radius=border_radius.only(top_right=10, bottom_right=10),
            height=self.window_height,
        )
        return Row(
            alignment=MainAxisAlignment.CENTER,
            controls=[
                self.sidebar,
                Column(
                    controls=[
                        ResponsiveRow(
                            controls=[
                                self.controllable_container,
                                Container(
                                    content=Column(
                                        [
                                            TreeItem("folder", "rootbeer"),
                                            TreeItem("file", "test file"),
                                        ]
                                    ),
                                    padding=5,
                                    bgcolor=colors.GREEN_100,
                                    border=border.all(width=2, color=colors.GREEN),
                                    col={"sm": 6, "md": 4, "xl": 2},
                                ),
                                DragTarget(
                                    content=Container(
                                        Text("Column 3"),
                                        padding=5,
                                        bgcolor=colors.BLUE,
                                        col={"sm": 6, "md": 4, "xl": 2},
                                    ),
                                    on_accept=self.drag_accept,
                                    on_leave=self.drag_leave,
                                    on_will_accept=self.drag_will_accept,
                                ),
                                Container(
                                    Text("Column 4"),
                                    padding=5,
                                    bgcolor=colors.PINK_300,
                                    col={"sm": 6, "md": 4, "xl": 2},
                                ),
                                ResponsiveRow(
                                    [
                                        TextField(label="TextField 1", col={"md": 4}),
                                        TextField(label="TextField 2", col={"md": 4}),
                                        TextField(label="TextField 3", col={"md": 4}),
                                    ],
                                    run_spacing={"xs": 10},
                                ),
                            ],
                        ),
                    ],
                    height=500,
                    expand=True,
                ),
            ],
        )

    def drag_will_accept(self, e):
        color = colors.BLACK45 if e.data == "true" else colors.RED
        print(e.data, color)
        e.control.content.border = border.all(2, color=color)
        e.control.content.border_radius = border_radius.all(5)
        e.control.update()

    def drag_accept(self, e: DragTargetAcceptEvent):
        # print(e.target, e.data, e.control.content, e.name)
        # print(e.src_id)
        # Get Item
        # check to see if the container is a column
        # check to see if it exist in the new column
        # add it to the new column
        # remove it from the old location
        if not isinstance(Column, type(e.control.content)):
            content = e.control.content
            print(content.content)
            e.control.content = Column(
                controls=[content, self.page.get_control(e.src_id)]
            )
        e.control.content.border = None
        e.control.update()

    def drag_leave(self, e):
        e.control.content.border = None
        e.control.update()


def filter_uppercase_name(item) -> bool:
    # print(item)
    name, value = item
    return name[0].isupper()


if __name__ == "__main__":
    print(color_lookup(colors.TEAL))
