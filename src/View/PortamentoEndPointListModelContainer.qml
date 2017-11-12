import QtQuick 2.0

Item {
    id: root
    property ListModel portamentoEndPointListModel: ListModel{}
    property int portamentoEndPointIdCounter: 0;
    signal modelUpdated()

    function append(aNoteId, aX, aY)
    {
        // TODO
        var note = note_list_model_container.find(aNoteId);
        if (note === 0) return;

        var portamentEndX = note.positionX - aX;
        var portamentEndY = note.positionY - aY;


        portamentoEndPointListModel.append({
                                               "portamentoEndPointId": portamentoEndPointIdCounter,
                                               "noteId": note.noteId,
                                               "portamentEndX": portamentEndX,
                                               "portamentEndY": portamentEndY
                                           });
        portamentoEndPointIdCounter++;
        modelUpdated();
    }

    function getModel()
    {
        return portamentoEndPointListModel;
    }

    function update(aPortamentoEndPointId, aPortamentoEndX, aPortamentoEndY)
    {
        var portamentoEndoPoint = find(aPortamentoEndPointId);
        var noteId = portamentoEndoPoint.noteId;
        var note = note_list_model_container.find(noteId);
        if (note === 0) return;

        var portamentoEndX = note.positionX - aPortamentoEndX;
        var portamentoEndY = note.positionY - aPortamentoEndY;


        pitchChangingPointListModel.remove(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
        pitchChangingPointListModel.append({
                                               "portamentoEndPointId": aPortamentoEndPointId,
                                               "noteId": noteId,
                                               "portamentoEndX": portamentoEndX,
                                               "portamentoEndY": portamentoEndY
                                           });
        modelUpdated();
    }

    function find(aPitchChangingPointId)
    {
        return pitchChangingPointListModel.get(findIndexByPitchChangingPointId(aPitchChangingPointId));
    }

    function findPoint(aPortamentoEndPointId)
    {
        var portamentoEndPoint = find(aPortamentoEndPointId);
        return Qt.point(portamentoEndPoint.portamentoEndX, portamentoEndPoint.portamentoEndY);
    }

    function findIndexIndexByPortamentoEndPointId(aPortamentoEndPointId)
    {
        for(var index = 0; index < portamentoEndPointListModel.count; ++index)
        {
            var portamentoEndPoint = portamentoEndPointListModel.get(index);
            if (portamentoEndPoint.portamentoEndPointId !== aPortamentoEndPointId) continue;
            return index;
        }
        return 0;
    }
}
