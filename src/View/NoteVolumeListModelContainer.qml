import QtQuick 2.0

Item {
    property ListModel noteVolumeListModel:ListModel{}
    property int noteVolumeIdCounter: 0
    signal modelUpdated()

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
