import QtQuick 2.0

Rectangle {
    id: root
    property int pNoteId_: noteId
    property string pNoteText_: noteText

    border.color: "#000000"
    border.width: 1
    color: "#555555"

    Connections{
        target: MainWindowModel
        onScoreUpdated:{
            reload();
        }
    }


    function reload()
    {

        root.pNoteText_ = MainWindowModel.noteText(root.pNoteId_);
        var notePoint = MainWindowModel.notePoint(root.pNoteId_);
        root.x = notePoint.x;
        root.y = notePoint.y;
        root.width = MainWindowModel.noteRectWidth(note_rect.pNoteId_);
        root.height = edit_area.rowHeight;
    }

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
    }
}
