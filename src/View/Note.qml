import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    id: note_rect
    property int pNoteId_: noteId
    property string pNoteText_: noteText
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
    Drag.active: ! pEditing_

    Connections{
        target: MainWindowModel
        onScoreUpdated:{
            reload();
        }
    }

    function updateNoteListModel()
    {
        note_list_model_container.updateNote({"noteId": note_rect.pNoteId_,
                                              "noteText": note_rect.pNoteText_,
                                              "positionX": note_rect.positionX,
                                              "positionY": note_rect.positionY,
                                              "noteWidth": note_rect.width,
                                              "portamentoStartX": note_rect.portamentoStartX,
                                              "portamentoStartY": note_rect.portamentoStartY,
                                              "pitchChangingPointCount":pitchChangingPointCount,
                                              "pitchChangingPointXArray":pitchChangingPointXArray,
                                              "pitchChangingPointYArray":pitchChangingPointYArray,
                                              "portamentoEndX": note_rect.portamentoEndX,
                                              "portamentoEndY": note_rect.portamentoEndY,
                                              "vibratoAmplitude": note_rect.vibratoAmplitude,
                                              "vibratoFrequency": note_rect.vibratoFrequency,
                                              "vibratoLength": note_rect.vibratoLength});
    }

    function updateNote()
    {
        note_rect.portamentoStartX = note_rect.x - 30;
        note_rect.portamentoStartY = MainWindowModel.yPositionOfPreviousNote(note_rect.x - 1,
                                                                             note_rect.y + note_rect.height / 2,
                                                                             note_rect.pNoteId_);
        note_rect.portamentoEndX = note_rect.x + 30;
        note_rect.portamentoEndY = note_rect.y + note_rect.height / 2;
        note_rect.positionX = note_rect.x;
        note_rect.positionY = note_rect.y;
        MainWindowModel.updateNote(note_rect.pNoteId_,
                                   note_rect.pNoteText_,
                                   note_rect.x,
                                   note_rect.y,
                                   note_rect.width,
                                   note_rect.portamentoStartX,
                                   note_rect.portamentoStartY,
                                   note_rect.pitchChangingPointXArray,
                                   note_rect.pitchChangingPointYArray,
                                   note_rect.portamentoEndX,
                                   note_rect.portamentoEndY,
                                   note_rect.vibratoAmplitude,
                                   note_rect.vibratoFrequency,
                                   note_rect.vibratoLength);
    }

    function reload()
    {
        note_rect.pNoteText_ = MainWindowModel.noteText(note_rect.pNoteId_);
        var notePoint = MainWindowModel.notePoint(note_rect.pNoteId_);
        note_rect.x = notePoint.x;
        note_rect.y = notePoint.y;
        note_rect.width = MainWindowModel.noteRectWidth(note_rect.pNoteId_);
        var portamentStartPoint =  MainWindowModel.portamentStartPoint(note_rect.pNoteId_);
        note_rect.portamentoStartX = portamentStartPoint.x;
        note_rect.portamentoStartY = portamentStartPoint.y;

        note_rect.pitchChangingPointXArray= [];
        note_rect.pitchChangingPointYArray= [];

        for (var index = 0; index < MainWindowModel.pitchChangingPointCount(note_rect.pNoteId_); ++index)
        {
            var pitchChangingPoint = MainWindowModel.pitchChangingPoint(note_rect.pNoteId_, index);
            note_rect.pitchChangingPointXArray.push(pitchChangingPoint.x);
            note_rect.pitchChangingPointYArray.push(pitchChangingPoint.y);
        }

        var portamentEndPoint = MainWindowModel.portamentEndPoint(note_rect.pNoteId_);

        note_rect.portamentoEndX = portamentEndPoint.x;
        note_rect.portamentoEndY = portamentEndPoint.y;

        note_rect.updateNoteListModel();
    }

    function updatePortamento()
    {

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
        drag.target: note_rect

        onReleased: {
            note_rect.updateNote()
            note_rect.Drag.drop()
        }

        onDoubleClicked: {
            if(mouse.modifiers & Qt.ControlModifier)
            {
                return
            }
            note_rect.pEditing_ = true
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
        drag.target: note_rect

        onMouseXChanged: {
            if(drag.active)
            {
                note_rect.x = pPressedX_
                note_rect.width += mouseX
            }
        }

        onPressed: {
            note_rect.pStretching_ = true
            pPressedX_ = note_rect.x
            note_rect.focus = true
        }

        onReleased: {
            note_rect.pStretching_ = false
            note_rect.updateNote()
            note_rect.Drag.drop()
        }
    }

    TextField{
        visible: pEditing_
        focus: pEditing_
        text: parent.pNoteText_
        width: 60
        onAccepted: {
            parent.pEditing_ = false
            note_rect.updateNote()
        }
        onFocusChanged: {
            piano_roll_mouse_area.enabled = !focus
            note_move_mouse_area.enabled = !focus
            if (!focus)
            {
                parent.pEditing_ = false;
                parent.pNoteText_ = text;
            }
        }
    }
}


