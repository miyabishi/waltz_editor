import QtQuick 2.0

Item {
    id: root
    property ListModel noteListModel: ListModel{}
    signal modelUpdated()

    function append(aObject)
    {
        noteListModel.append(aObject)
        modelUpdated();
    }

    function emitModelUpdated()
    {
        modelUpdated();
    }

    function updateNote(aObject)
    {
        noteListModel.remove(findIndexByNoteId(aObject.noteId));
        noteListModel.append(aObject);
        modelUpdated();
    }

    function getModel()
    {
        return noteListModel;
    }

    function findNoteWithPitchChangingPoint(aX)
    {
        for (var index; index < noteListModel.count; ++index)
        {
            var note = noteListModel.get(index);
            if (note.portamentoStartX < aX && aX < note.portamentoEndX)
            {
                return note;
            }
        }
        return 0;
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

   function yPositionOfPreviousNote(aPositionX, aPositionY, aNoteId)
   {
       var previousNoteIndex = findPreviousNoteIndex(aNoteId, aPositionX);
       if (previousNoteIndex < 0) return aPositionY;

       var previousNote = noteListModel.get(previousNoteIndex);
       return previousNote.positionY + edit_area.rowHeight / 2;
   }

   function findPreviousNoteIndex(aCurrentNoteId, aPositionX)
   {
       if (noteListModel.count === 0) return -1;
       if (noteListModel.count === 1) return 0;

       var minimumDistance = -1;
       var previousNoteIndex = -1;

       for (var index = 0; index < noteListModel.count; ++index)
       {
           var otherNote = noteListModel.get(index);
           if (aCurrentNoteId === otherNote.noteId) continue;

           var distance = aPositionX - otherNote.positionX
           if (distance < 0) continue;
           if (minimumDistance < 0 || distance < minimumDistance)
           {
               minimumDistance = distance;
               previousNoteIndex = index;
           }
       }

       return previousNoteIndex;
   }
}
