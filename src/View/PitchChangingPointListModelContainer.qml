import QtQuick 2.0

Item {
    id: root
    property ListModel pitchChangingPointListModel: ListModel{}
    signal modelUpdated()

    Connections{
        target: note_list_model_container
        onNoteRemoved:{
            removeIfChangingPointHasNoteId(aNoteId);
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
                       "pitchChangingPointId": MainWindowModel.publishPitchChangingPointId(),
                       "noteId": note.noteId,
                       "pitchChangingPointX": pitchChangingPointX,
                       "pitchChangingPointY": pitchChangingPointY
        };

        var insertIndex = insertPosition(item);
        pitchChangingPointListModel.insert(insertIndex, item);
        modelUpdated();
    }

    function lessThan(aItemA, aItemB)
    {
        console.log("conpare(" + aItemA.pitchChangingPointX + ":" + aItemB.pitchChangingPointX + ")");
        console.log("result:" + (aItemA.pitchChangingPointX < aItemB.pitchChangingPointX));
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
            console.log("insert position is " + ret );
            return ret;

        }
        console.log("insert end position");
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
}
