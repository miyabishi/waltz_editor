import QtQuick 2.0

Item {
    id: root
    property ListModel selectedNoteListModel: ListModel{}
    property int selectedNoteIdCounter: 0

    signal modelUpdated();

    function append(aNoteId)
    {
        selectedNoteListModel.append({
                                 "selectedNoteId": selectedNoteIdCounter,
                                 "noteId": aNoteId,
                             });
        selectedNoteIdCounter++;
        modelUpdated();
    }

    function clear()
    {
        selectedNoteListModel.clear();
        selectedNoteIdCounter = 0;
        modelUpdated();
    }

    function canSwitchNoteByCursorKey()
    {
        return selectedNoteListModel.count === 1;
    }

    function removeSelectedNotes()
    {
        if (selectedNoteListModel.count == 0) return;
        for (var index = 0; index < selectedNoteListModel.count; ++index)
        {
            var selectedNote = selectedNoteListModel.get(index);
            note_list_model_container.removeNote(selectedNote.noteId);
        }
        selectedNoteListModel.clear();
        MainWindowModel.writeHistory(main_window.createSaveData());
    }

    function startEditNoteTextSelectedNote()
    {
        if (selectedNoteListModel.count !== 1) return;
        var selectedNote = selectedNoteListModel.get(0);
        note_list_model_container.notifyStartEditNoteText(selectedNote.noteId);
    }

    function connectSelectedNotesToNextNote()
    {
        if (selectedNoteListModel.count == 0) return;
        for (var index = 0; index < selectedNoteListModel.count; ++index)
        {
            var selectedNote = selectedNoteListModel.get(index);
            note_list_model_container.connectNextNote(selectedNote.noteId);
        }
        MainWindowModel.writeHistory(main_window.createSaveData());
    }

    function connectSelectedNotesToPreviousNote()
    {
        if (selectedNoteListModel.count == 0) return;
        for (var index = 0; index < selectedNoteListModel.count; ++index)
        {
            var selectedNote = selectedNoteListModel.get(index);
            note_list_model_container.connectPreviousNote(selectedNote.noteId);
        }
        MainWindowModel.writeHistory(main_window.createSaveData());
    }

    function isSelected(aNoteId)
    {
        for (var index = 0; index < selectedNoteListModel.count; ++index)
        {
            var selectedNote = selectedNoteListModel.get(index);
            if(selectedNote.noteId !== aNoteId) continue;

            return true;
        }
        return false;
    }

    function moveSelectedNotes(aDeltaX, aDeltaY)
    {
        for (var index = 0; index < selectedNoteListModel.count; ++index)
        {
            var selectedNote = selectedNoteListModel.get(index);
            note_list_model_container.moveNote(selectedNote.noteId, aDeltaX, aDeltaY);
        }
    }

    function count()
    {
        return selectedNoteListModel.count;
    }

    function findNoteIdByIndex(aIndex)
    {
        var selectedNote = selectedNoteListModel.get(aIndex);
        return selectedNote.noteId;
    }

    function copyToClipboard()
    {
        console.log("copy to clipboard");
        var topOfNote = topOfSelectedNote();

        var data = {
              "selectedNotes": note_list_model_container.createClipboardData(topOfNote.positionX),
//            "portamentoStartPoints": portamento_start_point_list_model_container.createClipboardData(noteIdAry, topOfNote.positionX),
//            "pitchChangingPoints":pitch_changing_point_list_model_containter.createClipboardData(noteIdAry, topOfNote.positionX),
//            "portamentoEndPoints": portamento_end_point_list_model_container.createClipboardData(noteIdAry, topOfNote.positionX),
//            "vibrato": vibrato_list_model_container.createClipboardData(noteIdAry),
            "volume": note_volume_list_model_container.createClipboardData(topOfNote.positionX)
        };
        MainWindowModel.saveToClipboard(data);
    }

    function topOfSelectedNote()
    {
        var minimumX = -1;
        var topOfSelectedNoteId = -1;
        for (var index = 0; index < selectedNoteListModel.count; ++index)
        {
            var selectedNote = selectedNoteListModel.get(index);
            var note = note_list_model_container.find(selectedNote.noteId);
            if (minimumX > note.positionX || minimumX < 0)
            {
                topOfSelectedNoteId = note.noteId;
                minimumX = note.positionX;
            }
        }
        return note_list_model_container.find(topOfSelectedNoteId)
    }
}
