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

    function play()
    {
    }

    function undo()
    {
        main_window.loadData(MainWindowModel.readPreviousHistoryData());
    }

    function redo()
    {
        main_window.loadData(MainWindowModel.readNextHistoryData());
    }

    function openVocalLibrary()
    {
        vocalOpenDialog.open();
    }
}
