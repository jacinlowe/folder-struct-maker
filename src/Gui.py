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
from reloading import reloading

# PAGES
from Pages.variables_page import VariablesPage
from Pages.presets_page import PresetFolderStructPage
from Services.dataservice import PresetService
from Services.event_bus import EventBus
from Services.logger import Logger

FOLDER_ICON = (
    r"C:\Users\jacin\Desktop\Programming\adventOfCode\Day 2\videofolderblank_99341.ico"
)
FILE_ICON = r"C:\Users\jacin\Desktop\Programming\adventOfCode\Day 2\1492616984-7-docs-document-file-data-google-suits_83406.ico"


Primary_Color = "#B0EC82"
Secondary_Color = "#FF961C"
Light_Grey = "#F5F5F5"
Grey = "#ABAEB4"

logger = Logger()
event_bus = EventBus()
preset_service = PresetService()


class PageThree(QWidget):
    def __init__(self):
        super().__init__()
        layout = QVBoxLayout()
        layout.addWidget(QPushButton("Button on Page One s"))
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
    def __init__(self, event_bus: EventBus, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Multi-Page Application")
        self.event_bus = event_bus
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
        self.event_bus.add_event("clicker")
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
        logger.log("Menu Setup")


@reloading
def run_program():
    app = QtWidgets.QApplication(sys.argv)
    w = MainWindow(event_bus=event_bus)
    w.show()
    app.exec()


if __name__ == "__main__":
    run_program()
