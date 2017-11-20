import QtQuick 2.0

Item {
    id: root
    property ListModel noteListModel: ListModel{}
    property int noteIdCounter: 0
    signal modelUpdated()
    signal noteRemoved(real aNoteId)

    function append(noteText, positionX, positionY, noteWidth)
    {
        noteListModel.append({
                                 "noteId": noteIdCounter,
                                 "noteText": noteText,
                                 "positionX": positionX,
                                 "positionY": positionY,
                                 "noteWidth": noteWidth
                             });

        var portamentoStartX = positionX - 30;
        var portamentoStartY = note_list_model_container.yPositionOfPreviousNote(positionX - 1,
                                                                                 positionY + edit_area.rowHeight / 2,
                                                                                 noteIdCounter);
        var portamentoEndX = positionX + 30;
        var portamentoEndY = positionY + edit_area.rowHeight / 2;

        portamento_start_point_list_model_container.append(noteIdCounter, portamentoStartX, portamentoStartY);
        portamento_end_point_list_model_container.append(noteIdCounter, portamentoEndX, portamentoEndY);

        noteIdCounter++;
        modelUpdated();
    }

    function emitModelUpdated()
    {
        modelUpdated();
    }

    function updateNote(aObject)
    {
        noteListModel.set(findIndexByNoteId(aObject.noteId), aObject);
        modelUpdated();
    }

    function getModel()
    {
        return noteListModel;
    }

    function findNoteWithPitchChangingPoint(aX)
    {
        for (var index = 0; index < noteListModel.count; ++index)
        {
            var note = noteListModel.get(index);
            var portamentoStartPoint = portamento_start_point_list_model_container.findByNoteId(note.noteId);
            var portamentoEndPoint = portamento_end_point_list_model_container.findByNoteId(note.noteId);

            if ((portamentoStartPoint.portamentoStartX + portamentoStartPoint.portamentoStartXOffset) < aX
                    && aX < (portamentoEndPoint.portamentoEndX + portamentoEndPoint.portamentoEndXOffset))
            {
                return note;
            }
        }
        return 0;
    }

    function containsNote(aNoteId)
    {
        for(var index = 0; index < noteListModel.count; ++index)
        {
            var note = noteListModel.get(index);
            if (note.noteId !== aNoteId) continue;
            return true;
        }
        return false;
    }

    function find(aNoteId)
    {
        return noteListModel.get(findIndexByNoteId(aNoteId));
    }

    function removeNote(aNoteId)
    {
        noteListModel.remove(findIndexByNoteId(aNoteId));
        noteRemoved(aNoteId);
        modelUpdated();
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

   function reflect()
   {
       MainWindowModel.clearScore();
       for(var index = 0; index < noteListModel.count; ++index)
       {
           var note = noteListModel.get(index);
           MainWindowModel.appendNote(note.noteId,
                                      note.noteText,
                                      note.positionX,
                                      note.positionY,
                                      note.noteWidth);
       }

   }
}
