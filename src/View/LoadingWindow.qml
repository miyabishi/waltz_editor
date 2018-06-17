import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

Window {
    flags: Qt.SplashScreen
    modality: Qt.WindowModal

    Text{
        text:qsTr("loading...")
    }
    ProgressBar{
        anchors.fill: parent
        indeterminate: true
    }
}
