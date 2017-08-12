import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    id: note_rect

    property int pNoteId_: noteId
    property string pNoteText_: noteText
    property bool pEditing_: false
    property bool dragActive: note_mouse_area.drag.active

    border.color: "#000000"
    border.width: 1
    color:"#ffd700"
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0
    Drag.active: dragActive

    onDragActiveChanged: {
        console.log("Drag Active Changed! " + dragActive)
    }

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
    }

    MouseArea{
        id: note_mouse_area
        property bool pHeld_ : false
        anchors.fill: parent
        cursorShape: Qt.ArrowCursor
        acceptedButtons: Qt.LeftButton
        propagateComposedEvents: pEditing_

        drag.target: note_rect
        onReleased: {
            console.log("released!")
            note_rect.Drag.drop()
        }

        onDoubleClicked: {
            console.log("note double clicked")
            if(mouse.modifiers & Qt.ControlModifier)
            {
                return
            }
            note_rect.pEditing_ = true
        }
    }

    TextField{
        visible: pEditing_
        focus: pEditing_
        text: parent.pNoteText_
        width: 60
        onAccepted: {
            parent.pEditing_ = false
            MainWindowModel.updateNote(parent.pNoteId_, parent.pNoteText_, parent.x, parent.y, parent.width)
        }
        onFocusChanged: {
            piano_roll_mouse_area.enabled = !focus
            note_mouse_area.enabled = !focus
            if (!focus)
            {
                parent.pEditing_ = false;
                parent.pNoteText_ = text;
            }
        }
    }

}


