import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle{
    id: top_bar
    color: "#333333"
    height: 60

    Connections{
        target: MainWindowModel
        onHistoryDataUpdated: {
            undo_button.isEnabled = MainWindowModel.hasPreviousHistoryData();
            redo_button.isEnabled = MainWindowModel.hasNextHistoryData();
        }
    }

    RowLayout{
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 200
        spacing: 6

        Rectangle {
            id: undo_button
            color:"#333333"
            property bool isEnabled: false

//            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40

            onIsEnabledChanged: {
                undo_button_image_brightness.brightness = undo_button.isEnabled ? 0 : -0.50
            }

            Image{
                id: undo_button_image
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/undo.png"
            }

            BrightnessContrast{
                id: undo_button_image_brightness
                source: undo_button_image
                anchors.fill: undo_button_image
                brightness: -0.50
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    if(! undo_button.isEnabled) return;
                    command_container.undo();
                }
            }
        }

        Rectangle {
            id: redo_button
            color:"#333333"
            property bool isEnabled: false

            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40

            onIsEnabledChanged: {
                redo_button_image_brightness.brightness = isEnabled ? 0 : -0.50
            }

            Image{
                id: redo_button_image
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/redo.png"
            }

            BrightnessContrast{
                id: redo_button_image_brightness
                source: redo_button_image
                anchors.fill: redo_button_image
                brightness: -0.50
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    if(! redo_button.isEnabled) return;
                    command_container.redo();
                }
            }
        }

        Rectangle {
            id: save_button
            color:"#333333"

            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40

            Image{
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/save.png"
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    command_container.save()
                }
            }
        }

        Rectangle{
            id: wav_output_button
            color:"#333333"

            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40

            Image {
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/sound_wave.png"
            }
            FileDialog{
                id:saveWavDialog
                nameFilters: ["Wav File(*.wav)"]
                selectMultiple: false
                selectExisting: false
                onAccepted: {
                    MainWindowModel.saveWav(saveWavDialog.fileUrl)
                }
            }
            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    saveWavDialog.open()
                }
            }
        }

        Rectangle{ //empty
            color:"#333333"
            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 10
            Layout.preferredWidth: 10
            Layout.maximumWidth: 10
            Layout.minimumHeight: 30

            Rectangle{
                color:"#bbbbbb"
                width:2
                height:parent.height
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: connect_next_note
            color:"#333333"

//            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40

            Image {
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/connect_next_note.png"
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    selected_note_list_model_container.connectSelectedNotesToNextNote();
                }
            }
        }
        Rectangle{
            id: connect_previous_note
            color:"#333333"

            anchors.verticalCenter: parent.verticalCenter

            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40


            Image {
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/connect_previous_note.png"
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    selected_note_list_model_container.connectSelectedNotesToPreviousNote();
                }
            }
        }
    }
}
