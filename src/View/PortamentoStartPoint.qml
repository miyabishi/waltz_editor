import QtQuick 2.0

Rectangle{
    id: root
    color: "#ffffff"
    property int noteId

    border.color: "#ccddff"
    border.width: 1
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true


    Connections{
        target: MainWindowModel
        onScoreUpdated:{
            reload();
        }
    }

    function reload()
    {
        console.log("noteid" + noteId);
        var startPoint = MainWindowModel.portamentStartPoint(noteId);
        root.x = startPoint.x - width / 2;
        root.y = startPoint.y - height / 2;
        console.log("(" + root.x + ", " + ")");
    }

    MouseArea{
        id: portamento_start_point_mouse_area
        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root

        onReleased: {
            root.Drag.drop()
        }
    }
}

