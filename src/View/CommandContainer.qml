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
        console.log("paste");
        var data = MainWindowModel.loadFromClipboard();
        var noteIdMap = note_list_model_container.pasteFromClipboard(data,aXOffset);
        note_volume_list_model_container.pasteFromClipboard(data, aXOffset);
    }
}
