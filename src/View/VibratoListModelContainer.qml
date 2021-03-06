import QtQuick 2.0

Item {
    id:root
    property ListModel vibratoListModel: ListModel{}
    property int vibratoIdCounter: 0;
    signal modelUpdated(real aVibratoId)

    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfVibratoHasNoteId(aNoteId)
        }
    }

    function refresh()
    {
        var tempModel = new Array;
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            tempModel[index] = {
                "vibratoId": vibrato.vibratoId,
                "noteId": vibrato.noteId,
                "length": vibrato.length,
                "wavelength": vibrato.wavelength,
                "amplitude": vibrato.amplitude};
        }

        vibratoListModel.clear();
        for(var aryIndex = 0; aryIndex < tempModel.length; ++aryIndex)
        {
            var vibratoAry = tempModel[aryIndex];
            vibratoListModel.append({
                "vibratoId": vibratoAry.vibratoId,
                "noteId": vibratoAry.noteId,
                "length": vibratoAry.length,
                "wavelength": vibratoAry.wavelength,
                "amplitude": vibratoAry.amplitude
            });
        }
    }

    function reflect()
    {
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            MainWindowModel.appendVibrato(vibrato.noteId,
                                          vibrato.length,
                                          vibrato.wavelength,
                                          vibrato.amplitude);
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
        modelUpdated(vibratoIdCounter);
        ++vibratoIdCounter;
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
        modelUpdated(vibrato.vibratoId);
    }

    function updateVibratoWavelength(aVibratoId, aWavelength)
    {
        var index = findIndexByVibratoId(aVibratoId);
        var vibrato = vibratoListModel.get(index);
        vibratoListModel.set(index,
                             {
                                 "vibratoId": vibrato.vibratoId,
                                 "noteId": vibrato.noteId,
                                 "length": vibrato.length,
                                 "wavelength": aWavelength,
                                 "amplitude": vibrato.amplitude
                             });
        modelUpdated(vibrato.vibratoId);
    }

    function updateVibratoAmplitude(aVibratoId, aAmplitude)
    {
        var index = findIndexByVibratoId(aVibratoId);
        var vibrato = vibratoListModel.get(index);
        vibratoListModel.set(index,
                             {
                                 "vibratoId": vibrato.vibratoId,
                                 "noteId": vibrato.noteId,
                                 "length": vibrato.length,
                                 "wavelength": vibrato.wavelength,
                                 "amplitude": aAmplitude
                             });
        modelUpdated(vibrato.vibratoId);
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
        var vibrato = vibratoListModel.get(index);
        var vibratoId = vibrato.vibratoId;
        vibratoListModel.remove(index);
        modelUpdated(vibratoId);
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

    function getAmplitude(aVibratoId)
    {
        var vibrato = find(aVibratoId);
        return vibrato.amplitude;
    }

    function calculateVibratoStartPoint(aVibratoId, aNoteId)
    {
        var vibrato = root.find(aVibratoId)
        var note = note_list_model_container.find(aNoteId);
        return note.positionX + note_list_model_container.getWidth(aNoteId) - vibrato.length;
    }

    function calculateVibratoAmplitudeControlPointX(aVibratoId, aNoteId)
    {
        var note = note_list_model_container.find(aNoteId);

        return note.positionX + note_list_model_container.getWidth(aNoteId);
    }

    function calculateVibratoWavelengthEndPoint(aVibratoId, aNoteId)
    {
        var vibrato = find(aVibratoId);
        return calculateVibratoStartPoint(aVibratoId, aNoteId) + vibrato.wavelength
    }

    function findByNoteId(aNoteId)
    {
        return findByIndex(findIndexByNoteId(aNoteId));
    }

    function getModel()
    {
        return vibratoListModel;
    }

    function setArray(ary)
    {
        vibratoListModel.clear();
        vibratoIdCounter = 0;

        for(var index = 0; index < ary.length; ++index)
        {
            var vibrato = ary[index];
            vibratoListModel.append({
                "vibratoId": vibrato.vibratoId,
                "noteId": vibrato.noteId,
                "length": vibrato.length,
                "wavelength": vibrato.wavelength,
                "amplitude": vibrato.amplitude
            });
            modelUpdated(vibrato.vibratoId);
            if(vibratoIdCounter <= vibrato.vibratoId)
            {
                vibratoIdCounter = vibrato.vibratoId;
            }
        }
        vibratoIdCounter++;
    }

    function toArray()
    {
        var ary = new Array;
        for(var index = 0; index < vibratoListModel.count; ++index)
        {
            var vibrato = vibratoListModel.get(index);
            ary[index] = {
                "vibratoId": vibrato.vibratoId,
                "noteId": vibrato.noteId,
                "length": vibrato.length,
                "wavelength": vibrato.wavelength,
                "amplitude": vibrato.amplitude
            };
        }
        return ary
    }

    function createClipboardData()
    {
        var vibratoAry = new Array;
        for (var index = 0; index < selected_note_list_model_container.count(); index++)
        {
            var noteId = selected_note_list_model_container.findNoteIdByIndex(index);
            var vibrato = findByNoteId(noteId);
            if (! vibrato) return;

            vibratoAry[index] = {
                "vibratoId": vibrato.vibratoId,
                "noteId": vibrato.noteId,
                "length": vibrato.length,
                "wavelength": vibrato.wavelength,
                "amplitude": vibrato.amplitude
            };
        }
        return vibratoAry;
    }

    function pasteFromClipboard(aData, aNoteIdOffset)
    {
        var ary = aData.vibrato;
        if (! ary) return;
        for(var index = 0; index < ary.length; ++index)
        {
            root.vibratoIdCounter++;
            var vibrato = ary[index];
            vibratoListModel.append({
                "vibratoId": vibratoIdCounter,
                "noteId": vibrato.noteId + aNoteIdOffset,
                "length": vibrato.length,
                "wavelength": vibrato.wavelength,
                "amplitude": vibrato.amplitude
            });
        }
        root.vibratoIdCounter++;

        modelUpdated();
    }

}
