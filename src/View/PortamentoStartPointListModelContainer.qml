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

    function setArray(ary)
    {
        portamentoStartPointListModel.clear();
        portamentoStartPointIdCounter = 0;

        for(var index = 0; index < ary.length; ++index)
        {
            var portamentoStartPoint = ary[index];
            portamentoStartPointListModel.append({
                "portamentoStartPointId": portamentoStartPoint.portamentoStartPointId,
                "noteId": portamentoStartPoint.noteId,
                "portamentoStartX": portamentoStartPoint.portamentoStartX,
                "portamentoStartY": portamentoStartPoint.portamentoStartY,
                "portamentoStartXOffset": portamentoStartPoint.portamentoStartXOffset
            });

            if (portamentoStartPointIdCounter <= portamentoStartPoint.portamentoStartPointId)
            {
                portamentoStartPointIdCounter =  portamentoStartPoint.portamentoStartPointId;
            }
        }

        portamentoStartPointIdCounter++;
        modelUpdated();
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

    function createClipboardData(aNoteIdArray, aXOffset)
    {
        var portamentoStartPointAry = new Array;
        for (var index = 0; index < aNoteIdArray.size; index++)
        {
            var noteId = aNoteIdArray[index]
            var portamentoStartPoint = findByNoteId(noteId);
            portamentoStartPointAry[index] = {
                "portamentoStartPointId": portamentoStartPointIdCounter,
                "noteId": portamentoStartPoint.noteId,
                "portamentoStartX": portamentoStartPoint.portamentoStartX + aXOffset,
                "portamentoStartY": portamentoStartPoint.portamentoStartY,
                "portamentoStartXOffset": portamentoStartPoint.portamentoStartXOffset
            };
            portamentoStartPointIdCounter++;
        }
        return portamentoStartPointAry;
    }
}
