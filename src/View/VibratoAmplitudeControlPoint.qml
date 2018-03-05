import QtQuick 2.0

Item {
    id: root
    property int vibratoId
    property int noteId

    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true

    Connections{
        target: note_list_model_container
        onModelUpdated:{
           reloadVibratoAmplitudeControlPoint(aNoteId);
        }
    }

    Connections{
        target: vibrato_list_model_container
        onModelUpdated:{
            reloadVibratoAmplitudeControlPoint(root.noteId);
        }
    }

    function reloadVibratoAmplitudeControlPoint(aNoteId)
    {
        if(aNoteId !== noteId) return;
        root.x = vibrato_list_model_container.calculateVibratoAmplitudeControlPointX(vibratoId, noteId) - root.width / 2;
        root.y = vibrato_edit_area.calculateY(vibrato_list_model_container.getAmplitude(vibratoId)) - root.height / 2;
    }

    function updateVibratoAmplitudeControlPoint()
    {
        vibrato_list_model_container.updateVibratoAmplitude(vibratoId,
                                                            vibrato_edit_area.calculateValue(root.y + root.height / 2));
    }

    Canvas{
        id: vibrato_amplitude_control_point_canvas
        anchors.fill: parent
        onPaint: {
            var ctx = vibrato_amplitude_control_point_canvas.getContext('2d');
            ctx.clearRect(0,0,
                          vibrato_amplitude_control_point_canvas.width,
                          vibrato_amplitude_control_point_canvas.height);

            ctx.strokeStyle = Qt.rgba(.5,.9,.7);

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
        id: vibrato_amplitude_control_point_mouse_area
        anchors.fill: root

        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.YAxis

        onPositionChanged: {
            updateVibratoAmplitudeControlPoint();
        }

        onReleased: {
            root.Drag.drop();
            MainWindowModel.writeHistory(main_window.createSaveData());
        }
    }
}
