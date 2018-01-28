import QtQuick 2.0

Item {
    id: root
    property ListModel portamentoStartPointListModel: ListModel{}
    property int portamentoStartPointIdCounter: 0
    signal modelUpdated()
    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfPortamentoStartPointHasNoteId(aNoteId)
        }
    }

    function removeIfPortamentoStartPointHasNoteId(aNoteId)
    {
        for(var index = 0; index < portamentoStartPointListModel.count; ++index)
        {
            var portamentoStartPoint = portamentoStartPointListModel.get(index);
            if (portamentoStartPoint.noteId !== aNoteId) continue;
            portamentoStartPointListModel.remove(index);
            return;
        }
    }

    function reflect()
    {
        for(var index = 0; index < portamentoStartPointListModel.count; ++index)
        {
            var portamentoStartPoint = portamentoStartPointListModel.get(index);
            MainWindowModel.appendPitchChangingPoint(
                                    portamentoStartPoint.portamentoStartX + portamentoStartPoint.portamentoStartXOffset,
                                    portamentoStartPoint.portamentoStartY);
        }
    }

    function append(aNoteId, aX, aY)
    {
        portamentoStartPointListModel.append({
                                               "portamentoStartPointId": portamentoStartPointIdCounter,
                                               "noteId": aNoteId,
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
        var noteId = portamentoStartPoint.noteId;

        portamentoStartPointListModel.set(findIndexByPortamentoStartPointId(aPortamentoStartPointId),
                                        {
                                            "portamentoStartPointId": aPortamentoStartPointId,
                                            "noteId": noteId,
                                            "portamentoStartX": aPortamentoStartX,
                                            "portamentoStartY": aPortamentoStartY,
                                            "portamentoStartXOffset": portamentoStartPoint.portamentoStartXOffset
                                        });
        modelUpdated();
    }

    function updateOffset(aPortamentoStartPointId, aOffset)
    {
        var portamentoStartPoint = find(aPortamentoStartPointId);

        portamentoStartPointListModel.set(findIndexByPortamentoStartPointId(aPortamentoStartPointId),
                                        {
                                            "portamentoStartPointId": aPortamentoStartPointId,
                                            "noteId": portamentoStartPoint.noteId,
                                            "portamentoStartX": portamentoStartPoint.portamentoStartX,
                                            "portamentoStartY": portamentoStartPoint.portamentoStartY,
                                            "portamentoStartXOffset": aOffset
                                        });
        modelUpdated();
    }

    function removePortamentoStartPoint(aPortamentoStartPointId)
    {
        portamentoStartPointListModel.remove(findIndexByPortamentoStartPointId(aPortamentoStartPointId));
    }

    function find(aPortamentoStartPointId)
    {
        return portamentoStartPointListModel.get(findIndexByPortamentoStartPointId(aPortamentoStartPointId));
    }

    function findByNoteId(aNoteId)
    {
        for(var index = 0; index < portamentoStartPointListModel.count; ++index)
        {
            var portamentoStartPoint = portamentoStartPointListModel.get(index);
            if (portamentoStartPoint.noteId !== aNoteId) continue;
            return portamentoStartPoint;
        }
        return;
    }

    function findPoint(aPortamentoStartPointId)
    {
        var portamentoStartPoint = find(aPortamentoStartPointId);
        return Qt.point(portamentoStartPoint.portamentoStartX, portamentoStartPoint.portamentoStartY);
    }

    function findIndexByPortamentoStartPointId(aPortamentoStartPointId)
    {
        for(var index = 0; index < portamentoStartPointListModel.count; ++index)
        {
            var portamentoStartPoint = portamentoStartPointListModel.get(index);
            if (portamentoStartPoint.portamentoStartPointId !== aPortamentoStartPointId) continue;
            return index;
        }
        return 0;
    }

    function toArray()
    {
        var ary = new Array;
        for(var index = 0; index < portamentoStartPointListModel.count; ++index)
        {
            var portamentoStartPoint = portamentoStartPointListModel.get(index);
            ary[index] = {
                "portamentoStartPointId": portamentoStartPoint.portamentoStartPointId,
                "noteId": portamentoStartPoint.noteId,
                "portamentoStartX": portamentoStartPoint.portamentoStartX,
                "portamentoStartY": portamentoStartPoint.portamentoStartY,
                "portamentoStartXOffset": portamentoStartPoint.portamentoStartXOffset
            };
        }
        return ary
    }

}
