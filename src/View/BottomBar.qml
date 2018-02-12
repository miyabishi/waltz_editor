import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0 as Controls
import QtGraphicalEffects 1.0

Rectangle{
    id: root
    color: "#333333"
    Rectangle {
        id: player_controller
        color: "#333333"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 180
        height: parent.height * 0.7

        Rectangle{
            id: stop_button
            anchors.left: parent.left
            height: parent.height
            width:height
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
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: height
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
                    if (! play_button.pIsActive_)
                    {
                        return;
                    }

                    MainWindowModel.clearScore();
                    note_list_model_container.reflect();
                    pitch_changing_point_list_model_containter.reflect();
                    portamento_start_point_list_model_container.reflect();
                    portamento_end_point_list_model_container.reflect();
                    vibrato_list_model_container.reflect();
                    note_volume_list_model_container.reflect();

                    MainWindowModel.play(edit_area.getSeekBarPosition());
                    play_button.pIsActive_ = false
                }
            }
        }

        Rectangle{
            id: pause_button
            anchors.right: parent.right
            height: parent.height
            width: height
            color: "#333333"
            Image {
                height: parent.height
                width: height
                source: "qrc:/image/pause.png"
            }
            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    MainWindowModel.pause();
                }
            }
        }
    }

    Rectangle{
        width: 300
        anchors.right:parent.right
        color: "#333333"

        Rectangle{
            id: tempo_controller
            height:25
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 5
            color:parent.color
            Text{
                id: tempo_text
                text: "Tempo: "
                font.family: "Meiryo"
                font.pointSize: 10
                color:"#ffffff"
            }
            SpinBox{
                id: tempo_box
                width: 80
                anchors.left: tempo_text.right
                value: MainWindowModel.tempo()
                maximumValue: 999
                minimumValue: 0
                style: SpinBoxStyle{
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        border.color: "gray"
                        color:"#222222"
                        radius: 2
                    }
                    textColor: "#ffffff"
                }
                onValueChanged: {
                    MainWindowModel.setTempo(value)
                }
            }
        }
        Rectangle{
            id: beat_controller
            anchors.left: parent.left
            anchors.top: tempo_controller.bottom
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 5
            function updateBeat(child, parent)
            {
                MainWindowModel.setBeat(child, parent)
                edit_area.updateProperty();
            }

            Text{
                anchors.left: parent.left
                id: beat_text
                text: "Beat:  "
                font.family: "Meiryo"
                font.pointSize: 10
                color:"#ffffff"
            }
            SpinBox{
                id: beat_box_child
                width: 60
                anchors.left: beat_text.right
                maximumValue: 12
                minimumValue: 1
                value: MainWindowModel.beatChild()
                style: SpinBoxStyle{
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        border.color: "gray"
                        color:"#222222"
                        radius: 2
                    }
                    textColor: "#ffffff"
                }
                onValueChanged: {
                    MainWindowModel.setBeatChild(value);
                    edit_area.updateProperty()
                }
            }
            Text{
                id: slash_text
                text: "/"
                font.family: "Meiryo"
                font.pointSize: 10
                color:"#ffffff"
                anchors.left: beat_box_child.right
            }
            ComboBox{
                id: beat_box_parent
                property int value: MainWindowModel.beatParent()
                width: 40
                anchors.left: slash_text.right
                model:["4","2","8"]
                style: ComboBoxStyle{
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        border.color: "gray"
                        color:"#222222"
                        radius: 2
                    }
                    textColor: "#ffffff"
                    property Component __dropDownStyle:MenuStyle{
                        itemDelegate.label:
                            Text {
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 12
                            font.family: "Meiryo"
                            font.capitalization: Font.SmallCaps
                            color: styleData.selected ? "white" : "black"
                            text: styleData.text
                        }
                    }
                }
                onCurrentIndexChanged: {
                    value = getCurrentValue(currentIndex)
                    MainWindowModel.setBeatParent(value)
                    edit_area.updateProperty()
                }
                function getCurrentValue(aIndex){
                    if (aIndex === 0)
                    {
                        return 4
                    }
                    if (aIndex === 1)
                    {
                        return 2
                    }
                    if (aIndex === 2)
                    {
                        return 8
                    }
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
