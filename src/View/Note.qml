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


    property bool dragActive: note_move_mouse_area.drag.active | note_stretch_mouse_area.drag.active



    border.color: "#000000"
    border.width: 1
    color: "#ffd700"
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0
    Drag.active: dragActive

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
    }

    function updateNote()
    {
        MainWindowModel.updateNote(note_rect.pNoteId_,
                                   note_rect.pNoteText_,
                                   note_rect.x,
                                   note_rect.y,
                                   note_rect.width)
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

    Canvas {
        id: canvas
        x: MainWindowModel.portamentStartX(note_rect.pNoteId_)
        y: note_rect.y - edit_area.height
        height: edit_area.height
        width: MainWindowModel.portamentEndX(note_rect.pNoteId_) - MainWindowModel.portamentStartX(note_rect.pNoteId_)

        onPaint: {
            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = Qt.rgba(.4,.6,.8);
            ctx.beginPath();

            drawPortamento(ctx, note_rect.pNoteId_);

            ctx.lineWidth = 2;
            ctx.stroke();
            ctx.restore();
        }

        function drawPortamento(aCtx, aNoteId)
        {
            aCtx.moveTo(MainWindowModel.portamentStartX(aNoteId), MainWindowModel.portamentStartY(aNoteId));
            var preControlX = MainWindowModel.portamentStartControlX(aNoteId);
            var preControlY = MainWindowModel.portamentStartControlY(aNoteId);

            for(var index = 0; index < MainWindowModel.pitchChangingPointCount(pNoteId_); ++index)
            {
                aCtx.bezierCurveTo(preControlX,preControlY,
                                  MainWindowModel.pitchChangingPointControlX(aNoteId, index), MainWindowModel.pitchChangingPointControlY(aNoteId, index),
                                  MainWindowModel.pitchChangingPointX(aNoteId, index), MainWindowModel.pitchChangingPointY(aNoteId, index));

                preControlX = -MainWindowModel.pitchChangingPointControlX(aNoteId, index);
                preControlY = -MainWindowModel.pitchChangingPointControlY(aNoteId, index);
            }

            aCtx.bezierCurveTo(preControlX,preControlY,
                              MainWindowModel.portamentEndControlX(aNoteId),MainWindowModel.portamentEndControlY(aNoteId),
                              MainWindowModel.portamentEndX(aNoteId), MainWindowModel.portamentEndY(aNoteId));
        }
    }


}


