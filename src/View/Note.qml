import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    id: note_rect
    property int pNoteId_: noteId
    property string pNoteText_: noteText
    property bool pEditing_: false
//        width: edit_area.columnWidth
//        height: edit_area.rowHeight

    border.color: "#000000"
    border.width: 1
    color:"#ffd700"

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
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

    MouseArea{
        id: note_mouse_area
        anchors.fill: parent
        cursorShape: Qt.SizeAllCursor
        acceptedButtons: Qt.LeftButton
        propagateComposedEvents: true
        onDoubleClicked: {
            if(mouse.modifiers & Qt.ControlModifier)
            {
                return
            }
            note_rect.pEditing_ = true
            mouse.accepted = false
        }
        onClicked: {
            mouse.accepted = false
        }
    }
}


