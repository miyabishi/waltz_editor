import QtQuick 2.0

Item {
    id: root
    function saveAs()
    {
        saveDialog.open();
    }

    function load()
    {
        loadDialog.open();
    }

    function save()
    {
        if (main_window.editingFileName === "")
        {
            saveDialog.open()
            return;
        }
        MainWindowModel.save(main_window.editingFileName, main_window.createSaveData());
        main_window.isEdited = false;
    }

    function undo()
    {
        if (! MainWindowModel.hasPreviousHistoryData()) return;
        main_window.loadData(MainWindowModel.readPreviousHistoryData());
    }

    function redo()
    {
        if (! MainWindowModel.hasNextHistoryData()) return;
        main_window.loadData(MainWindowModel.readNextHistoryData());
    }

    function openVocalLibrary()
    {
        vocalOpenDialog.open();
    }

    function paste(aXOffset)
    {
        var data = MainWindowModel.loadFromClipboard();
        var noteIdOffset = note_list_model_container.pasteFromClipboard(data,aXOffset);
        portamento_start_point_list_model_container.pasteFromClipboard(data, aXOffset, noteIdOffset);
        pitch_changing_point_list_model_containter.pasteFromClipboard(data, aXOffset, noteIdOffset);
        portamento_end_point_list_model_container.pasteFromClipboard(data, aXOffset, noteIdOffset);
        vibrato_list_model_container.pasteFromClipboard(data, noteIdOffset);
        note_volume_list_model_container.pasteFromClipboard(data, aXOffset, noteIdOffset);
        MainWindowModel.writeHistory(main_window.createSaveData());
    }
}
