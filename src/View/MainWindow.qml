import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

ApplicationWindow {
    id:main_window
    visible: true
    width: 1280
    height: 940
    title: qsTr("Waltz Editor")
    menuBar: MainWindowMenu{}

    signal songLoaded();
    property string editingFileName: ""
    property string voiceLibraryPath: ""
    property bool isEdited: false;
    property bool isClosing: false;

    onEditingFileNameChanged: {
        main_window.title = createTitleText();
    }

    onClosing: {
        isClosing = true;
        close.accepted = false;

        if (! main_window.isEdited)
        {
            MainWindowModel.exit();
            return;
        }

        save_confirmation_dialg.openSaveConfirmationDialog();

        return;
    }

    Connections{
        target: save_confirmation_dialg
        onAccepted:{
            command_container.save();
        }
        onDiscard: {
            MainWindowModel.exit();
        }
        onRejected:{
            isClosing = false;
        }
    }
    Connections{
        target: saveDialog
        onAccepted:{
            if (! isClosing) return;
            MainWindowModel.exit();
        }
        onRejected:{
            isClosing = false;
        }
    }

    onIsEditedChanged: {
        main_window.title = createTitleText();
    }

    function createTitleText()
    {

        var titleText = editingFileName + " - Waltz Editor";
        if (isEdited)
        {
            titleText = "*" + titleText;
        }
        return titleText;
    }

    Component.onCompleted: {
        loading_window.visible = true
    }

    function loadData(aData)
    {
        note_list_model_container.setArray(aData.note_list_model_container);
        note_volume_list_model_container.setArray(aData.note_volume_list_model_container);
        portamento_start_point_list_model_container.setArray(aData.portamento_start_point_list_model_container);
        pitch_changing_point_list_model_containter.setArray(aData.pitch_changing_point_list_model_containter);
        portamento_end_point_list_model_container.setArray(aData.portamento_end_point_list_model_container);
        vibrato_list_model_container.setArray(aData.vibrato_list_model_container);
        MainWindowModel.setTempo(aData.tempo);
        MainWindowModel.setBeatChild(aData.beat_child);
        MainWindowModel.setBeatParent(aData.beat_parent);
        songLoaded();
    }

    function createSaveData()
    {
        var aData = {
            "note_list_model_container" : note_list_model_container.toArray(),
            "note_volume_list_model_container" : note_volume_list_model_container.toArray(),
            "portamento_start_point_list_model_container" : portamento_start_point_list_model_container.toArray(),
            "pitch_changing_point_list_model_containter" : pitch_changing_point_list_model_containter.toArray(),
            "portamento_end_point_list_model_container" : portamento_end_point_list_model_container.toArray(),
            "vibrato_list_model_container" : vibrato_list_model_container.toArray(),
            "tempo": MainWindowModel.tempo(),
            "beat_parent": MainWindowModel.beatParent(),
            "beat_child": MainWindowModel.beatChild(),
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

    CommandContainer{
        id: command_container
    }

    SelectedNoteListModelContainer{
        id: selected_note_list_model_container
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
//            anchors.left: parent.left
            anchors.top:parent.top
            anchors.bottom: parent.bottom
        }

        ColumnLayout{
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: library_information.right
            anchors.right: parent.right

            SplitView{
//                anchors.top: parent.top
//                anchors.bottom: main_scroll_view.top
                anchors.left: parent.left //library_information.right

                anchors.right: parent.right
                orientation: Qt.Vertical

                EditArea{
                    id: edit_area
                    height:300
                    Layout.fillHeight: true
                    anchors.left: parent.left
                    anchors.right: parent.right

                    onVisibleChanged: {
                        Layout.fillHeight = visible;
                        if (visible === true)
                        {
                            edit_area.height = 300;
                            parameters_edit_area.height = 200;
                            if (portamento_edit_area.isFillHeight())
                            {
                                portamento_edit_area.changeFillHeight(false);
                                portamento_edit_area.height = 300;
                            }
                        }
                    }
                    onXOffsetChanged: {
                        if (portamento_edit_area.xOffset === xOffset && main_scroll_view.xOffset === xOffset)
                        {
                            return;
                        }
                        portamento_edit_area.xOffset = xOffset;
                        main_scroll_view.xOffset = xOffset
                    }
                }

                PortamentoEditArea{
                    id: portamento_edit_area
                    xOffset: edit_area.xOffset
                    visible:false
                    height:300

                    function changeFillHeight(aIsFillHeight)
                    {
                        Layout.fillHeight = aIsFillHeight;
                    }
                    function isFillHeight()
                    {
                        return Layout.fillHeight;
                    }

                    onXOffsetChanged: {
                        if (edit_area.xOffset === xOffset)
                        {
                            return;
                        }
                        edit_area.xOffset = xOffset;
                    }

                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                ParametersEditArea{
                    id: parameters_edit_area
                    height: 200
                    visible:false
                    anchors.left: parent.left
                    anchors.right: parent.right

                    onVisibleChanged: {
                        if (parameters_edit_area.visible === false)
                        {
                            portamento_edit_area.changeFillHeight(true);
                            return;
                        }
                        portamento_edit_area.changeFillHeight(false);
                    }
                }
            }

            ScrollView{
                  id: main_scroll_view
                  anchors.right: parent.right
                  anchors.left:parent.left
//                  anchors.bottom: parent.bottom
                  flickableItem.interactive: false
                  style: WaltzScrollViewStyle{}

                  horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn
                  verticalScrollBarPolicy:  Qt.ScrollBarAlwaysOff

                  width: 15
                  Layout.minimumHeight: 15
                  Layout.maximumHeight: 15

                  property int xOffset: edit_area.xOffset

                  onXOffsetChanged: {
                      if (edit_area.xOffset === xOffset && flickableItem.contentX === xOffset)
                      {
                          return;
                      }
                      edit_area.xOffset = xOffset;
                      flickableItem.contentX = xOffset
                  }

                  flickableItem.onContentXChanged: {
                      xOffset = flickableItem.contentX;
                  }

                  Rectangle{
                      id: main_scroll_view_in
                      color: "#000000"
                      anchors.top: parent.top
                      anchors.bottom: parent.bottom
                      height:100
                      width: edit_area.editAreaWidth
                  }
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
            main_window.editingFileName = loadDialog.fileUrl;
            main_window.isEdited = false;
        }
    }

    FileDialog{
        id:saveDialog
        nameFilters: ["Waltz Song File(*.waltzSong)"]
        selectMultiple: false
        selectExisting: false
        onAccepted: {
            MainWindowModel.save(saveDialog.fileUrl, main_window.createSaveData());
            main_window.editingFileName = saveDialog.fileUrl;
            main_window.isEdited = false;
        }
    }

    FileDialog{
        id:vocalOpenDialog
        nameFilters: ["Vocal File(*." + MainWindowModel.vocalFileExtention() + ")"]
        selectMultiple: false
        onAccepted: {
            MainWindowModel.loadVoiceLibrary(vocalOpenDialog.fileUrl);
            main_window.voiceLibraryPath = vocalOpenDialog.fileUrl;
        }
    }

    SaveConfermationDialog{
        id: save_confirmation_dialg
    }

    PouringLyricsDialog{
        id: pouring_lyrics_dialog
    }

    Connections{
        target: MainWindowModel
        onErrorOccurred: {
            errorDialog.error_message = aErrorMessage
            errorDialog.open()
        }
        onHistoryDataUpdated:{
            if (! MainWindowModel.hasPreviousHistoryData()) return;
            main_window.isEdited = true;
        }
        onIsReady:{
            loading_window.close()
        }
    }

    Window{
        id: loading_window
        flags: Qt.SplashScreen
        modality: Qt.WindowModal
        Component.onCompleted: {
            load_timeout_timer.start();
        }
        Text{
            text:qsTr("loading...")
        }
    }

    Timer{
        id: load_timeout_timer
        interval:  30000
        repeat: false
        onTriggered: {
            loading_window.close();
        }
    }
}
