import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2


ApplicationWindow {
    id:main_window
    visible: true
    width: 1280
    height: 940
    title: qsTr("Waltz Editor")
    menuBar: MainWindowMenu{}

    Component.onCompleted: {
        MainWindowModel.writeHistory(main_window.createSaveData());
    }

    function loadData(aData)
    {
        note_list_model_container.setArray(aData.note_list_model_container);
        note_volume_list_model_container.setArray(aData.note_volume_list_model_container);
        portamento_start_point_list_model_container.setArray(aData.portamento_start_point_list_model_container);
        pitch_changing_point_list_model_containter.setArray(aData.pitch_changing_point_list_model_containter);
        portamento_end_point_list_model_container.setArray(aData.portamento_end_point_list_model_container);
        vibrato_list_model_container.setArray(aData.vibrato_list_model_container);
    }

    function createSaveData()
    {
        var aData = {
            "note_list_model_container" : note_list_model_container.toArray(),
            "note_volume_list_model_container" : note_volume_list_model_container.toArray(),
            "portamento_start_point_list_model_container" : portamento_start_point_list_model_container.toArray(),
            "pitch_changing_point_list_model_containter" : pitch_changing_point_list_model_containter.toArray(),
            "portamento_end_point_list_model_container" : portamento_end_point_list_model_container.toArray(),
            "vibrato_list_model_container" : vibrato_list_model_container.toArray()
        };
        return aData;
    }

    function reflectData()
    {
        note_list_model_container.reflect();
        pitch_changing_point_list_model_containter.reflect();
        portamento_start_point_list_model_container.reflect();
        portamento_end_point_list_model_container.reflect();
        vibrato_list_model_container.reflect();
        note_volume_list_model_container.reflect();
    }

    NoteListModelContainer{
        id: note_list_model_container
    }

    NoteVolumeListModelContainer{
        id: note_volume_list_model_container
    }

    PortamentoStartPointListModelContainer{
        id: portamento_start_point_list_model_container
    }

    PitchChangingPointListModelContainer{
        id: pitch_changing_point_list_model_containter
    }

    PortamentoEndPointListModelContainer{
        id: portamento_end_point_list_model_container
    }

    VibratoListModelContainer{
        id: vibrato_list_model_container
    }

    TopBar{
        id: top_bar
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        z: 10
    }

    RowLayout{
        id: main_split_view
        anchors.top: top_bar.bottom
        anchors.left: parent.left
        anchors.right:parent.right
        anchors.bottom:bottom_bar.top

        LibraryInformation{
            id: library_information
            color:"#222222"
            anchors.left: parent.left
            anchors.top:parent.top
            anchors.bottom: parent.bottom
        }

        SplitView{
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: library_information.right
            anchors.right: parent.right
            orientation: Qt.Vertical

            EditArea{
                id: edit_area
                height: 300
                anchors.left: parent.left
                anchors.right: parent.right
                onXOffsetChanged: {
                    if (portamento_edit_area.xOffset === xOffset)
                    {
                        return;
                    }
                    portamento_edit_area.xOffset = xOffset;
                }
            }

            PortamentoEditArea{
                id: portamento_edit_area
                height: 300
                xOffset: edit_area.xOffset
                onXOffsetChanged: {
                    if (edit_area.xOffset === xOffset)
                    {
                        return;
                    }
                    edit_area.xOffset = xOffset;
                }

                anchors.top: edit_area.bottom
                anchors.left: parent.left
                anchors.right: parent.right
            }

            ParametersEditArea{
                id: parameters_edit_area
                anchors.top: portamento_edit_area.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }
    }

    BottomBar{
        id: bottom_bar
        height:71
        width: parent.width
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Dialog {
        id: errorDialog
        visible: false
        title: "Error"
        property string error_message: ""
        modality: Qt.WindowModal
        standardButtons: StandardButton.Ok
    }

    FileDialog{
        id:loadDialog
        nameFilters: ["Waltz Song File(*.waltzSong)"]
        selectMultiple: false
        selectExisting: true
        onAccepted: {
            var data = MainWindowModel.load(loadDialog.fileUrl);
            main_window.loadData(data);
            /*
            note_list_model_container.setArray(data.note_list_model_container);
            note_volume_list_model_container.setArray(data.note_volume_list_model_container);
            portamento_start_point_list_model_container.setArray(data.portamento_start_point_list_model_container);
            pitch_changing_point_list_model_containter.setArray(data.pitch_changing_point_list_model_containter);
            portamento_end_point_list_model_container.setArray(data.portamento_end_point_list_model_container);
            vibrato_list_model_container.setArray(data.vibrato_list_model_container);
            */
        }
    }

    FileDialog{
        id:saveDialog
        nameFilters: ["Waltz Song File(*.waltzSong)"]
        selectMultiple: false
        selectExisting: false
        onAccepted: {
            /*
            var aData = {
                "note_list_model_container" : note_list_model_container.toArray(),
                "note_volume_list_model_container" : note_volume_list_model_container.toArray(),
                "portamento_start_point_list_model_container" : portamento_start_point_list_model_container.toArray(),
                "pitch_changing_point_list_model_containter" : pitch_changing_point_list_model_containter.toArray(),
                "portamento_end_point_list_model_container" : portamento_end_point_list_model_container.toArray(),
                "vibrato_list_model_container" : vibrato_list_model_container.toArray()
            }*/
            MainWindowModel.save(saveDialog.fileUrl, main_window.createSaveData());
        }
    }

    Connections{
        target: MainWindowModel
        onErrorOccurred: {
            errorDialog.error_message = aErrorMessage
            errorDialog.open()
        }
    }
}
