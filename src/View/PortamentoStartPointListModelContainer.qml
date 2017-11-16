import QtQuick 2.0

Item {
    id: root
    property ListModel portamentoStartPointListModel: ListModel{}
    signal modelUpdated()
    /*

    function append(aNoteId, aX, aY)
    {
        portamentoStartPointListModel.append({
                                               "portamentoStartPointId": portamentoStartPointIdCounter,
                                               "noteId": note.noteId,
                                               "portamentoStartX": aX,
                                               "portamentoStartY": aY,
                                               "portamentoStartXOffset": 0
                                           });
        portamentoStartPointIdCounter++;
        modelUpdated();
    }

    function getModel()
    {
        return portamentoStartPointListModel;
    }

    function updateBasePoint(aPortamentoStartPointId, aPortamentoStartX, aPortamentoStartY)
    {
        var portamentoStartPoint = find(aPortamentoStartPointId);
        var noteId = portamentoEndoPoint.noteId;
        var portamentoStartX = portamentoStartPoint.portamentoStartX;
        var portamentoStartY = portamentoStartPoint.portamentoStartY;

        pitchChangingPointListModel.remove(findIndexByPortamentoStartPointId(aPortamentoStartPointId));
        pitchChangingPointListModel.append({
                                               "portamentoStartPointId": aPortamentoStartPointId,
                                               "noteId": noteId,
                                               "portamentoStartX": portamentoStartX,
                                               "portamentoStartY": portamentoStartY,
                                               "portamentoStartXOffset": portamentoEndoPoint.portamentoEndoXOffset
                                           });
        modelUpdated();
    }

    function updateOffset(aPortamentoStartPointId,aOffset)
    {
        var portamentoEndoPoint = find(aPortamentoStartPointId);

        pitchChangingPointListModel.remove(findIndexByPortamentoStartPointId(aPortamentoStartPointId));
        pitchChangingPointListModel.append({
                                               "portamentoStartPointId": aPortamentoStartPointId,
                                               "noteId": portamentoEndoPoint.noteId,
                                               "portamentoStartX": portamentoEndoPoint.portamentoStartX,
                                               "portamentoStartY": portamentoEndoPoint.portamentoStartY,
                                               "portamentoStartXOffset": aOffset
                                           });
        modelUpdated();
    }

    function find(aPortamentoStartPointId)
    {
        return portamentoStartPointListModel.get(findIndexIndexByPortamentoStartPointId(aPortamentoStartPointId));
    }

    function findPoint(aPortamentoStartPointId)
    {
        var portamentoStartPoint = find(aPortamentoStartPointId);
        return Qt.point(portamentoStartPoint.portamentoStartX, portamentoStartPoint.portamentoStartY);
    }

    function findIndexIndexByPortamentoStartPointId(aPortamentoStartPointId)
    {
        for(var index = 0; index < portamentoStartPointListModel.count; ++index)
        {
            var portamentoStartPoint = portamentoStartPointListModel.get(index);
            if (portamentoStartPoint.portamentoStartPointId !== aPortamentoStartPointId) continue;
            return index;
        }
        return 0;
    }
    */
}
