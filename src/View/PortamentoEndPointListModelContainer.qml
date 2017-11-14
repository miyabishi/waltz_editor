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
        var portamentoEndX = portamentoEndPoint.portamentoEndX;
        var portamentoEndY = portamentoEndPoint.portamentoEndY;

        portamentoEndPointListModel.remove(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
        portamentoEndPointListModel.append({
                                               "portamentoEndPointId": aPortamentoEndPointId,
                                               "noteId": noteId,
                                               "portamentoEndX": portamentoEndX,
                                               "portamentoEndY": portamentoEndY,
                                               "portamentoEndXOffset": portamentoEndPoint.portamentoEndoXOffset
                                           });
        modelUpdated();
    }

    function updateOffset(aPortamentoEndPointId,aOffset)
    {
        var portamentoEndPoint = find(aPortamentoEndPointId);
        console.log("update offset");
        // ここが取れていない
        console.log("portamentoEndX " + portamentoEndPoint.portamentoEndX);
        console.log("portamentoEndY " + portamentoEndPoint.portamentoEndY);
        portamentoEndPointListModel.remove(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
        portamentoEndPointListModel.append({
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
        return 0;
    }

    function find(aPortamentoEndPointId)
    {
        return portamentoEndPointListModel.get(findIndexByPortamentoEndPointId(aPortamentoEndPointId));
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
            console.log("index:" + index);
            var portamentoEndPoint = portamentoEndPointListModel.get(index);
            console.log("compare " + portamentoEndPoint.portamentoEndPointId + " : " + aPortamentoEndPointId);
            if (portamentoEndPoint.portamentoEndPointId !== aPortamentoEndPointId) continue;
            find("find:" + index);
            return index;
        }
        console.log("not found");
        return 0;
    }
}
