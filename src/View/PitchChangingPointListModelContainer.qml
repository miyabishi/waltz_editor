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

        var pitchChangingPointX = aX - note.positionX;
        var pitchChangingPointY = aY - note.positionY;

        console.log("pitchChangingPointId:" + MainWindowModel.publishPitchChangingPointId());
        console.log("noteId:" + note.noteId);
        console.log("pitchChangingPointX:" + pitchChangingPointX);
        console.log("pitchChangingPointY:" + pitchChangingPointY);

        pitchChangingPointListModel.append({
                                               "pitchChangingPointId": MainWindowModel.publishPitchChangingPointId(),
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

    function update(aPitchChangingPointId, aPitchChangingPointX, aPitchChangingPointY)
    {
        var pitchChangingPoint = find(aPitchChangingPointId);
        var noteId = pitchChangingPoint.noteId;
        var note = note_list_model_container.find(noteId);
        if (note === 0) return;

        var pitchChangingPointX = note.positionX - aPitchChangingPointX;
        var pitchChangingPointY = note.positionY - aPitchChangingPointY;


        pitchChangingPointListModel.remove(findIndexByPitchChangingPointId(pitchChangingPointId));
        pitchChangingPointListModel.append({
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

    function findPoint(aPitchChangingPointId)
    {
        var pitchChangingPoint = find(aPitchChangingPointId);
        return Qt.point(pitchChangingPoint.pitchChangingPointX, pitchChangingPoint.pitchChangingPointY);
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
