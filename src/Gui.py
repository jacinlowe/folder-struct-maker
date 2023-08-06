import sys
from PySide6 import QtWidgets, QtGui
from PySide6.QtCore import QItemSelectionModel, QFileInfo, Qt
from PySide6.QtGui import QStandardItemModel, QStandardItem, QIcon, QAction
from PySide6.QtWidgets import (
    QApplication,
    QMainWindow,
    QTreeView,
    QVBoxLayout,
    QHBoxLayout,
    QWidget,
    QPushButton,
    QFileIconProvider,
    QStyle,
    QTabWidget,
    QLabel,
)

# PAGES
from Pages.variables_page import VariablesPage


FOLDER_ICON = (
    r"C:\Users\jacin\Desktop\Programming\adventOfCode\Day 2\videofolderblank_99341.ico"
)
FILE_ICON = r"C:\Users\jacin\Desktop\Programming\adventOfCode\Day 2\1492616984-7-docs-document-file-data-google-suits_83406.ico"


Primary_Color = "#B0EC82"
Secondary_Color = "#FF961C"
Light_Grey = "#F5F5F5"
Grey = "#ABAEB4"


class FileIconProvider(QFileIconProvider):
    def icon(self, _input):
        if isinstance(_input, QFileInfo):
            if _input.isDir():
                return QApplication.style().standardIcon(QStyle.SP_DirIcon)
            elif _input.isFile():
                return QApplication.style().standardIcon(QStyle.SP_FileIcon)
        else:
            if _input == QtGui.QAbstractFileIconProvider.Folder:
                return QApplication.style().standardIcon(QStyle.SP_DirIcon)
            elif _input == QtGui.QAbstractFileIconProvider.File:
                return QApplication.style().standardIcon(QStyle.SP_FileIcon)
        return super().icon(_input)


# FileIconProvider().icon("Day 2\videofolderblank_99341.ico")


class StandardItem(QStandardItem):
    def __init__(
        self,
        txt="",
        font_size=11,
        set_bold=False,
        color=QtGui.QColor(0, 0, 0),
    ):
        super().__init__()
        fnt = QtGui.QFont("Open Sans", font_size)
        fnt.setBold(set_bold)
        self.setEditable(False)
        self.setForeground(color)
        self.setFont(fnt)
        self.setText(txt)


class StandardItemFolder(StandardItem):
    def __init__(
        self,
        txt="",
        font_size=11,
        set_bold=False,
        color=QtGui.QColor(0, 0, 0),
    ):
        super().__init__(txt, font_size, set_bold, color)
        iconProvider = FileIconProvider()
        folder_icon = iconProvider.icon(QFileIconProvider.Folder)
        self.setIcon(folder_icon)


class StandardItemFile(StandardItem):
    def __init__(
        self,
        txt="",
        font_size=11,
        set_bold=False,
        color=QtGui.QColor(0, 0, 0),
    ):
        super().__init__(txt, font_size, set_bold, color)
        iconProvider = FileIconProvider()
        icon = iconProvider.icon(QFileIconProvider.File)
        self.setIcon(icon)
        self.setData("file", Qt.UserRole + 1)


class CustomTreeView(QTreeView):
    def __init__(self):
        super().__init__()
        self.setDragDropMode(QTreeView.InternalMove)
        self.setDefaultDropAction(Qt.MoveAction)

    def dragMoveEvent(self, event):
        target_index = self.indexAt(event.pos())
        source_index = self.currentIndex()

        if not target_index.isValid() or not source_index.isValid():
            event.ignore()
            return

        source_item = self.model().itemFromIndex(source_index)
        target_item = self.model().itemFromIndex(target_index)

        if source_item.data(Qt.UserRole + 1) != target_item.data(Qt.UserRole + 1):
            # Check if source and target have the same data type (folder/file)
            event.ignore()
            return

        super().dragMoveEvent(event)


def get_next_letter(text: str):
    if len(text) > 1:
        char_input = text[0]
    else:
        char_input = text
    return chr((ord(char_input) - ord("A") + 1) % 26 + ord("A"))


class PresetFolderStructPage(QWidget):
    def __init__(self, parent=None):
        super().__init__()
        self.treeView = CustomTreeView()
        # self.grid_view = QtWidgets.QTableView()
        self.main_h_layout = QtWidgets.QHBoxLayout()
        self.vlayout = QtWidgets.QVBoxLayout()

        self.setLayout(self.main_h_layout)

        self.model = QtGui.QStandardItemModel()
        self.icon_provider = QFileIconProvider()

        # Labels
        presets_label = QLabel("Presets")
        folder_structure_label = QLabel("Folder Structure")

        # PRESET VIEW
        listview_vertical_layout = QVBoxLayout()

        listview = QtWidgets.QListView()
        self.preset_model = QStandardItemModel()
        listview.setModel(self.preset_model)
        self.populate_preset_list()

        self.treeView.setModel(self.model)
        self.populate_tree()

        self.treeView.setDragDropMode(QtWidgets.QTreeView.InternalMove)
        self.treeView.setDefaultDropAction(Qt.MoveAction)
        button = QtWidgets.QToolButton()
        button.setText("Add File")
        button.clicked.connect(self.add_file)

        button2 = QtWidgets.QToolButton()
        button2.setText("Add Folder")
        button2.clicked.connect(self.add_folder)
        hlayout = QtWidgets.QHBoxLayout()
        hlayout.addWidget(button)
        hlayout.addWidget(button2)

        # ADDING LAYOUTS AND WIDGETS TO THE MAIN LAYOUT
        listview_vertical_layout.addWidget(presets_label)  # Add presets label
        listview_vertical_layout.addWidget(listview)

        self.main_h_layout.addLayout(listview_vertical_layout)
        self.main_h_layout.addLayout(self.vlayout)

        self.vlayout.addWidget(folder_structure_label)  # Add folder structure label
        self.vlayout.addWidget(self.treeView)

        self.vlayout.addLayout(hlayout)
        # self.vlayout.addWidget(self.grid_view)
        self.treeView.selectedIndexes()

    def get_name(self):
        return "Structures"

    def populate_tree(self):
        rootNode = self.model.invisibleRootItem()
        A = StandardItemFolder("A")

        A.appendRows(
            [StandardItemFile("1"), StandardItemFile("2"), StandardItemFile("3")]
        )
        B = StandardItemFolder("B")
        B.appendRows([StandardItemFile("1"), StandardItemFile("2")])
        rootNode.appendRows(
            [
                A,
                B,
            ]
        )
        index_A = A.index()
        index_B = B.index()

        self.treeView.setExpanded(index_A, True)
        self.treeView.setExpanded(index_B, True)
        self.treeView.selectionModel().select(index_A, QItemSelectionModel.Select)
        # self.setLayout(vlayout)

    def populate_preset_list(self):
        root_list = self.preset_model.invisibleRootItem()
        for i in range(5):
            item = QStandardItem(f"Item {i}")
            item.setData("file", Qt.UserRole + 1)
            root_list.appendRow(item)

    def add_file(self):
        selected_indexes = self.treeView.selectedIndexes()

        if selected_indexes:
            selected_index = selected_indexes[0]  # Take the first selected index
            selected_item = self.model.itemFromIndex(selected_index)
            item_text = selected_item.text()
            print("Selected Item:", item_text)
            last_item_file_name = selected_item.child(
                selected_item.rowCount() - 1, 0
            ).text()
            print(last_item_file_name)
            selected_item.appendRow(StandardItemFile(f"{int(last_item_file_name) + 1}"))

        else:
            print("No item selected.")

    def add_folder(self):
        selected_indexes = self.treeView.selectedIndexes()

        if selected_indexes:
            selected_index = selected_indexes[0]  # Take the first selected index
            selected_item = self.model.itemFromIndex(selected_index)
            item_text = selected_item.text()
            print("Selected Item:", item_text)
            selected_item.appendRow(StandardItemFolder(get_next_letter(item_text)))

        else:
            print("No item selected.")


class PageThree(QWidget):
    def __init__(self):
        super().__init__()
        layout = QVBoxLayout()
        layout.addWidget(QPushButton("Button on Page One"))
        self.setLayout(layout)


# Not implemented correctly yet
class CustomTitleBar(QWidget):
    def __init__(self, parent):
        super().__init__(parent)
        self.setWindowTitle("CustomTitleBar")
        self.setAutoFillBackground(True)
        palette = self.palette()
        palette.setColor(self.backgroundRole(), Qt.darkGray)
        self.setPalette(palette)
        self.setFixedHeight(30)

        self.layout = QHBoxLayout()
        self.layout.setContentsMargins(0, 0, 0, 0)
        self.layout.setAlignment(Qt.AlignRight)

        style = self.style()

        self.minimize_button = QPushButton(
            style.standardIcon(QStyle.SP_TitleBarMinButton), "", self
        )
        self.minimize_button.clicked.connect(self.parent().showMinimized)
        self.layout.addWidget(self.minimize_button)

        self.maximize_button = QPushButton(
            style.standardIcon(QStyle.SP_TitleBarMaxButton), "", self
        )
        self.maximize_button.clicked.connect(self.toggle_maximize)
        self.layout.addWidget(self.maximize_button)

        self.close_button = QPushButton(
            style.standardIcon(QStyle.SP_TitleBarCloseButton), "", self
        )
        self.close_button.clicked.connect(self.parent().close)
        self.layout.addWidget(self.close_button)

        self.close_button = QPushButton(self)
        self.close_button.setIcon(QIcon.fromTheme("window-close"))
        self.close_button.clicked.connect(self.parent().close)
        self.layout.addWidget(self.close_button)

        self.setLayout(self.layout)

    def toggle_maximize(self):
        if self.parent().isMaximized():
            self.parent().showNormal()
        else:
            self.parent().showMaximized()


class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Multi-Page Application")

        # self.setWindowFlags(Qt.FramelessWindowHint)
        # self.setAttribute(Qt.WA_TranslucentBackground)

        # self.title_bar = CustomTitleBar(self)
        # self.setMenuWidget(self.title_bar)
        self.resize(800, 600)

        self.tab_widget = QTabWidget()

        self.page_one = VariablesPage()
        self.page_two = PresetFolderStructPage()
        self.page_three = PageThree()

        self.tab_widget.addTab(self.page_one, self.page_one.get_name())
        self.tab_widget.addTab(self.page_two, self.page_two.get_name())
        self.tab_widget.addTab(self.page_three, "idk")

        self.setCentralWidget(self.tab_widget)

        self.setup_menu_bar()
        self.apply_custom_styles()
        # Set the window size

    def load_data(self):

        self.page_one.attribute_editor.add_row()

    def apply_custom_styles(self):
        # Apply custom styles using QSS
        self.setStyleSheet(
            f"""
            QMainWindow {{
                background-color: {Light_Grey};
                color: black;
            }}
            QTabWidget::pane {{
                border: 1px solid {Grey};
                background-color: {Light_Grey};
            }}
            QTabBar::tab {{
                background-color: {Light_Grey};
                color: black;
                padding: 8px 16px;
            }}
            QTabBar::tab:selected {{
                background-color: {Primary_Color};
            }}
            QMenuBar {{
                background-color: {Light_Grey};
                color: black;
            }}
            QMenu {{
                background-color: {Light_Grey};
                color: black;
            }}
            QMenu::item:selected {{
                background-color: {Primary_Color};
            }}
            QPushButton {{
                background-color: {Primary_Color};
                color: black;
                border: none;
                padding: 8px 16px;
            }}
            QPushButton:hover {{
                background-color: {Secondary_Color};
            }}
            """
        )

    def setup_menu_bar(self):
        menu_bar = self.menuBar()
        # File Menu
        file_menu = menu_bar.addMenu("File")
        quit_action = QAction("Quit", self)
        quit_action.triggered.connect(self.close)
        file_menu.addAction(quit_action)

        # Edit Menu (Placeholder)
        edit_menu = menu_bar.addMenu("Edit")

        # View Menu (Placeholder)
        view_menu = menu_bar.addMenu("View")

        # Help Menu (Placeholder)
        help_menu = menu_bar.addMenu("Help")


def run_program():
    app = QtWidgets.QApplication(sys.argv)
    w = MainWindow()
    w.show()
    app.exec()


if __name__ == "__main__":
    run_program()
