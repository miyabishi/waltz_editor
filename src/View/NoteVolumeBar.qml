import QtQuick 2.0

Rectangle {
    id: root
    color: "#ff7799"
    property int noteVolumeId

    Connections{
        target:volume_edit_area
        onToUpdateNoteVolume: {
            reloadNoteVolume();
        }
    }

    function reloadNoteVolume()
    {
        var noteVolume = note_volume_list_model_container.find(noteVolumeId);
        root.height = volume_edit_area.noteVolumeBarHeight(noteVolume.volume)
        root.y = volume_edit_area.min - root.height;
    }

    MouseArea{
        anchors.fill: parent
        drag.target: root
        drag.axis: Drag.YAxis
        acceptedButtons: Qt.LeftButton

        onMouseYChanged: {
            if(drag.active)
            {
                root.height -= mouseY
                root.y = volume_edit_area.min - root.height;
            }
        }

        onPressed: {
            if(drag.active)
            {
                root.height -= mouseY
                root.y = volume_edit_area.min - root.height;
            }
        }

        onReleased: {
            var volume = volume_edit_area.calculateVolume(height);
            note_volume_list_model_container.updateNoteVolume(noteVolumeId, volume);
            MainWindowModel.writeHistory(main_window.createSaveData());
        }
    }
}
