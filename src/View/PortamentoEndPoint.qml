import QtQuick 2.0

Rectangle{
    id: root
    color: "#ffffff"
    property int noteId
    property int portamentoEndPointId

    border.color: "#ccddff"
    border.width: 1
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true

    Connections{
        target: note_list_model_container
        onModelUpdated:{
            adjust()
            reload();
        }
    }

    Connections{
        target: portamento_end_point_list_model_container
        onModelUpdated:{
            reload();
        }
    }

    function adjust()
    {
        var note = note_list_model_container.find(noteId);
        var portamentoEndX = note.positionX + 30;
        var portamentoEndY = note.positionY + edit_area.rowHeight / 2;

        portamento_end_point_list_model_container.updateBasePoint(
                    portamentoEndPointId,
                    portamentoEndX,
                    portamentoEndY)
    }

    function reload()
    {
        var portamentoEndPoint = portamento_end_point_list_model_container.find(portamentoEndPointId);
        console.log("PortamentoEndPoit::reload");
        console.log("portamentoEndPointId:" + portamentoEndPointId);
        console.log("portamentoEndX:" + portamentoEndPoint.portamentoEndX);
        console.log("portamentoEndY:" + portamentoEndPoint.portamentoEndY);

        root.x = portamentoEndPoint.portamentoEndX + portamentoEndPoint.portamentoEndXOffset - root.width / 2;
        root.y = portamentoEndPoint.portamentoEndY - root.height / 2;
    }

    function updatePortamentoEndPoint(aOffset)
    {
        console.log("updatePortamentoEndPoint:" + portamentoEndPointId);
        portamento_end_point_list_model_container.updateOffset(portamentoEndPointId, aOffset);
    }

    MouseArea{
        id: portamento_end_point_mouse_area
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
            updatePortamentoEndPoint(dropX - clickedPointX);
            root.Drag.drop();
        }
    }
}

