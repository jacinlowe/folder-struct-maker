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
        self.controls.append(
            Container(
                Text("we are at the Actions page testing"),
                padding=5,
                width=800,
                height=500,
                bgcolor=colors.GREEN,
                margin=margin.all(10),
            )
        )

    def build(self):
        pass
        # self.update()
        # self.page.update()
        # return self
