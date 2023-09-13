from typing import Any, Dict, List, Optional, Union
import flet as ft
from flet import Tabs, Tab, TabsTheme, UserControl, ControlEvent


class CustomTabs(UserControl):
    def __init__(
        self,
        tabs: List[Tab] | None = None,
        selected_index: int | None = None,
        animation_duration: int | None = None,
        **kwargs,
    ):
        super().__init__()
        self.animation_duration = (
            animation_duration if animation_duration != None else 300
        )
        self.selected_index = selected_index
        self.previous_index = None
        self.tabs = Tabs(
            tabs=tabs,
            selected_index=self.selected_index,
            animation_duration=self.animation_duration,
            on_change=self.handle_on_change,
        )

    def handle_on_change(self, e: ControlEvent):
        self.previous_index = self.selected_index
        self.selected_index = int(e.data)
        e["previous_index"] = self.previous_index
        return e

    def build(self):
        return self.tabs


class DemoCtrl(ft.UserControl):
    def build(self):
        self.expand = True
        tab_items = []
        for tab_idx in range(5):
            tab_items.append(
                ft.Tab(
                    text=f"Tab Nr {tab_idx}",
                    content=ft.Container(ft.Text(f"Content of  Tab Nr ${tab_idx}")),
                )
            )
        tabs = ft.Container(ft.Tabs(tabs=tab_items))
        return ft.Card(ft.Column([ft.Text(f"Name: {self.data}"), tabs]))
