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
        target: note_list_model_container
        onModelUpdated:{
            reload();
        }
    }

    function reload()
    {
        var note = note_list_model_container.find(noteId);
        root.x = note.portamentoStartX - root.width / 2;
        root.y = note.portamentoStartY - root.height / 2;
    }

    MouseArea{
        id: portamento_start_point_mouse_area
        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onReleased: {
            root.Drag.drop();
        }
    }
}

