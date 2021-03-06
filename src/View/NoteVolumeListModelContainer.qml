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
        if(note < 0) return;

        var noteVolume = findByNoteId(aNoteId)
        var noteVolumeIndex = findIndexByNoteVolumeId(noteVolume.noteVolumeId);
        if (noteVolumeIndex >= noteVolumeListModel.count || noteVolumeIndex < 0) return;

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
        if (note < 0) return;

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

        if (noteVolumeIndex >= noteVolumeListModel.count || noteVolumeIndex < 0) return;

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

    function setArray(ary)
    {
        noteVolumeListModel.clear();
        noteVolumeIdCounter = 0;

        for(var index = 0; index < ary.length; ++index)
        {
            var volume = ary[index];
            noteVolumeListModel.append({
                "noteVolumeId": volume.noteVolumeId,
                "noteId": volume.noteId,
                "positionX": volume.positionX,
                "volume": volume.volume
            });

            if(noteVolumeIdCounter <= volume.noteVolumeId)
            {
                noteVolumeIdCounter = volume.noteVolumeId;
            }
        }
        noteVolumeIdCounter++;
        modelUpdated();
    }

    function toArray()
    {
        var ary = new Array;
        for(var index = 0; index < noteVolumeListModel.count; ++index)
        {
            var volume = noteVolumeListModel.get(index);
            ary[index] = {
                "noteVolumeId": volume.noteVolumeId,
                "noteId": volume.noteId,
                "positionX": volume.positionX,
                "volume": volume.volume
            };
        }
        return ary
    }

    function pasteFromClipboard(aData, aX, aNoteIdOffset)
    {
        var ary = aData.volume;
        if(!ary) return;
        for(var index = 0; index < ary.length; ++index)
        {
            var volume = ary[index];
            noteVolumeIdCounter++;
            noteVolumeListModel.append({
                "noteVolumeId": noteVolumeIdCounter,
                "noteId": volume.noteId + aNoteIdOffset,
                "positionX": volume.positionX + aX,
                "volume": volume.volume
            });
        }
        noteVolumeIdCounter++;
        modelUpdated();
    }

    function createClipboardData(aXOffset)
    {
        var volumeAry = new Array;
        for (var index = 0; index < selected_note_list_model_container.count(); index++)
        {
            var noteId = selected_note_list_model_container.findNoteIdByIndex(index);
            var volume = findByNoteId(noteId);
            volumeAry[index] = {
                "noteVolumeId": volume.noteVolumeId,
                "noteId": volume.noteId,
                "positionX": volume.positionX - aXOffset,
                "volume": volume.volume
            };
        }
        return volumeAry;
    }
}
