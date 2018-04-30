import QtQuick 2.0

Item {
    id: root
    property ListModel noteListModel: ListModel{}
    property int noteIdCounter: 0
    signal modelUpdated(real aNoteId)
    signal modelUpdatedAll()
    signal noteRemoved(real aNoteId)

    function append(noteText, positionX, positionY, noteWidth)
    {
        noteListModel.append({
                                 "noteId": noteIdCounter,
                                 "noteText": noteText,
                                 "positionX": positionX,
                                 "positionY": positionY,
                                 "noteWidth": noteWidth,
                             });

        var portamentoStartX = positionX - 30;
        var portamentoStartY = note_list_model_container.yPositionOfPreviousNote(positionX - 1,
                                                                                 positionY + edit_area.rowHeight / 2,
                                                                                 noteIdCounter);
        var portamentoEndX = positionX + 30;
        var portamentoEndY = positionY + edit_area.rowHeight / 2;

        portamento_start_point_list_model_container.append(noteIdCounter, portamentoStartX, portamentoStartY);
        portamento_end_point_list_model_container.append(noteIdCounter, portamentoEndX, portamentoEndY);
        note_volume_list_model_container.append(noteIdCounter, 100);

        modelUpdated(noteIdCounter);
        noteIdCounter++;
    }

    function emitModelUpdated()
    {
        modelUpdated(-1);
    }

    function updateNote(aObject)
    {
        noteListModel.set(findIndexByNoteId(aObject.noteId), aObject);
        modelUpdated(aObject.noteId);
    }

    function getModel()
    {
        return noteListModel;
    }

    function getWidth(aNoteId)
    {
        var note = find(aNoteId);
        return note.noteWidth;
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
        modelUpdated(aNoteId);
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

   function findPreviousNoteIndex(aCurrentNoteId, aCurrentPositionX)
   {
       if (noteListModel.count === 0) return -1;
       if (noteListModel.count === 1) return 0;

       var minimumDistance = -1;
       var previousNoteIndex = findIndexByNoteId(aCurrentNoteId);

       for (var index = 0; index < noteListModel.count; ++index)
       {
           var otherNote = noteListModel.get(index);
           if (aCurrentNoteId === otherNote.noteId) continue;
           if (aCurrentPositionX <= otherNote.positionX) continue;

           var distance = aCurrentPositionX - otherNote.positionX

           if (minimumDistance < 0)
           {
               minimumDistance = distance;
           }

           if (distance <= minimumDistance)
           {
               previousNoteIndex = index;
               minimumDistance = distance;
           }
       }

       return previousNoteIndex;
   }

   function reflect()
   {
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

   function setArray(ary)
   {
       noteListModel.clear();
       root.noteIdCounter = 0;

       for(var index = 0; index < ary.length; ++index)
       {
           var note = ary[index];
           noteListModel.append({
                                    "noteId": note.noteId,
                                    "noteText": note.noteText,
                                    "positionX": note.positionX,
                                    "positionY": note.positionY,
                                    "noteWidth": note.noteWidth
                                });

           if(root.noteIdCounter <= note.noteId)
           {
               root.noteIdCounter = note.noteId
           }
       }
       root.noteIdCounter++;
       modelUpdatedAll();

   }

   function moveNote(aNoteId, aDeltaX, aDeltaY)
   {
       console.log("move note!! noteid:", aNoteId, "delta(", aDeltaX, ",", aDeltaY, ")")
       var note = find(aNoteId);
       updateNote({
                      "noteId": note.noteId,
                      "noteText": note.noteText,
                      "positionX": note.positionX + aDeltaX,
                      "positionY": note.positionY + aDeltaY,
                      "noteWidth": note.noteWidth
                  });
   }

   function toArray()
   {
       var ary = new Array;
       for(var index = 0; index < noteListModel.count; ++index)
       {           
           var note = noteListModel.get(index);
           ary[index] = {
               "noteId": note.noteId,
               "noteText": note.noteText,
               "positionX": note.positionX,
               "positionY": note.positionY,
               "noteWidth": note.noteWidth};
       }
       return ary
   }

   // TODO:　リファクタ対象　長すぎる関数
   function selectBySquare(aX1, aY1, aX2, aY2)
   {
       var topX = 0;
       var topY = 0;
       var bottomX = 0;
       var bottomY = 0;

       if (aX1 < aX2)
       {
           topX = aX1
           bottomX = aX2
       }
       else
       {
           topX = aX2
           bottomX = aX1
       }

       if (aY1 < aY2)
       {
           topY = aY1;
           bottomY = aY2;
       }
       else
       {
           topY = aY2;
           bottomY = aY1;
       }

       for(var index = 0; index < noteListModel.count; ++index)
       {
           var note = noteListModel.get(index);
           // TODO: リファクタ酷い条件式　内容はnoteがsquare内にあるかどうかの判定
           if (((topX < note.positionX && note.positionX < bottomX)
                   || (topX < (note.positionX + note.noteWidth)
                       && (note.positionX + note.noteWidth) < bottomX))
               && ((topY < note.positionY && note.positionY < bottomY)
                   || (topY < (note.positionY + edit_area.rowHeight)
                           && (note.positionY + edit_area.rowHeight) < bottomY)))
           {
               selected_note_list_model_container.append(note.noteId);
               continue;
           }
       }
   }

}
