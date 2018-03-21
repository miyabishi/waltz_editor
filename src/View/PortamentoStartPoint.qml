import QtQuick 2.0

Item{
    id: root
    property int noteId
    property int portamentoStartPointId

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
                                                                    portamentoStartY);
    }

    function reload()
    {
        var portamentoStartPoint = portamento_start_point_list_model_container.find(portamentoStartPointId);
        root.x = portamentoStartPoint.portamentoStartX
                + portamentoStartPoint.portamentoStartXOffset - root.width / 2;
        root.y = portamentoStartPoint.portamentoStartY - root.height / 2;
    }

    function updatePortamentoStartPoint()
    {
        var portamentoStartPoint = portamento_start_point_list_model_container.find(portamentoStartPointId);
        portamento_start_point_list_model_container.updateOffset(portamentoStartPointId,
                                                                 root.x + root.width / 2 - portamentoStartPoint.portamentoStartX);
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
        id: portamento_start_point_mouse_area
        property int clickedPointX

        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onPressed: {
            var maximumX = pitch_changing_point_list_model_containter.minimumX(noteId);
            if (maximumX < 0)
            {
                var endPoint = portamento_end_point_list_model_container.findByNoteId(noteId);
                maximumX = endPoint.portamentoEndX + endPoint.portamentoEndXOffset;
            }
            drag.maximumX = maximumX - width / 2;
            console.log("maximumX = " + drag.maximumX);
        }

        onPositionChanged: {
            var dropX = root.x;
            updatePortamentoStartPoint();
        }

        onReleased: {
            updatePortamentoStartPoint();
            root.Drag.drop();
            MainWindowModel.writeHistory(main_window.createSaveData());
        }
    }
}

