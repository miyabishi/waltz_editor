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


