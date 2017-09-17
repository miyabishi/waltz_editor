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

    property int pPortamentStartX_ : -10
    property int pPortamentStartY_ : (height/2)
    property int pPortamentEndX_ : 10
    property int pPortamentEndY_ : (height/2)


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


    Canvas {
        id: canvas
        function min(aA, aB)
        {
            if (aA > aB)
            {
                return aB
            }
            return aA
        }

        function abs(aX)
        {
            if (aX < 0)
            {
                return aX * -1
            }
            return aX
        }

        function calculateCanvasX()
        {
            return note_rect.pPortamentStartX_
        }

        function calculateCanvasY()
        {
            return min(0, note_rect.pPortamentEndY_)
        }

        function calculateCanvasWidth()
        {
            return abs(note_rect.pPortamentEndX_ - note_rect.pPortamentStartX_)
        }

        function calculateCanvasHeight()
        {
            return abs(note_rect.pPortamentEndY_ - note_rect.pPortamentStartY_ + note_rect.height * 2)
        }

        x: calculateCanvasX()
        y: calculateCanvasY()
        width: calculateCanvasWidth()
        height: calculateCanvasHeight()

        onPaint: {
            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = Qt.rgba(.4,.6,.8);
            ctx.beginPath();
            ctx.moveTo(note_rect.pPortamentStartX_, note_rect.pPortamentStartY_);
            ctx.bezierCurveTo(note_rect.pPortamentStartX_, note_rect.pPortamentStartY_ + 100,
                              note_rect.pPortamentEndX_ -10, note_rect.pPortamentEndY_,
                              note_rect.pPortamentEndX_, note_rect.pPortamentEndY_);
            ctx.lineWidth = 2;
            ctx.stroke();
            ctx.restore();
        }
    }

    Component.onCompleted: {

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


