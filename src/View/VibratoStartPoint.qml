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
            reloadVibratoStartPoint(aNoteId);
        }
    }

    function reloadVibratoStartPoint(aNoteId)
    {
        if(noteId !== aNoteId) return;
        root.x = vibrato_list_model_container.calculateVibratoStartPoint(vibratoId, noteId) - root.width / 2;
    }

    function updateVibratoStartPoint()
    {
        vibrato_list_model_container.updateVibratoLength(vibratoId, calculateVibratoLength());
    }

    function calculateVibratoLength()
    {
        var note = note_list_model_container.find(noteId);
        return (note.positionX + note.noteWidth) - (root.x + width / 2 );
    }

    Canvas{
        id: vibrato_start_point_canvas
        anchors.fill: parent
        onPaint: {
            var ctx = vibrato_start_point_canvas.getContext('2d');
            ctx.clearRect(0,0,vibrato_start_point_canvas.width, vibrato_start_point_canvas.height);
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
        id: vibrato_start_point_mouse_area
        anchors.fill: root

        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onPressed: {
            var note = note_list_model_container.find(noteId);
            drag.minimumX = note.positionX;
            drag.maximumX = vibrato_list_model_container.calculateVibratoWavelengthEndPoint(vibratoId, noteId)
        }

        onPositionChanged: {
            updateVibratoStartPoint();
        }

        onReleased: {
            root.Drag.drop();
            MainWindowModel.writeHistory(main_window.createSaveData());
        }
    }
}
