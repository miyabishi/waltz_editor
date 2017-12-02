import QtQuick 2.0

Item {
    property ListModel noteVolumeListModel:ListModel{}
    property int noteVolumeIdCounter: 0
    signal modelUpdated()

    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfNoteVolumeHasNoteId(aNoteId);
        }
    }

    function removeIfNoteVolumeHasNoteId(aNoteId)
    {
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var noteVolume = noteVolumeListModel.get(index);
            if (noteVolume.noteId !== aNoteId) continue;
            noteVolumeListModel.remove(index);
            return;
        }
    }

    function reflect()
    {
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var noteVolume = noteVolumeListModel.get(index);
            MainWindowModel.appendNoteVolume(noteVolume.noteId, noteVolume.volume);
        }
    }

    function append(aNoteId, aVolume)
    {
        noteVolumeListModel.append({
                                       "noteVolumeId": noteVolumeIdCounter,
                                       "noteId": aNoteId,
                                       "volume": aVolume
                                   });
        ++noteVolumeIdCounter;
        modelUpdated();
    }

    function updateNoteVolume(aNoteVolumeId, aVolume)
    {
        var noteVolumeIndex = findIndexByNoteVolumeId(aNoteVolumeId);
        var noteVolume = find(aNoteVolumeId);
        var noteId = noteVolume.noteId;
        noteVolumeListModel.set(noteVolumeIndex,
                                {
                                    "noteVolumeId": aNoteVolumeId,
                                    "noteId": noteId,
                                    "volume": aVolume
                                });
    }

    function findIndexByNoteVolumeId(aNoteVolumeId)
    {
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var noteVolume = noteVolumeListModel.get(index);
            if (noteVolume.noteVolumeId !== aNoteVolumeId) continue;
            return index;
        }

        return -1;
    }

    function getModel()
    {
        return noteVolumeListModel;
    }

    function findByNoteId(aNoteId)
    {
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var noteVolume = noteVolumeListModel.get(index);
            if (noteVolume.noteId !== aNoteId) continue;
            return noteVolume;
        }
        return -1;
    }

    function find(aNoteVolumeId)
    {
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var noteVolume = noteVolumeListModel.get(index);
            if (noteVolume.noteVolumeId !== aNoteVolumeId) continue;
            return noteVolume;
        }
        return -1;
    }
}
