from PySide6 import QtWidgets, QtGui
from PySide6.QtCore import QItemSelectionModel, QFileInfo, Qt, Signal, QTimer
from PySide6.QtGui import (
    QStandardItemModel,
    QStandardItem,
    QIcon,
    QAction,
    QColor,
    QPalette,
)
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
    QListView,
    QTableWidget,
    QTableWidgetItem,
    QStyledItemDelegate,
    QTextEdit,
    QItemDelegate,
    QCheckBox,
)

from Services.dataservice import AttributeService

SEPERATOR = "_"

attribute_service = AttributeService()


class AlternatingColorDelegate(QStyledItemDelegate):
    def paint(self, painter, option, index):
        if index.row() % 2 == 0:
            option.backgroundBrush = QColor("#F5F5F5")  # Light_Grey
        else:
            option.backgroundBrush = QColor("#FFFFFF")  # White

        super().paint(painter, option, index)


class VariablesPage(QWidget):
    def __init__(self):
        super().__init__()

        layout = QVBoxLayout()
        self.attribute_editor = Attributes(attribute_service)
        layout.addWidget(self.attribute_editor, 1)
        result_text_label = QLabel("Folder Name:")

        self.result_text = QTextEdit()
        self.result_text.setReadOnly(True)
        self.result_text.setFixedHeight(self.result_text.fontMetrics().height())
        result_layout = QHBoxLayout()
        result_layout.addWidget(result_text_label)
        result_layout.addWidget(self.result_text)

        layout.addLayout(result_layout)

        self.setLayout(layout)
        self.attribute_editor.layout.setStretch(0, 1)
        self.attribute_editor.layout.setStretch(1, 1)
        self.toggle_button = QCheckBox("Toggle Keys/Values")
        self.toggle_button.stateChanged.connect(self.update_result_text)
        layout.addWidget(self.toggle_button)
        self.update_result_text()

        self.attribute_editor.row_added.connect(self.update_result_text)
        self.attribute_editor.cell_changed.connect(self.update_result_text)

    def update_result_text(self):
        if self.toggle_button.isChecked():
            concatenated_values = self.get_result_text_keys()
        else:
            concatenated_values = self.get_result_text_values()
        self.result_text.setPlainText(concatenated_values)

    def get_result_text_values(self):
        values = self.attribute_editor.get_values()
        concatenated_values = f"{SEPERATOR}".join(
            f"{value}" if value != "" else "" for key, value in values
        )
        return concatenated_values

    def get_result_text_keys(self):
        values = self.attribute_editor.get_values()
        concatenated_values = f"{SEPERATOR}".join(
            "{" + f"{key}" + "}" if key != "" else "" for key, value in values
        )
        return concatenated_values

    def populate_variable_list(self):
        root_list = self.preset_model.invisibleRootItem()
        for i in range(5):
            item = QStandardItem(f"Item {i}")
            item.setData("file", Qt.UserRole + 1)
            root_list.appendRow(item)

    def get_name(self):
        return "Variables"


class KeyDelegate(QItemDelegate):
    def __init__(self, parent=None):
        super().__init__(parent)

    def paint(self, painter, option, index):
        if index.column() == 0:  # Check if it's the "Key" column
            option.backgroundBrush = QColor("#F5F5F5")  # Light_Grey

            # Set the text color for the "Key" column
            option.palette.setColor(QPalette.Text, Qt.darkGray)
        # option.palette.setColor(option.palette.base, Qt.lightGray)
        # option.palette.setColor(option.palette.text, Qt.darkGray)
        super().paint(painter, option, index)


class Attributes(QWidget):
    row_added = Signal()
    cell_changed = Signal()

    def __init__(self, attribute_service):
        super().__init__()
        self.attribute_service = attribute_service

        self.tableWidget = QTableWidget()
        self.tableWidget.setColumnCount(2)
        self.tableWidget.setHorizontalHeaderLabels(["Key", "Value"])

        # Apply the alternating color delegate
        delegate = AlternatingColorDelegate()
        self.tableWidget.setItemDelegate(delegate)

        # Create and set the custom Delegate
        key_delegate = KeyDelegate()
        self.tableWidget.setItemDelegateForColumn(0, key_delegate)

        self.layout = QVBoxLayout()
        button = QPushButton("Add New Attribute")
        button.clicked.connect(self.add_row)
        self.layout.addWidget(button)
        self.layout.addWidget(self.tableWidget)
        self.setLayout(self.layout)
        self.load_attributes()  # Load saved attributes on startup
        if self.tableWidget.rowCount() < 1:
            self.add_row()

        self.layout.setStretch(0, 1)
        self.layout.setStretch(1, 1)

        # Debouncing Cell changes
        self.debounce_timer = QTimer()
        self.debounce_timer.setInterval(500)  # 500ms debounce time
        self.debounce_timer.setSingleShot(True)
        self.debounce_timer.timeout.connect(self.emit_cell_changed)

        # Connect the itemChanged signal of the table widget to start the debounce timer
        self.tableWidget.itemChanged.connect(self.start_debounce_timer)
        self.tableWidget.cellChanged.connect(self.format_cell)

    def format_cell(self):
        for row in range(self.tableWidget.rowCount()):
            key_item = self.tableWidget.item(row, 0)
            key_item.setText("_".join(key_item.text().upper().split(" ")))

    def load_attributes(self):
        self.attribute_service.load()
        attributes = self.attribute_service.get_attributes()
        # self.clear_table()
        for attribute in attributes:
            self.add_row(attribute["key"], attribute["value"])

    def clear_table(self):
        raise NotImplementedError

    def save_attributes(self):
        attributes = []
        for row in range(self.tableWidget.rowCount()):
            key_item = self.tableWidget.item(row, 0)
            value_item = self.tableWidget.item(row, 1)
            key = key_item.text() if key_item else ""
            value = value_item.text() if value_item else ""
            attributes.append({"key": key, "value": value})
        self.attribute_service.clear_attributes()
        self.attribute_service.variables = attributes
        self.attribute_service.save_attributes()

    def add_row(self, key="", value=""):

        row_position = self.tableWidget.rowCount()
        self.tableWidget.insertRow(row_position)

        key_item = QTableWidgetItem(key.upper())
        value_item = QTableWidgetItem(value)

        self.tableWidget.setItem(row_position, 0, key_item)
        self.tableWidget.setItem(row_position, 1, value_item)
        self.row_added.emit()

    def get_values(self):
        values = []
        for row in range(self.tableWidget.rowCount()):
            key_item = self.tableWidget.item(row, 0)
            value_item = self.tableWidget.item(row, 1)
            if key_item and value_item:
                key = key_item.text()
                value = value_item.text()
                values.append((key, value))
        return values

    def start_debounce_timer(self):
        self.debounce_timer.start()

    def emit_cell_changed(self):
        # Emit the cell_changed signal when debounce timer times out

        self.cell_changed.emit()
