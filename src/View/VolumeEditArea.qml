import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: root
    color: "#222222"
    property int max: 20
    property int min: height - 35
    property int xOffset:0
    signal toUpdateNoteVolume()

    onMinChanged: {
        toUpdateNoteVolume();
    }

    onXOffsetChanged: {
        if (volume_edit_area_scroll_view.flickableItem.contentX === xOffset)
        {
            return;
        }
        volume_edit_area_scroll_view.flickableItem.contentX = xOffset
    }

    function calculateY(aValue)
    {
        return min - noteVolumeBarHeight(aValue);
    }

    function calculateVolume(aHeight)
    {
        return 150 * aHeight / maxHeight();
    }

    function noteVolumeBarHeight(aValue)
    {
        return  maxHeight() * (aValue / 150);
    }

    function maxHeight()
    {
        return (min - max);
    }

    Rectangle {
        id: volume_axis
        anchors.top: parent.top
        anchors.left: parent.left
        width:80
        height: root.height
        color: "#333333"
        border.color: "#111111"

        onStateChanged: {}

        Text{
            y: root.max - 10
            x: parent.width - 50
            color: "#ffffff"
            text: "150"
            font.family: "Meiryo"
            font.pixelSize: 14
        }

        Rectangle{
            y: root.max
            anchors.right: parent.right
            width: 10
            height: 2
            color: "#cdcdcd"
        }

        Text{
            y: calculateY(100) - 10
            x: parent.width - 50
            color: "#ffffff"
            text: "100"
            font.family: "Meiryo"
            font.pixelSize: 14
        }

        Rectangle{
            y: calculateY(100)
            anchors.right: parent.right
            width: 10
            height: 2
            color: "#cdcdcd"
        }

        Text{
            y: root.min - 10
            x: parent.width - 28
            color: "#ffffff"
            text: "0"
            font.family: "Meiryo"
            font.pixelSize: 14

        }

        Rectangle{
            y: root.min
            anchors.right: parent.right
            width: 10
            height: 2
            color: "#cdcdcd"
        }
    }

    ScrollView {
        id: volume_edit_area_scroll_view
        anchors.top: root.top
        anchors.left: volume_axis.right
        anchors.right: root.right
        height: root.height
        flickableItem.onContentXChanged: {
            root.xOffset = flickableItem.contentX;
        }

        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn

        Rectangle {
            color: "#111111"
            width: edit_area.editAreaWidth
            height: parent.height
            Connections{
                target: edit_area
                onXOffsetChanged:{
                    volume_edit_area_scroll_view.flickableItem.contentX = edit_area.xOffset;
                }
            }

            Rectangle{
                color: "#555555"
                x: 0
                y: root.min
                width : edit_area.editAreaWidth
                height: 2
            }

            Rectangle{
                color: "#555555"
                x: 0
                y: calculateY(100)
                width : edit_area.editAreaWidth
                height: 1
            }
            Rectangle{
                color: "#555555"
                x: 0
                y: root.max
                width : edit_area.editAreaWidth
                height: 2
            }

            Repeater{
                id: note_volume_repeater
                model:note_volume_list_model_container.getModel()
                Loader{
                    id:noteloader
                    sourceComponent: Component{
                        id: note_volume_bar
                        NoteVolumeBar{
                            width: 10
                            height: noteVolumeBarHeight(volume)
                            x: positionX
                        }
                    }
                    onLoaded: {
                        item.noteVolumeId = noteVolumeId;
                        item.y = root.calculateY(volume);
                        item.visible = true;
                    }
                }
            }
        }
    }
}
