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


    property bool dragActive: note_move_mouse_area.drag.active | note_stretch_mouse_area.drag.active



    border.color: "#000000"
    border.width: 1
    color: "#ffd700"
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0
    Drag.active: dragActive

    function updateNote()
    {
        updatePortamento();
        MainWindowModel.updateNote(note_rect.pNoteId_,
                                   note_rect.pNoteText_,
                                   note_rect.x,
                                   note_rect.y,
                                   note_rect.width,
                                   note_rect.portamentStartX,
                                   note_rect.portamentStartY,
                                   note_rect.pitchChangingPointXArray,
                                   note_rect.pitchChangingPointYArray,
                                   note_rect.portamentEndX,
                                   note_rect.portamentEndY);
    }

    function updatePortamento()
    {
        note_rect.portamentoStartY = MainWindowModel.yPositionOfPreviousNote(note_rect.x - 1,
                                                                             note_rect.x + note_rect.height / 2,
                                                                             note_rect.pNoteId_);
        note_rect.portamentoEndY = note_rect.y + note_rect.height / 2;

        canvas.requestPaint()
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

    Canvas {
        id: canvas
        x: -30
        y: -note_rect.y
        height: piano_roll_edit_area.height
        width: 60

        onPaint: {
            console.log("y:" + y)
            console.log("height:" + height)
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
            aCtx.clearRect(0,0,canvas.width, canvas.height);
            console.log("draw");

            aCtx.moveTo(note_rect.portamentoStartX, note_rect.portamentoStartY);

            console.log("portamentoStartX:" + note_rect.portamentoStartX);
            console.log("portamentoStartY:" + note_rect.portamentoStartY);

            var preControlX = note_rect.portamentoStartX + 30
            var preControlY = note_rect.portamentoStartY;

            for (var index = 0; index < pitchChangingPointCount; ++index)
            {
                var changingPointX = note_rect.pitchChangingPointXArray[index];
                var changingPointY = note_rect.pitchChangingPointYArray[index]
                aCtx.bezierCurveTo(preControlX, preControlY,
                                   changingPointX - 10, changingPointY,
                                   changingPointX, changingPointY);
                preControlX = changingPointX + 10;
                preControlY = changingPointY;
            }

            console.log("preControlX:" + preControlX);
            console.log("preControlX:" + preControlY);

            console.log("portamentoEndX:" + note_rect.portamentoEndX);
            console.log("portamentoEndY:" + note_rect.portamentoEndY);

            aCtx.bezierCurveTo(preControlX, preControlY,
                               note_rect.portamentoEndX - 30, note_rect.portamentoEndY,
                               note_rect.portamentoEndX, note_rect.portamentoEndY);

            /*
            var previousNoteYPosition = MainWindowModel.yPositionOfPreviousNote(note_rect.x - 1,
                                                                                note_rect.y + note_rect.height/2,
                                                                                aNoteId)
            aCtx.moveTo(0, previousNoteYPosition)
            aCtx.bezierCurveTo(30, previousNoteYPosition,
                               canvas.width - 30, note_rect.y + note_rect.height/2,
                               canvas.width, note_rect.y + note_rect.height/2);
            */
        }
    }


}


