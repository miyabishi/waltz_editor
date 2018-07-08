import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

MenuBar {
    id: root
    style: MenuBarStyle{
        font.family: "Meiryo"
        font.pixelSize: 16
    }

    Menu{
        title: qsTr("&File")

        MenuItem{
            text:qsTr("Open Song...")
            onTriggered: {
                command_container.load();
            }
        }
        MenuItem{
            text:qsTr("Save")
            onTriggered: {
                command_container.save();
            }
        }
        MenuItem{
            text:qsTr("Save As...")
            onTriggered: {
                command_container.saveAs();
            }
        }
        MenuSeparator{}
        MenuItem{
            text:qsTr("Open Voice Library...")
            onTriggered: {
                command_container.openVocalLibrary();
            }
        }
    }

    Menu{
        title: qsTr("&Edit")
        Connections{
            target: MainWindowModel
            onHistoryDataUpdated: {
                menu_undo.enabled = MainWindowModel.hasPreviousHistoryData();
                menu_redo.enabled = MainWindowModel.hasNextHistoryData();
            }
        }

        MenuItem{
            id: menu_undo
            text:qsTr("Undo")
            enabled: MainWindowModel.hasPreviousHistoryData()
            onTriggered: {
                command_container.undo();
            }
        }
        MenuItem{
            id: menu_redo
            text:qsTr("Redo")
            enabled: MainWindowModel.hasNextHistoryData()
            onTriggered: {
                command_container.redo();
            }
        }
    }

    Menu{
        title: qsTr("&View")
        MenuItem{
            text:qsTr("Score Edit View")
            checkable: true;
            checked: true;
            onToggled: {
                edit_area.visible = checked;
            }
        }
        MenuItem{
            text:qsTr("Portamento Edit View")
            checkable: true;
            checked: portamento_edit_area.visible;
            onToggled: {
                portamento_edit_area.visible = checked;
            }
        }
        MenuItem{
            text:qsTr("Parameter Edit View")
            checkable: true;
            checked: parameters_edit_area.visible;
            onToggled: {
                parameters_edit_area.visible = checked;
            }
        }
    }

    Menu{
        title: qsTr("&Help")

        MenuItem{
            text:qsTr("Waltz Document")
            onTriggered: {
                Qt.openUrlExternally("https://waltz.gitbook.io/project/");
            }
        }

        MenuItem{
            text:qsTr("Report an issue")
            onTriggered: {
                Qt.openUrlExternally("https://github.com/miyabishi/waltz_editor/issues");
            }
        }
        MenuSeparator{}
        MenuItem{
            text:qsTr("About Qt")
            onTriggered: {
                Qt.openUrlExternally("https://www.qt.io/");
            }
        }
    }
}


