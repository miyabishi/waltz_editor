import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Dialog{
    id:root
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    width: 300
    height: 200
    title: "Pouring Lyrics"

    Rectangle{
        width: parent.width
        height: parent.height
        color: "white"
        TextArea{
            id: pouring_lyrics
            wrapMode: TextEdit.Wrap
            anchors.fill: parent
        }
    }



    onAccepted: {
        note_list_model_container.pouringLyrics(pouring_lyrics.text);
        close();
    }
}
