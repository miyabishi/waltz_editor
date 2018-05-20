import QtQuick 2.0

Item {
    id: root
    property ListModel pitchChangingPointListModel: ListModel{}
    property int pitchChangingPointIdCounter: 0
    signal modelUpdated()

    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfChangingPointHasNoteId(aNoteId);
        }
    }

    function minimumX(aNoteId)
    {
        var resultX = -1;
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            if (pitchChangingPoint.noteId !== aNoteId) continue;
            var note = note_list_model_container.find(aNoteId);
            if (resultX >= 0 && (note.positionX + pitchChangingPoint.pitchChangingPointX) > resultX) continue;
            resultX = (note.positionX + pitchChangingPoint.pitchChangingPointX);
        }

        return resultX
    }

    function maximumX(aNoteId)
    {
        var resultX = -1;
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            if (pitchChangingPoint.noteId !== aNoteId) continue;
            var note = note_list_model_container.find(aNoteId);
            if ((note.positionX + pitchChangingPoint.pitchChangingPointX) < resultX) continue;
            resultX = note.positionX + pitchChangingPoint.pitchChangingPointX;
        }
        return resultX;
    }

    function reflect()
    {
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            var note = note_list_model_container.find(pitchChangingPoint.noteId);
            MainWindowModel.appendPitchChangingPoint(
                        note.positionX + pitchChangingPoint.pitchChangingPointX,
                        note.positionY + pitchChangingPoint.pitchChangingPointY);
        }
    }

    function removeIfChangingPointHasNoteId(aNoteId)
    {
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            if (pitchChangingPoint.noteId !== aNoteId) continue;
            pitchChangingPointListModel.remove(index);
        }
    }

    function append(aX, aY)
    {
        var note = note_list_model_container.findNoteWithPitchChangingPoint(aX)
        if (note === 0) return;

        var pitchChangingPointX = aX - note.positionX;
        var pitchChangingPointY = aY - note.positionY;

        var item = {
                       "pitchChangingPointId": pitchChangingPointIdCounter,
                       "noteId": note.noteId,
                       "pitchChangingPointX": pitchChangingPointX,
                       "pitchChangingPointY": pitchChangingPointY
        };

        pitchChangingPointIdCounter++;
        var insertIndex = insertPosition(item);
        if (insertIndex > 0)
        {
            insertIndex = insertIndex + 1;
        }
        pitchChangingPointListModel.insert(insertIndex, item);
        modelUpdated();
    }

    function lessThan(aItemA, aItemB)
    {
        return aItemA.pitchChangingPointX <= aItemB.pitchChangingPointX;
    }

    function insertPosition(aInsertItem)
    {
        if (pitchChangingPointListModel.count === 0) return 0;
        for(var index = 1; index < pitchChangingPointListModel.count; ++index)
        {
            var item = pitchChangingPointListModel.get(index);
            if (lessThan(item, aInsertItem)) continue;
            var ret = index - 1;
            return ret;

        }
        return pitchChangingPointListModel.count - 1;
    }

    function createChangingPointListModelByNoteId(aNoteId)
    {
        var model = Qt.createQmlObject('import QtQuick 2.0; ListModel {}', root);
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            if (pitchChangingPoint.noteId !== aNoteId) continue;
            model.append(pitchChangingPoint);
        }
        return model;
    }

    function getModel()
    {
        return pitchChangingPointListModel;
    }

    function removePitchChangingPoint(aPitchChangingPointId)
    {
        pitchChangingPointListModel.remove(findIndexByPitchChangingPointId(aPitchChangingPointId));
    }

    function updatePitchChangingPoint(aPitchChangingPointId, aPitchChangingPointX, aPitchChangingPointY)
    {
        var pitchChangingPoint = find(aPitchChangingPointId);
        var noteId = pitchChangingPoint.noteId;
        var note = note_list_model_container.find(noteId);
        if (note === 0) return;

        var pitchChangingPointX = aPitchChangingPointX - note.positionX;
        var pitchChangingPointY = aPitchChangingPointY - note.positionY;

        var item = {
            "pitchChangingPointId": aPitchChangingPointId,
            "noteId": noteId,
            "pitchChangingPointX": pitchChangingPointX,
            "pitchChangingPointY": pitchChangingPointY
        };

        var insertIndex = insertPosition(item);
        var currentIndex = findIndexByPitchChangingPointId(aPitchChangingPointId)

        if (currentIndex !== insertIndex)
        {
            pitchChangingPointListModel.move(currentIndex, insertIndex, 1);
            pitchChangingPointListModel.set(findIndexByPitchChangingPointId(aPitchChangingPointId), item);
        }
        else
        {
            pitchChangingPointListModel.set(currentIndex, item);
        }
        modelUpdated();
    }

    function find(aPitchChangingPointId)
    {
        return pitchChangingPointListModel.get(findIndexByPitchChangingPointId(aPitchChangingPointId));
    }

    function findByIndex(aIndex)
    {
        return pitchChangingPointListModel.get(aIndex);
    }

    function findPoint(aPitchChangingPointId)
    {
        var pitchChangingPoint = find(aPitchChangingPointId);
        var note = note_list_model_container.find(pitchChangingPoint.noteId)

        return Qt.point(note.positionX + pitchChangingPoint.pitchChangingPointX,
                        note.positionY + pitchChangingPoint.pitchChangingPointY);
    }

    function findIndexByPitchChangingPointId(aPitchChangingPointId)
    {
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            if (pitchChangingPoint.pitchChangingPointId !== aPitchChangingPointId) continue;
            return index;
        }
        return;
    }

    function count()
    {
        return pitchChangingPointListModel.count
    }

    function setArray(ary)
    {
        pitchChangingPointListModel.clear();
        pitchChangingPointIdCounter = 0;

        for(var index = 0; index < ary.length; ++index)
        {
            var pitchChangingPoint = ary[index];
            pitchChangingPointListModel.append({
                     "pitchChangingPointId": pitchChangingPoint.pitchChangingPointId,
                     "noteId": pitchChangingPoint.noteId,
                     "pitchChangingPointX": pitchChangingPoint.pitchChangingPointX,
                     "pitchChangingPointY": pitchChangingPoint.pitchChangingPointY
            });
            if(pitchChangingPointIdCounter <= pitchChangingPoint.pitchChangingPointId)
            {
                pitchChangingPointIdCounter = pitchChangingPoint.pitchChangingPointId;
            }
        }
        pitchChangingPointIdCounter++
        modelUpdated();
    }

    function toArray()
    {
        var ary = new Array;
        for(var index = 0; index < pitchChangingPointListModel.count; ++index)
        {
            var pitchChangingPoint = pitchChangingPointListModel.get(index);
            ary[index] = {
                     "pitchChangingPointId": pitchChangingPoint.pitchChangingPointId,
                     "noteId": pitchChangingPoint.noteId,
                     "pitchChangingPointX": pitchChangingPoint.pitchChangingPointX,
                     "pitchChangingPointY": pitchChangingPoint.pitchChangingPointY
            };
        }
        return ary
    }

    function createClipboardData(aXOffset)
    {
        var pitchChangingPointAry = new Array;
        for (var index = 0; index < selected_note_list_model_container.count(); index++)
        {
            var noteId = selected_note_list_model_container.findNoteIdByIndex(index);
            var pitchChangingPointModel  = createChangingPointListModelByNoteId(noteId);

            for(var pitchChangingPointIndex = 0;
                pitchChangingPointIndex < pitchChangingPointModel.size;
                pitchChangingPointIndex++)
            {
                var pitchChangingPoint = pitchChangingPointModel.get[pitchChangingPointIndex];
                pitchChangingPointAry[index] = {
                    "pitchChangingPointId": pitchChangingPoint.pitchChangingPointId,
                    "noteId": pitchChangingPoint.noteId,
                    "pitchChangingPointX": pitchChangingPoint.pitchChangingPointX - aXOffset,
                    "pitchChangingPointY": pitchChangingPoint.pitchChangingPointY
                };
            }
        }
        return pitchChangingPointAry;
    }

    function pasteFromClipboard(aData, aX, aNoteIdOffset)
    {
        var ary = aData.pitchChangingPoints;
        if(!ary) return;

        for(var index = 0; index < ary.length; ++index)
        {
            root.pitchChangingPointIdCounter++;
            var pitchChangingPoint = ary[index];
            pitchChangingPointListModel.append({
                     "pitchChangingPointId": root.pitchChangingPointIdCounter,
                     "noteId": pitchChangingPoint.noteId + aNoteIdOffset,
                     "pitchChangingPointX": pitchChangingPoint.pitchChangingPointX + aX,
                     "pitchChangingPointY": pitchChangingPoint.pitchChangingPointY
            });
        }
        root.pitchChangingPointIdCounter++;
        modelUpdated();
    }

}
