import flet

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
)

from flet_layout import Layout


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
        )
        page.theme.page_transitions.windows = "cupertino"
        page.fonts = {
            "Spartan": "Fonts/LeagueSpartan-Regular.ttf",
            "Spartan-Medium": "Fonts/LeagueSpartan-Medium.ttf",
            "Spartan-Bold": "Fonts/LeagueSpartan-Bold.ttf",
            "Spartan-SemiBold": "Fonts/LeagueSpartan-SemiBold.ttf",
        }
        # page.bgcolor = colors.BLUE_GREY_200
        page.bgcolor = color_martinique
        page.update()
        app = Layout(page)

        page.add(app)
        page.update()

    flet.app(target=main, assets_dir="assets")
