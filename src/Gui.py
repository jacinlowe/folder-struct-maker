import sys
from PySide6 import QtWidgets, QtGui
from PySide6.QtCore import QItemSelectionModel, QFileInfo, Qt
from PySide6.QtGui import QStandardItemModel, QStandardItem, QIcon
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
)


FOLDER_ICON = (
    r"C:\Users\jacin\Desktop\Programming\adventOfCode\Day 2\videofolderblank_99341.ico"
)
FILE_ICON = r"C:\Users\jacin\Desktop\Programming\adventOfCode\Day 2\1492616984-7-docs-document-file-data-google-suits_83406.ico"


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


class MainWindow(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.treeView = CustomTreeView()
        self.grid_view = QtWidgets.QTableView()
        self.main_h_layout = QtWidgets.QHBoxLayout()
        self.vlayout = QtWidgets.QVBoxLayout()

        widget = QtWidgets.QWidget()
        widget.setLayout(self.main_h_layout)

        self.setCentralWidget(widget)

        self.model = QtGui.QStandardItemModel()
        self.icon_provider = QFileIconProvider()

        # PRESET VIEW
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

        self.main_h_layout.addWidget(listview)
        self.main_h_layout.addLayout(self.vlayout)

        self.vlayout.addWidget(self.treeView)
        self.vlayout.addLayout(hlayout)
        self.treeView.selectedIndexes()

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


def run_program():
    app = QtWidgets.QApplication(sys.argv)
    w = MainWindow()
    w.show()
    app.exec()


if __name__ == "__main__":
    run_program()
