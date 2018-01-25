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
        onModelUpdated:{
            reload(aNoteId);
        }
    }

    function reload(aNoteId)
    {
        var note = note_list_model_container.find(aNoteId);
        if(! note) return;

        var noteVolume = findByNoteId(aNoteId)
        var noteVolumeIndex = findIndexByNoteVolumeId(noteVolume.noteVolumeId);

        noteVolumeListModel.set(noteVolumeIndex,
                                {
                                    "noteVolumeId": noteVolume.noteVolumeId,
                                    "noteId": noteVolume.noteId,
                                    "positionX": note.positionX,
                                    "volume": noteVolume.volume
                                });
        modelUpdated();
    }


    function removeIfNoteVolumeHasNoteId(aNoteId)
    {
        var removeIndex = -1;
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var noteVolume = noteVolumeListModel.get(index);
            if (noteVolume.noteId !== aNoteId) continue;
            removeIndex = index;
            break;
        }

        if (removeIndex >= 0)
        {
            noteVolumeListModel.remove(removeIndex);
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
        var note = note_list_model_container.find(aNoteId);
        noteVolumeListModel.append({
                                       "noteVolumeId": noteVolumeIdCounter,
                                       "noteId": aNoteId,
                                       "positionX": note.positionX,
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
        var note = note_list_model_container.find(noteId);
        noteVolumeListModel.set(noteVolumeIndex,
                                {
                                    "noteVolumeId": aNoteVolumeId,
                                    "noteId": noteId,
                                    "positionX": note.positionX,
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

    function toArray()
    {
        var ary = new Array;
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var note = noteVolumeListModel.get(index);
             ary[index] = note;
        }
        return ary
    }
}
