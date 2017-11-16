import QtQuick 2.0

Rectangle{
    id: root
    color: "#ffffff"
    property int noteId
    property int portamentoStartPointId

    border.color: "#ccddff"
    border.width: 1
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true

    Connections{
        target: note_list_model_container
        onModelUpdated:{
            adjust()
        }
    }

    Connections{
        target: portamento_start_point_list_model_container
        onModelUpdated:{
            reload();
        }
    }

    function adjust()
    {
        var note = note_list_model_container.find(noteId);
        var portamentoStartX = note.positionX - 30;
        var portamentoStartY = note_list_model_container.yPositionOfPreviousNote(root.x - 1,
                                                                                 root.y + root.height / 2,
                                                                                 root.pNoteId_);
        portamento_start_point_list_model_container.updateBasePoint(portamentoStartPointId,
                                                                    portamentoStartX,
                                                                    portamentoStartY)
    }

    function reload()
    {
        var portamentoStartPoint = portamento_start_point_list_model_container.find(portamentoStartPointId);
        root.x = portamentoStartPoint.portamentoStartX
                + portamentoStartPoint.portamentoStartXOffset - root.width / 2;
        root.y = portamentoStartPoint.portamentoStartY - root.height / 2;
    }

    function updatePortamentoStartPoint(aOffset)
    {
        portamento_start_point_list_model_container.updateOffset(portamentoStartPointId, aOffset);
    }

    MouseArea{
        id: portamento_start_point_mouse_area
        property int clickedPointX

        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onPressed: {
            clickedPointX = root.x
        }

        onReleased: {
            var dropX = root.x;
            updatePortamentoStartPoint(dropX - clickedPointX);
            root.Drag.drop();
        }
    }
}

