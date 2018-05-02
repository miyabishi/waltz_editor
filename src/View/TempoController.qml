import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Rectangle{
    id:root
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

