import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

MenuBar {
    id: root
    Menu{
        title: "&File"
        MenuItem{
            text:"Open Song..."
            onTriggered: {
                loadDialog.open();
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
                main_window.loadData(MainWindowModel.readPreviousHistoryData());
            }
        }
        MenuItem{
            id: menu_redo
            text:"Redo"
            enabled: MainWindowModel.hasNextHistoryData()
            onTriggered: {
                main_window.loadData(MainWindowModel.readNextHistoryData());
            }
        }
    }

    Menu {
        title: "&Song"
    }

    Menu {
        title: "&Library"
    }

    Menu{
        title: "&View"
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


