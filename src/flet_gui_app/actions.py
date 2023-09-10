import threading
import time
from typing import Any, List, Optional, Union
import flet as ft


from flet import (
    UserControl,
    Container,
    colors,
    margin,
    alignment,
    Column,
    Row,
    Text,
    Page,
    MainAxisAlignment,
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


class ActionsPage(Column):
    def __init__(self, page: Page):
        super().__init__()
        self.page = page
        self.horizontal_alignment = "center"
        # self.alignment = MainAxisAlignment.CENTER
        # self.wrap = True
        self.scroll = True
        self.width = self.page.width - 10
        self.height = self.page.height - 10
        self.controls.append(
            Container(
                Text("we are at the Actions page testing for sure"),
                padding=5,
                width=800,
                height=500,
                bgcolor=colors.GREEN,
                margin=margin.all(10),
            )
        )

    def build(self):
        # return Column(
        #     controls=[
        #         Container(
        #             Text("we are at the Actions page testing for sure"),
        #             padding=5,
        #             width=800,
        #             height=500,
        #             bgcolor=colors.GREEN,
        #             margin=margin.all(10),
        #         )
        #     ]
        # )
        pass
        # self.update()
        # self.page.update()
        # return self
