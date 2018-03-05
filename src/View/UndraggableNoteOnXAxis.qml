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
        root.width = note.noteWidth;
    }

    Text{
        text: noteText
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Meiryo"
        font.pointSize: 10
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
            {
                if(vibrato_list_model_container.doesNoteHaveVibrato(parent.noteId))
                {
                    vibrato_list_model_container.removeByNoteId(parent.noteId)
                    return;
                }

                vibrato_list_model_container.append(parent.noteId,
                                                    parent.width / 3,
                                                    20,
                                                    0.5);
                MainWindowModel.writeHistory(main_window.createSaveData());
            }
        }
    }
}
