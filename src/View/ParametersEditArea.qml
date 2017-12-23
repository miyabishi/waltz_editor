import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    id: root
    StackLayout {
        width: parent.width
        height: parent.height
        currentIndex: bar.currentIndex

        VolumeEditArea {
            id: volume_edit_area
            xOffset: edit_area.xOffset
            onXOffsetChanged: {
                if (edit_area.xOffset === xOffset)
                {
                    return;
                }
                edit_area.xOffset = xOffset;
            }
        }

        EnvelopeEditArea {
            id: envelope_edit_area
        }

        VibratoEditArea{
            id: vibrato_edit_area
            xOffset: edit_area.xOffset
            onXOffsetChanged: {
                if (edit_area.xOffset === xOffset)
                {
                    return;
                }
                edit_area.xOffset = xOffset;
            }
        }
    }

    TabBar{
        id: bar
        width: parent.width
        height: 25
        anchors.bottom: parent.bottom
        background: Rectangle{
            anchors.fill: parent
            color: "#000000"
        }

        ParameterEditAreaTabButton {
            text: "Volume"
            height: 25
            width: 200
            index: 0
        }

        ParameterEditAreaTabButton {
            text: "Envelope"
            height: 25
            width: 200
            index: 1
        }

        ParameterEditAreaTabButton{
            id: vibrato_button
            text: "Vibrato"
            height: 25
            width: 200
            index: 2
        }
   }
}
