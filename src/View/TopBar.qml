import QtQuick 2.0
import QtQuick.Dialogs 1.2

Rectangle{
    id: top_bar
    color: "#333333"
    height: 60

    Rectangle{
        id: file_buttons
        color:parent.color
        x: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 120
        height: 32

        Rectangle {
            id: save_button
            color:parent.color
            anchors.left: parent.left
            height: parent.height
            width: height
            Image{
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/save.png"
            }

            FileDialog{
                id:saveDialog
                nameFilters: ["Waltz Song File(*.waltzSong)"]
                selectMultiple: false
                selectExisting: false
                onAccepted: {
                    var aData = {
                        "note_list_model_container" : note_list_model_container.toArray(),
                        "note_volume_list_model_container" : note_volume_list_model_container.toArray(),
                        "portamento_start_point_list_model_container" : portamento_start_point_list_model_container.toArray(),
                        "pitch_changing_point_list_model_containter" : pitch_changing_point_list_model_containter.toArray(),
                        "portamento_end_point_list_model_container" : portamento_end_point_list_model_container.toArray(),
                        "vibrato_list_model_container" : vibrato_list_model_container.toArray()
                    }
                    MainWindowModel.save(saveDialog.fileUrl, aData);
                }
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    saveDialog.open()
                }
            }
        }
        Rectangle{
            id: wav_output_button
            color:parent.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: save_button.right
            width: 32
            height: 32
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
    }

    Rectangle{
        id: tool_buttons
        color:parent.color
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: file_buttons.right
        width: 80
        height: 32
        Image {
            id: edit_button
            anchors.left: parent.left
            height: parent.height
            width: height
            source: "qrc:/image/edit.png"
        }

        Image {
            id: cursor_button
            anchors.right: parent.right
            height: parent.height
            width: height
            source: "qrc:/image/cursor.png"
        }
    }
}
