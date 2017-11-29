import QtQuick 2.0

Item {
    property ListModel noteVolumeListModel:ListModel{}
    property int noteVolumeIdCounter: 0
    signal modelUpdated()

    function append(aVolume)
    {
        noteVolumeListModel.append({
                                       "noteVolumeId": noteVolumeIdCounter,
                                       "volume": aVolume
                                   });
        ++noteVolumeIdCounter;
        modelUpdated();
    }
}
