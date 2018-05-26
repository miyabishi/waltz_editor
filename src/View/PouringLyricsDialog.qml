import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

Dialog{
    id:root
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    width: 300
    height: 200
    title: "Pouring Lyrics"

    TextEdit{
        id: pouring_lyrics
        color: "#000000"
        width: parent.width
        height: parent.height - 100
    }

    onAccepted: {
        note_list_model_container.pouringLyrics(pouring_lyrics.text);
        close();
    }
}
