import QtQuick 2.0

Rectangle {
    id: root
    property int pNoteId_
    property string pNoteText_

    border.color: "#000000"
    border.width: 1
    color: "#555555"

    Connections{
        target: note_list_model_container
        onModelUpdated:{
            reload();
        }
    }

    function reload()
    {
        var note = note_list_model_container.find(root.pNoteId_)
        root.pNoteText_ = note.noteText;
        root.x = note.positionX;
        root.y = note.positionY;
        root.width = note.noteWidth;
        root.height = edit_area.rowHeight;
    }

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
    }
}
