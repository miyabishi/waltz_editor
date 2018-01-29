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

            FileDialog{
                id:loadDialog
                nameFilters: ["Waltz Song File(*.waltzSong)"]
                selectMultiple: false
                selectExisting: false
                onAccepted: {
                    MainWindowModel.load(loadDialog.fileUrl);
                }
            }
        }
    }
    Menu{
        title: "&Edit"
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
