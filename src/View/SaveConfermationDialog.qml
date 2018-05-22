import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

Dialog{
    id:root
    standardButtons: StandardButton.Save | StandardButton.Discard | StandardButton.Cancel
    width: 250
    height: 80

    title: ""
    property string filePath: ""

    function openSaveConfirmationDialog()
    {
        if(main_window.editingFileName != "")
        {
            dialog_message.text = "Do you want to changes to \""+ filePath + "\"?";
        }
        open();
    }

    Text{
        id: dialog_message
        color: "#000000"
        text: "Do you want to changes?";
    }
}
