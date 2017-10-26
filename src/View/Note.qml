import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    id: root
    property int pNoteId_
    property string pNoteText_
    property bool pEditing_: false
    property bool pStretching_: false
    property int positionX
    property int positionY

    property int portamentoStartX
    property int portamentoStartY
    property int pitchChangingPointCount:0
    property var pitchChangingPointXArray:[]
    property var pitchChangingPointYArray:[]
    property int portamentoEndX
    property int portamentoEndY

    property double vibratoAmplitude
    property double vibratoFrequency
    property int vibratoLength

    border.color: "#000000"
    border.width: 1
    color: "#ffd700"
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0
    Drag.active: note_move_mouse_area.drag.active

    Connections{
        target: note_list_model_container
        onModelUpdated:{
            reload();
        }
    }

    function updateNote()
    {
        portamentoStartX = x - 30;
        portamentoStartY = note_list_model_container.yPositionOfPreviousNote(root.x - 1,
                                                                                  root.y + root.height / 2,
                                                                                  root.pNoteId_);
        portamentoEndX = x + 30;
        portamentoEndY = y + height / 2;
        positionX = x;
        positionY = y;

        note_list_model_container.updateNote({"noteId": pNoteId_,
                                              "noteText": pNoteText_,
                                              "positionX":positionX,
                                              "positionY":positionY,
                                              "noteWidth": width,
                                              "portamentoStartX": portamentoStartX,
                                              "portamentoStartY": portamentoStartY,
                                              "pitchChangingPointCount": pitchChangingPointCount,
                                              "pitchChangingPointXArray": pitchChangingPointXArray,
                                              "pitchChangingPointYArray": pitchChangingPointYArray,
                                              "portamentoEndX": portamentoEndX,
                                              "portamentoEndY": portamentoEndY,
                                              "vibratoAmplitude": vibratoAmplitude,
                                              "vibratoFrequency": vibratoFrequency,
                                              "vibratoLength": vibratoLength});
    }

    function reload()
    {
        var note = note_list_model_container.find(root.pNoteId_);
        note.portamentoStartX = root.x - 30;
        note.portamentoStartY = note_list_model_container.yPositionOfPreviousNote(root.x - 1,
                                                                                  root.y + root.height / 2,
                                                                                  root.pNoteId_);
        note.portamentoEndX = root.x + 30;
        note.portamentoEndY = root.y + root.height / 2;

        root.pNoteText_ = note.noteText;
        root.x = note.positionX
        root.y = note.positionY
        root.positionX = note.positionX;
        root.positionY = note.positionY;
        root.width = note.noteWidth;

        root.portamentoStartX = note.portamentoStartX;
        root.portamentoStartY = note.portamentoStartY;

        root.pitchChangingPointXArray= note.pitchChangingPointXArray;
        root.pitchChangingPointYArray= note.pitchChangingPointYArray;

        root.portamentoEndX = note.portamentoEndX;
        root.portamentoEndY = note.portamentoEndY;

        root.vibratoAmplitude = note.vibratoAmplitude;
        root.vibratoFrequency = note.vibratoFrequency;
        root.vibratoLength = note.vibratoLength;
    }

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
    }

    MouseArea{
        id: note_move_mouse_area
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: note_stretch_mouse_area.left
        acceptedButtons: Qt.LeftButton
        propagateComposedEvents: pEditing_
        drag.target: root

        onReleased: {
            root.updateNote()
            root.Drag.drop()
        }

        onDoubleClicked: {
            if(mouse.modifiers & Qt.ControlModifier)
            {
                return
            }
            root.pEditing_ = true
        }
    }

    MouseArea{
        id: note_stretch_mouse_area
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        drag.axis: Drag.XAxis
        width: 10
        property int pPressedX_: 0

        acceptedButtons: Qt.LeftButton
        drag.target: root

        onMouseXChanged: {
            if(drag.active)
            {
                root.x = pPressedX_
                root.width += mouseX
            }
        }

        onPressed: {
            root.pStretching_ = true
            pPressedX_ = root.x
            root.focus = true
        }

        onReleased: {
            root.pStretching_ = false
            root.updateNote()
            root.Drag.drop()
        }
    }

    TextField{
        visible: pEditing_
        focus: pEditing_
        text: parent.pNoteText_
        width: 60
        onAccepted: {
            parent.pEditing_ = false
            root.updateNote()
        }
        onFocusChanged: {
            piano_roll_mouse_area.enabled = !focus
            note_move_mouse_area.enabled = !focus
        }
    }
}


