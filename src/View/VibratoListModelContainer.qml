import QtQuick 2.0

Item {
    id:root
    property ListModel vibratoListModel: ListModel{}
    property int vibratoIdCounter: 0;
    signal modelUpdated()

    function append(aNoteId, aLength, aWavelength, aAmplitude)
    {
        console.log("apend");
        console.log("note id: " + aNoteId);
        console.log("length: " + aLength);
        console.log("wavelength: " + aWavelength);
        console.log("amplitude: " + aAmplitude);
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
