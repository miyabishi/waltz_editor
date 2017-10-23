import QtQuick 2.0

Item {
    id: root
    property ListModel noteListModel: ListModel{}

    signal modelUpdated()

    function append(aObject)
    {
        console.log("append");
        console.log("id:" + aObject.noteId);
        noteListModel.append(aObject)
        modelUpdated();
    }

    function updateNote(aObject)
    {
        noteListModel.remove(findIndexByNoteId(aObject.noteId));
        noteListModel.append(aObject);
        modelUpdated();
    }

    function updatePortamentoStartPoint(aNoteId, aX, aY)
    {
        var note = find(aNoteId);
        note.portamentoStartX = aX;
        note.portamentoStartY = aY;
        updateNote(aNoteId, note);
    }

    function getModel()
    {
        return noteListModel;
    }

    function find(aNoteId)
    {
        return noteListModel.get(findIndexByNoteId(aNoteId));
    }

    function findByIndex(aIndex)
    {
        return noteListModel.get(aIndex);
    }

   function findIndexByNoteId(aNoteId)
   {
       for(var index = 0; index < noteListModel.count; ++index)
       {
           var note = noteListModel.get(index);
           if (note.noteId !== aNoteId) continue;
           return index;
       }
       return;
   }

   function count()
   {
       return noteListModel.count;
   }

   function yPositionOfPreviousNote(aXPosition, aYPosition, aNoteId)
   {
       return 0;
   }
}
