import QtQuick 2.0

Item {
    id: root
    property ListModel pitchChangingPointListModel: ListModel{}
    signal modelUpdated()

    function append(aX, aY)
    {
        // TODO
        var note = note_list_model_container.findNoteWithPitchChangingPoint(aX)
        if (note === 0) return;

        var id = MainWindowModel.publishPitchChangingPointId();
        var pitchChangingPointX = note.positionX - aX;
        var pitchChangingPointY = note.positionY - aY;

        console.log("id" + id);
        console.log("pitchChangingPointX:" + pitchChangingPointX);
        console.log("pitchChangingPointY:" + pitchChangingPointY);

        pitchChangingPointListModel.append({
                                               "id": id,
                                               "noteId": note.noteId,
                                               "pitchChangingPointX": pitchChangingPointX,
                                               "pitchChangingPointY": pitchChangingPointY
                                           });
        modelUpdated();
    }

    function getModel()
    {
        return pitchChangingPointListModel;
    }

    function update(aObject)
    {
        pitchChangingPointListModel.remove(findIndexByPitchChangingPointId(aObject.pitchChangingPointId));
        pitchChangingPointListModel.append(aObject);
        modelUpdated();
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
}
