import QtQuick 2.0

Item {
    id: root
    property ListModel portamentoEndPointListModel: ListModel{}
    property int portamentoEndPointIdCounter: 0;
    signal modelUpdated()

    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfPortamentoEndPointHasNoteId(aNoteId)
        }
    }

    function removeIfPortamentoEndPointHasNoteId(aNoteId)
    {
        for(var index = 0; index < portamentoEndPointListModel.count; ++index)
        {
            var portamentoEndPoint = portamentoEndPointListModel.get(index);
            if (portamentoEndPoint.noteId !== aNoteId) continue;
            portamentoEndPointListModel.remove(index);
            return;
        }
    }

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

    function reflect()
    {
        for(var index = 0; index < portamentoEndPointListModel.count; ++index)
        {
            var portamentoEndPoint = portamentoEndPointListModel.get(index);
            MainWindowModel.appendPitchChangingPoint(
                                    portamentoEndPoint.portamentoEndX + portamentoEndPoint.portamentoEndXOffset,
                                    portamentoEndPoint.portamentoEndY);
        }
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

    function removePortamentoEndPoint(aPortamentoEndPointId)
    {
        portamentoEndPointListModel.remove(findIndexByPortamentoEndPointId(aPortamentoEndPointId))
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

    function setArray(ary)
    {
        portamentoEndPointListModel.clear();
        portamentoEndPointIdCounter = 0;
        for(var index = 0; index < ary.length; ++index)
        {
            var portamentoEndPoint = ary[index];
            portamentoEndPointListModel.append({
                 "portamentoEndPointId": portamentoEndPoint.portamentoEndPointId,
                 "noteId": portamentoEndPoint.noteId,
                 "portamentoEndX": portamentoEndPoint.portamentoEndX,
                 "portamentoEndY": portamentoEndPoint.portamentoEndY,
                 "portamentoEndXOffset": portamentoEndPoint.portamentoEndXOffset
            });
            if (portamentoEndPointIdCounter <= portamentoEndPoint.portamentoEndPointId)
            {
                portamentoEndPointIdCounter = portamentoEndPoint.portamentoEndPointId
            }
        }
        portamentoEndPointIdCounter++;

        modelUpdated();
    }


    function toArray()
    {
        var ary = new Array;
        for(var index = 0; index < portamentoEndPointListModel.count; ++index)
        {
            var portamentoEndPoint = portamentoEndPointListModel.get(index);
            ary[index] = {
                 "portamentoEndPointId": portamentoEndPoint.portamentoEndPointId,
                 "noteId": portamentoEndPoint.noteId,
                 "portamentoEndX": portamentoEndPoint.portamentoEndX,
                 "portamentoEndY": portamentoEndPoint.portamentoEndY,
                 "portamentoEndXOffset": portamentoEndPoint.portamentoEndXOffset
            };
        }
        return ary
    }

    function createClipboardData(aXOffset)
    {
        var portamentoEndPointAry = new Array;
        for (var index = 0; index < selected_note_list_model_container.count(); index++)
        {
            var noteId = selected_note_list_model_container.findNoteIdByIndex(index);
            var portamentoEndPoint = findByNoteId(noteId);
            portamentoEndPointAry[index] = {
                 "portamentoEndPointId": portamentoEndPoint.portamentoEndPointId,
                 "noteId": portamentoEndPoint.noteId,
                 "portamentoEndX": portamentoEndPoint.portamentoEndX - aXOffset,
                 "portamentoEndY": portamentoEndPoint.portamentoEndY,
                 "portamentoEndXOffset": portamentoEndPoint.portamentoEndXOffset
            };

        }
        return portamentoEndPointAry;
    }

    function pasteFromClipboard(aData, aX, aNoteIdOffset)
    {
        var ary = aData.portamentoEndPoints;
        if (!ary) return;

        for(var index = 0; index < ary.length; ++index)
        {
            root.portamentoEndPointIdCounter++;
            var portamentoEndPoint = ary[index];
            portamentoEndPointListModel.append({
                "portamentoEndPointId": root.portamentoEndPointIdCounter,
                "noteId": portamentoEndPoint.noteId + aNoteIdOffset,
                "portamentoEndX": portamentoEndPoint.portamentoEndX + aX,
                "portamentoEndY": portamentoEndPoint.portamentoEndY,
                "portamentoEndXOffset": portamentoEndPoint.portamentoEndXOffset

            });
        }
        root.portamentoEndPointIdCounter++;
        modelUpdated();
    }
}
