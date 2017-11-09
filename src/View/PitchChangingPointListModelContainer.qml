import QtQuick 2.0

Item {
    id: root
    property ListModel pitchChangingPointListModel: ListModel{}
    signal modelUpdated()

    function append(aX, aY)
    {
        // TODO
        var noteId = 1;
        var note = note_list_model_container.find(noteId);
        var id = 0;
        var pitchChangingPointX = note.positionX - aX;
        var pitchChangingPointY = note.positionY - aY;


        pitchChangingPointListModel.append({
                                               "id": id,
                                               "noteId": noteId,
                                               "pitchChangingPointX": pitchChangingPointX,
                                               "pitchChangingPointY": pitchChangingPointY
                                           });
        modelUpdated();
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
