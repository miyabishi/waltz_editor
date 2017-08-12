import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2


ApplicationWindow {
    id:main_window
    visible: true
    width: 1280
    height: 940
    title: qsTr("Waltz Editor")

    TopBar{
        id: top_bar
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        z: 10
    }

    SplitView{
        anchors.top: top_bar.bottom
        anchors.left: parent.left
        anchors.right:parent.right
        anchors.bottom:bottom_bar.top

        LibraryInformation{
            id: library_information
            width: 320
            z:1
            anchors.top:parent.top
            anchors.bottom: parent.bottom
        }

        EditArea{
            id: edit_area
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: library_information.right
            anchors.right: parent.right
        }
    }

    BottomBar{
        id: bottom_bar
        height:71
        width: parent.width
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Dialog {
        id: errorDialog
        visible: false
        title: "Error"
        property string error_message: ""
        modality: Qt.WindowModal
        standardButtons: StandardButton.Ok
    }

    Connections{
        target: MainWindowModel
        onErrorOccurred: {
            errorDialog.error_message = aErrorMessage
            errorDialog.open()
        }
    }
}
