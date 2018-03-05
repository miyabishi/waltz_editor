import QtQuick 2.0

Item{
    id: root
    property int noteId
    property int portamentoEndPointId

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
        root.x = portamentoEndPoint.portamentoEndX + portamentoEndPoint.portamentoEndXOffset - root.width / 2;
        root.y = portamentoEndPoint.portamentoEndY - root.height / 2;
    }

    function updatePortamentoEndPoint()
    {
        var portamentoEndPoint = portamento_end_point_list_model_container.find(portamentoEndPointId);
        portamento_end_point_list_model_container.updateOffset(portamentoEndPointId,
                                                               root.x + root.width / 2 - portamentoEndPoint.portamentoEndX);
    }

    Canvas{
        id: pitch_changing_point_canvas
        anchors.fill: parent
        onPaint: {
            var ctx = pitch_changing_point_canvas.getContext('2d');
            ctx.clearRect(0,0,pitch_changing_point_canvas.width, pitch_changing_point_canvas.height);

            ctx.strokeStyle = Qt.rgba(.6,.8,1);
            ctx.beginPath();
            ctx.moveTo(0,0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width, height);
            ctx.lineTo(0, height);
            ctx.lineTo(0,0);

            ctx.lineWidth = 2;
            ctx.stroke();
            ctx.restore();
        }
    }

    MouseArea{
        id: portamento_end_point_mouse_area
        property int clickedPointX

        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onPositionChanged: {
            updatePortamentoEndPoint();
        }

        onReleased: {
            updatePortamentoEndPoint();
            root.Drag.drop();
            MainWindowModel.writeHistory(main_window.createSaveData());
        }
    }
}

