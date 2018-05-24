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
        title: "&File"

        MenuItem{
            text:"Open Song..."
            onTriggered: {
                command_container.load();
            }
        }
        MenuItem{
            text:"Save"
            onTriggered: {
                command_container.save();
            }
        }
        MenuItem{
            text:"Save As..."
            onTriggered: {
                command_container.saveAs();
            }
        }
        MenuSeparator{}
        MenuItem{
            text:"Open Voice Library..."
            onTriggered: {
                command_container.openVocalLibrary();
            }
        }
    }

    Menu{
        title: "&Edit"
        Connections{
            target: MainWindowModel
            onHistoryDataUpdated: {
                menu_undo.enabled = MainWindowModel.hasPreviousHistoryData();
                menu_redo.enabled = MainWindowModel.hasNextHistoryData();
            }
        }

        MenuItem{
            id: menu_undo
            text:"Undo"
            enabled: MainWindowModel.hasPreviousHistoryData()
            onTriggered: {
                command_container.undo();
            }
        }
        MenuItem{
            id: menu_redo
            text:"Redo"
            enabled: MainWindowModel.hasNextHistoryData()
            onTriggered: {
                command_container.redo();
            }
        }
    }

    Menu{
        title: "&View"
        MenuItem{
            text:"Score Edit View"
            checkable: true;
            checked: true;
            onToggled: {
                edit_area.visible = checked;
            }
        }
        MenuItem{
            text:"Portamento Edit View"
            checkable: true;
            checked: portamento_edit_area.visible;
            onToggled: {
                portamento_edit_area.visible = checked;
            }
        }
        MenuItem{
            text:"Parameter Edit View"
            checkable: true;
            checked: parameters_edit_area.visible;
            onToggled: {
                parameters_edit_area.visible = checked;
            }
        }
    }

    Menu{
        title: "&Help"
        MenuItem{
            text:"AboutQt..."
            onTriggered: {
            }
        }
    }
}


