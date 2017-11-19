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

        pitchChangingPointListModel.append({
                                               "pitchChangingPointId": MainWindowModel.publishPitchChangingPointId(),
                                               "noteId": note.noteId,
                                               "pitchChangingPointX": pitchChangingPointX,
                                               "pitchChangingPointY": pitchChangingPointY
                                           });
        modelUpdated();
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


        pitchChangingPointListModel.set(findIndexByPitchChangingPointId(aPitchChangingPointId),
                                        {
                                               "pitchChangingPointId": aPitchChangingPointId,
                                               "noteId": noteId,
                                               "pitchChangingPointX": pitchChangingPointX,
                                               "pitchChangingPointY": pitchChangingPointY
                                        });
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
