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
        Image {
            id: save_button
            anchors.left: parent.left
            height: parent.height
            width: height
            source: "qrc:/image/save.png"
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
