import QtQuick 2.0

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
            return;
        }
        if (imageIndex === 1)
        {
            imagePath = "qrc:/image/quarter_note.png";
            return;
        }
        if (imageIndex === 2)
        {
            imagePath = "qrc:/image/eighth_note.png";
            return;
        }
        if (imageIndex === 3)
        {
            imagePath = "qrc:/image/sixteenth_note.png";
            return;
        }
    }


    Image {
        anchors.left: parent.left
        height: parent.height
        width: height
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

