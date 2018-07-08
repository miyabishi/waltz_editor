import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

import QtQuick.Controls 1.4
import QtQuick.Controls 2.0 as Controls
import QtGraphicalEffects 1.0

Rectangle{
    id: root
    color: "#333333"
    Connections{
        target: main_window
        onSongLoaded:{
            tempo_controller.reload();
            beat_controller.reload();
        }
    }

    Rectangle {
        id: player_controller
        color: "#333333"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 180
        height: parent.height * 0.7

        RowLayout{
            anchors.fill: parent
            spacing: 6

            Rectangle{
                id: skip_previous_button

                Layout.fillWidth: true
                Layout.minimumWidth: 40
                Layout.preferredWidth: 40
                Layout.maximumWidth: 40
                Layout.minimumHeight: 40

                color: "#333333"
                Image {
                    height: parent.height
                    width: height
                    source: "qrc:/image/skip_previous.png"
                }
                WButtonMouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (! play_button.pIsActive_) return;

                        edit_area.skipToPreviousBar();

                        MainWindowModel.clearScore();
                        main_window.reflectData()
                        MainWindowModel.play(edit_area.getSeekBarPosition());
                    }
                }
            }

            Rectangle{
                id: stop_button
                Layout.fillWidth: true
                Layout.minimumWidth: 40
                Layout.preferredWidth: 40
                Layout.maximumWidth: 40
                Layout.minimumHeight: 40

                color: "#333333"
                Image {
                    anchors.left: parent.left
                    height: parent.height
                    width: height
                    source: "qrc:/image/stop.png"
                }
                WButtonMouseArea{
                    anchors.fill: parent
                    onClicked: {
                        MainWindowModel.stop();
                    }
                }
            }

            Rectangle
            {
                id: play_button
                Layout.fillWidth: true
                Layout.minimumWidth: 40
                Layout.preferredWidth: 40
                Layout.maximumWidth: 40
                Layout.minimumHeight: 40
                color: "#333333"
                property bool pIsActive_: true

                onPIsActive_Changed: {
                    play_button_image_brightness.brightness = pIsActive_ ? 0 : -0.50
                }

                Image {
                    id: play_button_image
                    height: parent.height
                    width: height
                    source: "qrc:/image/play.png"
                }

                BrightnessContrast{
                    id: play_button_image_brightness
                    source: play_button_image
                    anchors.fill: play_button_image
                }

                WButtonMouseArea{
                    anchors.fill: parent

                    onClicked: {
                        if (! play_button.pIsActive_) return;

                        MainWindowModel.clearScore();
                        main_window.reflectData()
                        MainWindowModel.play(edit_area.getSeekBarPosition());
                        play_button.pIsActive_ = false
                    }
                }
            }

            Rectangle{
                id: pause_button

                Layout.fillWidth: true
                Layout.minimumWidth: 40
                Layout.preferredWidth: 40
                Layout.maximumWidth: 40
                Layout.minimumHeight: 40

                color: "#333333"
                Image {
                    height: parent.height
                    width: height
                    source: "qrc:/image/pause.png"
                }
                WButtonMouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (! play_button.pIsActive_) return;
                        MainWindowModel.pause();
                    }
                }
            }

            Rectangle{
                id: skip_next_button

                Layout.fillWidth: true
                Layout.minimumWidth: 40
                Layout.preferredWidth: 40
                Layout.maximumWidth: 40
                Layout.minimumHeight: 40

                color: "#333333"
                Image {
                    height: parent.height
                    width: height
                    source: "qrc:/image/skip_next.png"
                }
                WButtonMouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (! play_button.pIsActive_) return;
                        edit_area.skipToNextBar();
                        MainWindowModel.clearScore();
                        main_window.reflectData()
                        MainWindowModel.play(edit_area.getSeekBarPosition());
                    }
                }
            }
        }
    }

    Rectangle{
        width: 280
        height:parent.height
        color: "#333333"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        RowLayout{
            NoteLengthSelectBox{
                id: note_length_select_box
                width: 25
                color: "#333333"

                Layout.fillWidth: false
                Layout.minimumWidth: 100
                Layout.preferredWidth: 60
                Layout.maximumWidth: 100
                Layout.minimumHeight: 40
                Layout.margins: 2

            }

            ColumnLayout{
                TempoController{
                    color: "#333333"
                    id: tempo_controller
                    Layout.fillWidth: false
                    Layout.minimumWidth: 40
                    Layout.preferredWidth: 40
                    Layout.maximumWidth: 40
                    Layout.minimumHeight: 25
                    Layout.margins: 2

                }
                BeatController{
                    id: beat_controller
                    color: "#333333"
                    Layout.fillWidth: false
                    Layout.minimumWidth: 40
                    Layout.preferredWidth: 40
                    Layout.maximumWidth: 40
                    Layout.minimumHeight: 25
                    Layout.margins: 2
                }
            }
        }
    }

    Connections{
        target: MainWindowModel
        onActivePlayButton: {
            play_button.pIsActive_ = true;
        }
    }
}
