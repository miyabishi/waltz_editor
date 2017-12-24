import QtQuick 2.0

Item {
    id:root
    property ListModel vibratoListModel: ListModel{}
    property int vibratoIdCounter: 0;
    signal modelUpdated()

    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfVibratoHasNoteId(aNoteId)
        }
    }

    function removeIfVibratoHasNoteId(aNoteId)
    {
        var index = findIndexByNoteId(aNoteId);
        if(index >= 0)
        {
            vibratoListModel.remove(index);
        }
    }

    function append(aNoteId, aLength, aWavelength, aAmplitude)
    {
        vibratoListModel.append({
                                    "vibratoId": vibratoIdCounter,
                                    "noteId": aNoteId,
                                    "length": aLength,
                                    "wavelength": aWavelength,
                                    "amplitude": aAmplitude
                                });
        ++vibratoIdCounter;
        modelUpdated();
    }

    function updateVibratoLength(aVibratoId, aLength)
    {
        var index = findIndexByVibratoId(aVibratoId);
        var vibrato = vibratoListModel.get(index);
        vibratoListModel.set(index,
                             {
                                 "vibratoId": vibrato.vibratoId,
                                 "noteId": vibrato.noteId,
                                 "length": aLength,
                                 "wavelength": vibrato.wavelength,
                                 "amplitude": vibrato.amplitude
                             });
        modelUpdated();
    }



    function contains(aVibratoId)
    {
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            if(vibrato.vibratoId !== aVibratoId) continue;
            return true;
        }
        return false;
    }

    function removeByNoteId(aNoteId)
    {
        var index = findIndexByNoteId(aNoteId);
        vibratoListModel.remove(index);
        modelUpdated();
    }

    function doesNoteHaveVibrato(aNoteId)
    {
        return findIndexByNoteId(aNoteId) >= 0;
    }

    function findIndexByVibratoId(aVibratoId)
    {
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            if(vibrato.vibratoId !== aVibratoId) continue;
            return index;
        }
        return;
    }

    function findIndexByNoteId(aNoteId)
    {
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            if(vibrato.noteId !== aNoteId) continue;
            return index;
        }
        return -1;
    }

    function find(aVibratoId)
    {
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            if (vibrato.vibratoId !== aVibratoId) continue;
            return vibrato;
        }
        return;
    }

    function count()
    {
        return vibratoListModel.count
    }

    function findByIndex(aIndex)
    {
        return vibratoListModel.get(aIndex);
    }

    function getModel()
    {
        return vibratoListModel;
    }
}
