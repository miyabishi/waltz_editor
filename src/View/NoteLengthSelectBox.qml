import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle{
    id: root
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    color:"#333333"

    width: 40
    height: 40

    anchors.verticalCenter: parent.verticalCenter
    property string imagePath: "qrc:/image/quarter_note.png"
    property int imageIndex: 1

    onImageIndexChanged: {
        if (imageIndex === 0)
        {
            imagePath = "qrc:/image/half_note.png";
            edit_area.noteLength = 2;
            return;
        }
        if (imageIndex === 1)
        {
            imagePath = "qrc:/image/quarter_note.png";
            edit_area.noteLength = 4;

            return;
        }
        if (imageIndex === 2)
        {
            imagePath = "qrc:/image/eighth_note.png";
            edit_area.noteLength = 8;
            return;
        }
        if (imageIndex === 3)
        {
            imagePath = "qrc:/image/sixteenth_note.png";
            edit_area.noteLength = 16;
            return;
        }
    }
    RowLayout{

        Text{
            id: note_length_text
            text: qsTr("Note: ")
            font.family: "Meiryo"
            font.pointSize: 10
            color:"#ffffff"

            Layout.fillWidth: false
            Layout.minimumWidth: 60
            Layout.preferredWidth: 60
            Layout.maximumWidth: 60
            Layout.minimumHeight: 40
        }

        Rectangle{
            color:root.color
            Layout.fillWidth: false
            Layout.minimumWidth: 40
            Layout.preferredWidth: 40
            Layout.maximumWidth: 40
            Layout.minimumHeight: 40

            Image {
                anchors.fill: parent
                height: 40
                width: 40
                source: root.imagePath
            }

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    root.imageIndex++;
                    if (root.imageIndex > 3)
                    {
                        root.imageIndex = 0;
                    }
                }
            }
        }
    }
}

