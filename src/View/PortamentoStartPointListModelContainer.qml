import QtQuick 2.0

Item {
    id: root
    property ListModel portamentoStartPointListModel: ListModel{}
    signal modelUpdated()

    function append(aNoteId, aX, aY)
    {
        portamentoEndPointListModel.append({
                                               "portamentoEndPointId": portamentoEndPointIdCounter,
                                               "noteId": note.noteId,
                                               "portamentoEndX": aX,
                                               "portamentoEndY": aY,
                                               "portamentoEndXOffset": 0
                                           });
        portamentoEndPointIdCounter++;
        modelUpdated();
    }

    function getModel()
    {
        return portamentoEndPointListModel;
    }

    function updateBasePoint(aPortamentoEndPointId, aPortamentoEndX, aPortamentoEndY)
    {
        var portamentoEndPoint = find(aPortamentoEndPointId);
        var noteId = portamentoEndoPoint.noteId;
        var portamentoEndX = portamentoEndPoint.portamentoEndX;
        var portamentoEndY = portamentoEndPoint.portamentoEndY;

        pitchChangingPointListModel.remove(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
        pitchChangingPointListModel.append({
                                               "portamentoEndPointId": aPortamentoEndPointId,
                                               "noteId": noteId,
                                               "portamentoEndX": portamentoEndX,
                                               "portamentoEndY": portamentoEndY,
                                               "portamentoEndXOffset": portamentoEndoPoint.portamentoEndoXOffset
                                           });
        modelUpdated();
    }

    function updateOffset(aPortamentoEndPointId,aOffset)
    {
        var portamentoEndoPoint = find(aPortamentoEndPointId);

        pitchChangingPointListModel.remove(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
        pitchChangingPointListModel.append({
                                               "portamentoEndPointId": aPortamentoEndPointId,
                                               "noteId": portamentoEndoPoint.noteId,
                                               "portamentoEndX": portamentoEndoPoint.portamentoEndX,
                                               "portamentoEndY": portamentoEndoPoint.portamentoEndY,
                                               "portamentoEndXOffset": aOffset
                                           });
        modelUpdated();
    }

    function find(aPortamentoEndPointId)
    {
        return portamentoEndPointListModel.get(findIndexIndexByPortamentoEndPointId(aPortamentoEndPointId));
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
