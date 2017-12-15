import QtQuick 2.0

Rectangle {
    id: root
    property int noteId
    property string noteText

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
        var note = note_list_model_container.find(root.noteId)
        root.noteText = note.noteText;
        root.x = note.positionX;
        root.y = 0;
        root.width = note.noteWidth;
    }

    Text{
        text: noteText
        font.family: "Meiryo"
        font.pointSize: 10
    }
}