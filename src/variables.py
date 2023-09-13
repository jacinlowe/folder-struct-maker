from typing import Callable
import flet as ft
from flet import (
    UserControl,
    Page,
    Container,
    colors,
    alignment,
    Text,
    Column,
    margin,
    Row,
    Dropdown,
    dropdown,
    MainAxisAlignment,
    FilledButton,
    ControlEvent,
    ButtonStyle,
    DataTable,
    DataCell,
    DataColumn,
    DataRow,
    border,
    TextField,
    IconButton,
    icons,
    AlertDialog,
    Stack,
    ScrollMode,
)
from utils import debounce


class VariablesEditor(UserControl):
    cell_changed_fn: Callable = None

    def __init__(self, page: Page):
        super().__init__()
        self.page = page
        self.sorted_data: tuple[int, bool] = (0, False)
        self.table = DataTable(
            width=900,
            bgcolor=colors.GREY_200,
            border=border.all(2, colors.BLACK45),
            border_radius=5,
            sort_column_index=self.sorted_data[0],
            sort_ascending=self.sorted_data[1],
            heading_row_color=colors.BLACK12,
            heading_row_height=50,
            show_checkbox_column=True,
            checkbox_horizontal_margin=0.2,
            horizontal_margin=25,
            vertical_lines=border.BorderSide(1, colors.BLACK38),
            horizontal_lines=border.BorderSide(1, colors.BLACK38),
            column_spacing=50,
            # expand=12,
            columns=[
                DataColumn(
                    Text("Key"),
                    on_sort=self.switch_sort_column_selected,
                ),
                DataColumn(
                    Text("Value"),
                    on_sort=self.switch_sort_column_selected,
                ),
            ],
            rows=[
                DataRow(
                    on_select_changed=self.row_selected,
                    on_long_press=self.delete_row_confirm,
                    cells=[
                        DataCell(
                            content=TextField(
                                border="none",
                                expand=True,
                                on_change=self.updated_values,
                            ),
                        ),
                        DataCell(
                            content=TextField(
                                border="none",
                                expand=True,
                                on_change=self.updated_values,
                            )
                        ),
                    ],
                ),
                DataRow(
                    on_select_changed=self.row_selected,
                    on_long_press=self.delete_row_confirm,
                    cells=[
                        DataCell(
                            TextField(
                                border="none",
                                expand=True,
                                on_change=self.updated_values,
                            )
                        ),
                        DataCell(
                            TextField(
                                border="none",
                                expand=True,
                                on_change=self.updated_values,
                            )
                        ),
                    ],
                ),
            ],
        )

    def switch_sort_column_selected(self, e: ControlEvent):
        index = e.column_index
        is_ascending = e.ascending
        previous_index, previous_ascending = self.sorted_data
        print(previous_ascending, previous_index)
        if index != previous_index or is_ascending != previous_ascending:
            self.sorted_data = (index, is_ascending)
            self.table.update()
            self.update()
            self.page.update()

    def row_selected(self, e: ControlEvent):
        is_selected = e.control.selected
        for row in self.table.rows:
            row.selected = False
        e.control.selected = not is_selected
        print(f"row select changed: {e.data}")
        self.table.update()

    def handle_alert(self, can_delete: bool):
        for i, row in enumerate(self.table.rows):
            if row.data == "deletable":
                if can_delete:
                    print(can_delete)
                    self.table.rows.pop(i)
                else:
                    row.color = None
                    row.data = None

        self.table.update()

    def delete_row_confirm(self, e: ControlEvent):
        print(e.data)
        e.control.color = colors.RED_ACCENT_200
        e.control.data = "deletable"
        # TODO:confirm that they want to delete with an alert dialog
        alert = AlertBox(self.page, self.handle_alert)
        self.page.dialog = alert.alert
        alert.alert.open = True
        self.update()
        self.page.update()

        self.table.update()

    def add_row(self, e: ControlEvent):
        self.table.rows.append(
            DataRow(
                on_select_changed=self.row_selected,
                on_long_press=self.delete_row_confirm,
                cells=[
                    DataCell(
                        TextField(
                            border="none", expand=True, on_change=self.updated_values
                        )
                    ),
                    DataCell(
                        TextField(
                            border="none", expand=True, on_change=self.updated_values
                        )
                    ),
                ],
            ),
        )
        self.table.update()

    def get_key_values(self):
        result = {}
        previous_row_index = 0

        for row_index, row in enumerate(self.table.rows):
            key = None
            for cell_index, cell in enumerate(row.cells):
                # print(f"({row_index},{cell_index}): {cell.content.value}")
                if cell.content.value == "":
                    continue
                if previous_row_index < row_index:
                    previous_row_index = row_index

                if previous_row_index == row_index:
                    if cell_index == 0:
                        key = cell.content.value
                    else:
                        if key != None:
                            result.update({key: cell.content.value})

        return result

    def updated_values(self, e):
        if self.cell_changed_fn != None:
            self.cell_changed_fn()
        # print("change has occured")

    def build(self):
        return self.table


class VariablesPage(Column):
    def __init__(self, page: Page):
        super().__init__()
        self.page = page

        # TEMPLATE SELECTOR
        self.controls.append(
            Container(
                # width=150,
                border_radius=10,
                margin=margin.all(10),
                # bgcolor=colors.WHITE38,
                content=Row(
                    expand=True,
                    alignment=MainAxisAlignment.CENTER,
                    controls=[
                        Text("Template: "),
                        Dropdown(
                            content_padding=10,
                            value="test 1",
                            options=[
                                dropdown.Option("test 1"),
                                dropdown.Option("test 2"),
                                dropdown.Option("test3"),
                            ],
                        ),
                    ],
                ),
                alignment=alignment.center,
            )
        )
        # BUTTONS
        self.controls.append(
            Row(
                alignment=MainAxisAlignment.CENTER,
                controls=[
                    FilledButton(
                        "Add new Variable",
                        on_click=self.add_new_variable,
                        style=ButtonStyle(
                            shape={
                                ft.MaterialState.DEFAULT: ft.buttons.RoundedRectangleBorder(
                                    radius=5
                                )
                            }
                        ),
                    ),
                    FilledButton(
                        "Create Project",
                        on_click=self.create_project,
                        style=ButtonStyle(
                            shape={
                                ft.MaterialState.DEFAULT: ft.buttons.RoundedRectangleBorder(
                                    radius=5
                                )
                            },
                        ),
                    ),
                    FilledButton(
                        "Open Alert modal",
                        on_click=self.open_alert,
                        style=ButtonStyle(
                            shape={
                                ft.MaterialState.DEFAULT: ft.buttons.RoundedRectangleBorder(
                                    radius=5
                                )
                            },
                        ),
                    ),
                ],
            ),
        )
        # OUTPUT NAME
        self.folder_name_txt = Text("")
        self.offset_slider = ft.Slider(
            min=-100,
            max=100,
            value=0,
            on_change=self.update_bottom_row_position,
            label="{value}%",
        )
        self.bottom_row = Row(controls=[Text("Folder Name: "), self.folder_name_txt])
        self.controls.append(
            Container(
                content=self.bottom_row,
                alignment=alignment.center,
                margin=margin.only(left=20),
            )
        )

        # KEY VALUE GRID
        self.table = VariablesEditor(self.page)
        self.controls.append(
            Row(
                alignment=MainAxisAlignment.CENTER,
                controls=[self.table],
                # scroll=ScrollMode.AUTO,
            )
        )

        self.table.cell_changed_fn = self.update_folder_name_text

    def update_bottom_row_position(self, e):
        print(e.control.value)
        self.bottom_row.bottom = e.control.value
        self.update()
        self.page.update()

    @debounce(0.2)
    def update_folder_name_text(self):
        values = self.table.get_key_values()
        print(values)
        self.folder_name_txt.value = "_".join([v for k, v in values.items()])
        self.update()
        self.page.update()

    def add_new_variable(self, e: ControlEvent):
        self.table.add_row(e)
        self.update()
        self.page.update()
        print(f"added new variable: {e}")

    def create_project(self, e: ControlEvent):
        print(f"creating new project: {e}")

    def cell_check(self, e: ControlEvent):
        print(self.table.get_key_values())

    def handle_alert(self, can_del: bool):
        print(can_del)

    def open_alert(self, e: ControlEvent):
        alert = AlertBox(self.page, self.handle_alert)
        self.page.dialog = alert.alert
        alert.alert.open = True
        self.update()
        self.page.update()

    def build(self):
        pass
        # return self.controls


class AlertBox(UserControl):
    def __init__(self, page: Page, close_handler: Callable[[bool], None]):
        super().__init__()
        self.page = page
        self.close_handler = close_handler
        self.alert = AlertDialog(
            modal=True,
            title=ft.Text("Please confirm"),
            content=ft.Text("Do you really want to delete all those files?"),
            actions=[
                ft.TextButton("Yes", on_click=self.close_dlg_yes),
                ft.TextButton("No", on_click=self.close_dlg_no),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
            on_dismiss=lambda e: print("Modal dialog dismissed!"),
        )

    def build(self):
        return self.alert

    def close_dlg_yes(self, e: ControlEvent):
        self.close_handler(True)
        self.alert.open = False
        self.update()
        self.page.update()

    def close_dlg_no(self, e: ControlEvent):
        self.close_handler(False)
        self.alert.open = False
        self.update()
        self.page.update()

    def open_alert(self):
        self.alert.open = True
        self.update()
        self.page.update()
