import QtQuick 2.0

Item {
    id: root
    function saveAs()
    {
        saveDialog.open()
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

}
