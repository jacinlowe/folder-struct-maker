import sys
from typing import Optional
from PySide6 import QtWidgets, QtGui
from PySide6.QtCore import QItemSelectionModel, QFileInfo, Qt, Signal, QItemSelection
from PySide6.QtGui import (
    QStandardItemModel,
    QStandardItem,
    QIcon,
    QAction,
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
)

from Services.dataservice import PresetService
from Services.logger import Logger


logger = Logger()


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


class PresetStandardItemModel(QStandardItemModel):
    item_clicked = Signal(str)

    def __init__(self):
        super().__init__()

    def create_item(self, text):
        item = QStandardItem(text)
        self.appendRow(item)

    # def setData(self, index, value, role=Qt.EditRole):
    #     result = super().setData(index, value, role)
    #     if role == Qt.EditRole:
    #         item = self.itemFromIndex(index)
    #         if item is not None:
    #             self.item_clicked.emit(item.text())
    #     return result

    def itemChanged(self, item):
        super().itemChanged(item)
        if item.isSelected():
            self.item_clicked.emit(item.text())


class PresetListView(QListView):
    itemSelected = Signal(str)

    def __init__(self, parent=None) -> None:
        super().__init__(parent)

    def selectionChanged(
        self, selected: QItemSelection, deselected: QItemSelection
    ) -> None:
        super().selectionChanged(selected, deselected)
        indexes = selected.indexes()
        if indexes:
            selected_item = indexes[0].data(Qt.DisplayRole)
            self.itemSelected.emit(selected_item)


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

        listview = PresetListView()
        self.preset_model = PresetStandardItemModel()

        listview.setModel(self.preset_model)

        self.load_data()
        # self.populate_preset_list()

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

    def load_data(self):
        preset_service = PresetService()
        preset_service.load()
        root_list = self.preset_model.invisibleRootItem()
        self.preset_model.item_clicked.connect(self.handle_item_clicked)

        for i in preset_service._presets.keys():
            self.preset_model.create_item(i)

        logger.log("Data loaded from presets page")

    def handle_item_clicked(self, item_text):
        print(
            f"Item clicked: {item_text}"
        )  # You can emit your custom signal here if needed

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
