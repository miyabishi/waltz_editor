import QtQuick 2.0

Item {
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
}
