import QtQuick 2.0

Rectangle{
    id: top_bar
    color: "#333333"
    height: 60

    Rectangle{
        id: file_buttons
        color:parent.color
        x: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 80
        height: 32
        Image {
            id: save_button
            anchors.left: parent.left
            height: parent.height
            width: height
            source: "qrc:/image/save.png"
        }

    }

    Rectangle{
        id: tool_buttons
        color:parent.color
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: file_buttons.right
        width: 80
        height: 32
        Image {
            id: edit_button
            anchors.left: parent.left
            height: parent.height
            width: height
            source: "qrc:/image/edit.png"
        }

        Image {
            id: cursor_button
            anchors.right: parent.right
            height: parent.height
            width: height
            source: "qrc:/image/cursor.png"
        }

    }
}
