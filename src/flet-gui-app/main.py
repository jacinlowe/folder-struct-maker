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
)
from components.tabs import CustomTabs

# Local imports
from structures import StructuresPage
from variables import VariablesPage
from actions import ActionsPage


def get_page_dimensions(page: Page):
    dimensions = (page.width, page.height)
    print(dimensions)
    return dimensions


color_jaguar = "#010109"
color_blue = "#3218f3"
color_blue_gem = "#1d0f96"
color_martinique = "#2f304a"
color_ship_gray = "#47444f"
color_storm_gray = "#71758c"
color_snuff = "#dbdaea"
color_apple = "#508432"


if __name__ == "__main__":

    def main(page: Page):
        page.title = "Struct Maker"
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
        structures_page = StructuresPage(page)
        actions_page = ActionsPage(page)

        def handle_tab_change(e: ControlEvent):
            print(
                f"data:{e.data}, name:{ e.name}, control: {e.control.tabs}, target: {e.target}"
            )

        color_swatches = Row(
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
        app = Column(
            controls=[
                color_swatches,
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
        button_border = ButtonStyle(
            shape={MaterialState.DEFAULT: RoundedRectangleBorder(radius=5)}
        )
        # page.appbar = Row(
        #     controls=[
        #         # TextButton("file", style=button_border),
        #         # TextButton("Edit", style=button_border),
        #         # TextButton("View", style=button_border),
        #         # TextButton("Help", style=button_border),
        #         PopupMenuButton(
        #             content=TextButton("test", disabled=True),
        #             items=[PopupMenuItem(text="item 1"), PopupMenuItem(text="item 2")],
        #             tooltip="",
        #         )
        #     ],
        #     alignment=MainAxisAlignment.START,
        # )

        page.appbar = Container(
            height=35,
            # bgcolor=color_storm_gray,
            # leading_width=10,
            content=Row(
                controls=[
                    TextButton("file", style=button_border),
                    TextButton("Edit", style=button_border),
                    TextButton("View", style=button_border),
                    TextButton("Help", style=button_border),
                ],
                alignment=MainAxisAlignment.START,
            ),
        )
        page.add(app)
        page.update()

    ft.app(target=main, assets_dir="assets")
