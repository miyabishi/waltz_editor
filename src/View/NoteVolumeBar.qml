import QtQuick 2.0

Rectangle {
    id: root
    color: "#ff7799"
    MouseArea{
        anchors.fill: parent
        drag.target: root
        drag.axis: Drag.YAxis
        acceptedButtons: Qt.LeftButton

        onMouseYChanged: {
            if(drag.active)
            {
                root.height -= mouseY
                root.y = volume_edit_area.min - root.height;
            }
        }
    }
}
