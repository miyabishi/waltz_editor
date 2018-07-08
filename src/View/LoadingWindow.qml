import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Window {
    id: root
    flags: Qt.SplashScreen
    modality: Qt.WindowModal
    ColumnLayout{

        Text{
            text:qsTr("loading...")
        }

        ProgressBar{
            anchors.fill: parent
            indeterminate: true
            Layout.preferredHeight: 60
        }

        Button{
            text:qsTr("Cancel")
            onClicked: {
                root.close();
            }
        }
    }
}
