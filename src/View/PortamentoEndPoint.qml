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
        root.x = note.portamentoEndX + note.portamentoEndXOffset - root.width / 2;
        root.y = note.portamentoEndY - root.height / 2;
    }

    function updatePortamentoStartPoint(aOffset)
    {
        var note = note_list_model_container.find(noteId);
        note_list_model_container.updateNote({"noteId": note.noteId,
                                              "noteText": note.noteText,
                                              "positionX":note.positionX,
                                              "positionY":note.positionY,
                                              "noteWidth": note.noteWidth,
                                              "portamentoStartX": note.portamentoStartX,
                                              "portamentoStartY": note.portamentoStartY,
                                              "portamentoStartXOffset": note.portamentoStartXOffset,
                                              "pitchChangingPointCount": note.pitchChangingPointCount,
                                              "pitchChangingPointXArray": note.pitchChangingPointXArray,
                                              "pitchChangingPointYArray": note.pitchChangingPointYArray,
                                              "portamentoEndX": note.portamentoEndX,
                                              "portamentoEndY": note.portamentoEndY,
                                              "portamentoEndXOffset": note.portamentoEndXOffset + aOffset,
                                              "vibratoAmplitude": note.vibratoAmplitude,
                                              "vibratoFrequency": note.vibratoFrequency,
                                              "vibratoLength": note.vibratoLength});
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
            updatePortamentoStartPoint(dropX - clickedPointX);
            root.Drag.drop();
        }
    }
}

