import os
import _thread as thread
import logging

import flet as ft

from flet import (
    Page,
    colors,
    Theme,
    UserControl,
    ResponsiveRow,
    Container,
    Text,
    TextField,
    AppBar,
    Icon,
    icons,
    Theme,
    ColorScheme,
    SafeArea,
    ControlEvent,
    Column,
    TextButton,
    Row,
    MainAxisAlignment,
    Tabs,
    Tab,
    alignment,
    TextTheme,
    TextStyle,
    View,
    CrossAxisAlignment,
    ButtonStyle,
    MaterialState,
    RoundedRectangleBorder,
    PopupMenuButton,
    PopupMenuItem,
    RadialGradient,
    Alignment,
    IconButton,
    ElevatedButton,
    WindowDragArea,
)

from components.tabs import CustomTabs

# Local imports
from structures import StructuresPage
from variables import VariablesPage
from actions import ActionsPage

logging.basicConfig(level=logging.DEBUG)


def get_page_dimensions(page: Page):
    dimensions = (page.width, page.height)
    logging.log(3, dimensions)
    return dimensions


color_jaguar = "#010109"
color_blue = "#3218f3"
color_blue_gem = "#1d0f96"
color_martinique = "#2f304a"
color_ship_gray = "#47444f"
color_storm_gray = "#71758c"
color_snuff = "#dbdaea"
color_apple = "#508432"
button_border = ButtonStyle(
    color=colors.WHITE70,
    shape={MaterialState.DEFAULT: RoundedRectangleBorder(radius=5)},
)


def create_color_swatches():
    return Row(
        controls=[
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color_apple),
                    Text("Apple"),
                ]
            ),
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color_blue),
                    Text("blue"),
                ]
            ),
            Column(
                controls=[
                    Container(
                        width=50,
                        height=50,
                        bgcolor=color_blue_gem,
                    ),
                    Text("Blue Gem"),
                ]
            ),
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color_jaguar),
                    Text("Jaguar"),
                ]
            ),
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color_martinique),
                    Text("Martinque"),
                ]
            ),
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color_snuff),
                    Text("Snuff"),
                ]
            ),
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color_storm_gray),
                    Text("Grey"),
                ]
            ),
        ],
        alignment=MainAxisAlignment.CENTER,
    )


def exit_program(e: ControlEvent):
    print("exiting app")
    e.page.window_destroy()


def maximize_window(e):
    e.page.window_maximized = not e.page.window_maximized
    e.page.update()


def app_bar(page: Page):
    return WindowDragArea(
        Row(
            controls=[
                Row(
                    controls=[
                        TextButton("File", style=button_border),
                        TextButton("Edit", style=button_border),
                        TextButton("View", style=button_border),
                        TextButton("Help", style=button_border),
                    ],
                    spacing=0,
                ),
                Row(
                    controls=[
                        # Maximize
                        ElevatedButton(
                            width=20,
                            height=20,
                            style=ButtonStyle(shape=RoundedRectangleBorder(radius=50)),
                            bgcolor=colors.GREEN_500,
                            on_click=maximize_window,
                        ),
                        # Minimize
                        ElevatedButton(
                            width=20,
                            height=20,
                            style=ButtonStyle(shape=RoundedRectangleBorder(radius=50)),
                            bgcolor=colors.YELLOW_500,
                        ),
                        # Exit
                        ElevatedButton(
                            width=20,
                            height=20,
                            style=ButtonStyle(shape=RoundedRectangleBorder(radius=50)),
                            bgcolor=colors.RED_500,
                            on_click=exit_program,
                        ),
                        # Spacer
                        Container(width=20, height=35),
                    ],
                ),
                # alignment=MainAxisAlignment.CENTER,
            ],
            alignment=MainAxisAlignment.SPACE_BETWEEN,
        )
    )


def generate_color_swatches(colors: list[str]):
    color_list = []
    for color in colors:
        color_list.append(
            Column(
                controls=[
                    Container(width=50, height=50, bgcolor=color),
                    Text(color, color="white"),
                ]
            )
        )
    return Row(controls=color_list, alignment=MainAxisAlignment.CENTER)


def run_flet_app(preset_service=None, variable_service=None):
    def main(page: Page):
        page.title = "Struct Maker"
        page.window_title_bar_hidden = True
        page.window_title_bar_buttons_hidden = True
        page.padding = 0
        page.theme = Theme(
            font_family="Spartan",
            color_scheme=ColorScheme(
                primary="5FC0E7", secondary="E2EDF9", tertiary="DFECE0"
            ),
            # text_theme=TextTheme(
            #     label_medium=TextStyle(color=colors.WHITE60),
            #     label_large=TextStyle(color=colors.WHITE60),
            #     label_small=TextStyle(color=colors.WHITE60),
            #     body_large=TextStyle(color=colors.WHITE60),
            #     body_medium=TextStyle(color=colors.WHITE60),
            #     body_small=TextStyle(color=colors.WHITE60),
            #     display_large=TextStyle(color=colors.WHITE60),
            #     display_medium=TextStyle(color=colors.WHITE60),
            #     display_small=TextStyle(color=colors.WHITE60),
            #     title_large=TextStyle(color=colors.WHITE60),
            #     title_medium=TextStyle(color=colors.WHITE60),
            #     title_small=TextStyle(color=colors.WHITE60),
            #     headline_large=TextStyle(color=colors.WHITE60),
            #     headline_medium=TextStyle(color=colors.WHITE60),
            #     headline_small=TextStyle(color=colors.WHITE60),
            # ),
        )
        page.theme.page_transitions.windows = "cupertino"
        page.fonts = {
            "Spartan": "Fonts/LeagueSpartan-Regular.ttf",
            "Spartan-Medium": "Fonts/LeagueSpartan-Medium.ttf",
            "Spartan-Bold": "Fonts/LeagueSpartan-Bold.ttf",
            "Spartan-SemiBold": "Fonts/LeagueSpartan-SemiBold.ttf",
        }
        # page.bgcolor = colors.BLUE_GREY_200
        # page.bgcolor = color_martinique
        page.horizontal_alignment = CrossAxisAlignment.CENTER
        page.vertical_alignment = MainAxisAlignment.CENTER

        page.update()
        variables_page = VariablesPage(page)
        actions_page = ActionsPage(page)
        if preset_service:
            structures_page = StructuresPage(page, preset_service)
        else:
            structures_page = StructuresPage(page)

        def handle_tab_change(e: ControlEvent):
            print(
                f"data:{e.data}, name:{ e.name}, control: {e.control.tabs}, target: {e.target}"
            )

        color_swatches = create_color_swatches()

        gradient_colors = [
            "#42445f",
            "#393b52",
            "#33354a",
            "#2f3143",
            "#292b3c",
            "#222331",
            "#1a1a25",
            "#1a1b26",
            "#21222f",
            "#1d1e2a",
        ]

        # Main App View
        _main_container = Container(
            expand=True,
            gradient=RadialGradient(
                center=Alignment(0, -1.25), radius=1.4, colors=gradient_colors
            ),
            content=Container(
                height=35,
                expand=True,
                alignment=alignment.top_center,
                # bgcolor=color_storm_gray,
                # leading_width=10,
                content=Column(
                    controls=[
                        app_bar(page),
                        generate_color_swatches(gradient_colors),
                        Tabs(
                            selected_index=1,
                            on_change=handle_tab_change,
                            animation_duration=300,
                            label_color=colors.WHITE70,
                            unselected_label_color=colors.WHITE60,
                            indicator_tab_size=True,
                            tabs=[
                                Tab(text="Variables", content=variables_page),
                                Tab(text="Structures", content=structures_page),
                                Tab(text="Actions", content=actions_page),
                            ],
                        ),
                    ]
                ),
            ),
        )
        app = Column(
            controls=[
                Tabs(
                    selected_index=1,
                    on_change=handle_tab_change,
                    animation_duration=300,
                    tabs=[
                        Tab(text="Variables", content=variables_page),
                        Tab(text="Structures", content=structures_page),
                        Tab(text="Actions", content=actions_page),
                    ],
                ),
            ]
        )

        page.add(_main_container)
        # page.add(app)
        page.update()

    ft.app(target=main, assets_dir="assets")


if __name__ == "__main__":
    run_flet_app()
