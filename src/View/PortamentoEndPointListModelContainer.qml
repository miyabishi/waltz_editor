import QtQuick 2.0

Item {
    id: root
    property ListModel portamentoEndPointListModel: ListModel{}
    property int portamentoEndPointIdCounter: 0;
    signal modelUpdated()

    function append(aNoteId, aX, aY)
    {
        portamentoEndPointListModel.append({
                                               "portamentoEndPointId": portamentoEndPointIdCounter,
                                               "noteId": aNoteId,
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
        var noteId = portamentoEndPoint.noteId;
        portamentoEndPointListModel.set(findIndexByPortamentoEndPointId(aPortamentoEndPointId),
                                        {
                                            "portamentoEndPointId": aPortamentoEndPointId,
                                             "noteId": noteId,
                                             "portamentoEndX": aPortamentoEndX,
                                             "portamentoEndY": aPortamentoEndY,
                                             "portamentoEndXOffset": portamentoEndPoint.portamentoEndXOffset
                                        });

        modelUpdated();
    }

    function updateOffset(aPortamentoEndPointId,aOffset)
    {
        var portamentoEndPoint = find(aPortamentoEndPointId);
        portamentoEndPointListModel.set(findIndexByPortamentoEndPointId(aPortamentoEndPointId),
                                        {
                                            "portamentoEndPointId": aPortamentoEndPointId,
                                             "noteId": portamentoEndPoint.noteId,
                                             "portamentoEndX": portamentoEndPoint.portamentoEndX,
                                             "portamentoEndY": portamentoEndPoint.portamentoEndY,
                                             "portamentoEndXOffset": aOffset
                                        });
        modelUpdated();
    }

    function findByNoteId(aNoteId)
    {
        for(var index = 0; index < portamentoEndPointListModel.count; ++index)
        {
            var portamentoEndPoint = portamentoEndPointListModel.get(index);
            if (portamentoEndPoint.noteId !== aNoteId) continue;
            return portamentoEndPoint;
        }
        return;
    }

    function find(aPortamentoEndPointId)
    {
        var portamentoEndPoint = portamentoEndPointListModel.get(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
        return portamentoEndPoint;
    }

    function findPoint(aPortamentoEndPointId)
    {
        var portamentoEndPoint = find(aPortamentoEndPointId);
        return Qt.point(portamentoEndPoint.portamentoEndX, portamentoEndPoint.portamentoEndY);
    }

    function findIndexByPortamentoEndPointId(aPortamentoEndPointId)
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
