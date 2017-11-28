import QtQuick 2.0
import QtQuick.Controls 2.1

TabButton {
    id: root
    height: 25
    width: 200
    property int index
    property bool isActive: bar.currentIndex === index

    contentItem: Text{
        text: root.text
        color: root.isActive ? "#ffffff" : "#dddddd"
        anchors.centerIn: parent.Center
        font.family: "Meiryo"
        font.bold: root.isActive
    }

    background: Rectangle{
        anchors.fill: parent
        color: root.isActive ? "#222222" : "#000000"
        border.color: root.isActive ? "#111111" : "#1c1c1c"
        border.width: 2
    }

}
