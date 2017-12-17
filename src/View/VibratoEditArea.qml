import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: root
    color: "#222222"
    property int max: 20
    property int min: root.height - 35
    property int xOffset:0
//    signal toUpdateNoteVolume()

    /*
    onMinChanged: {
        toUpdateNoteVolume();
    }
*/
    onXOffsetChanged: {
        if (vibrato_edit_area_scroll_view.flickableItem.contentX === xOffset)
        {
            return;
        }
        vibrato_edit_area_scroll_view.flickableItem.contentX = xOffset
    }

    function calculateY(aValue)
    {
        return root.rangeWidth() / 2 - root.rangeWidth() * (aValue / 4.0) + root.max;
    }

    function rangeWidth()
    {
        return (root.min - root.max);
    }

    Rectangle {
        id: vibrato_axis
        anchors.top: parent.top
        anchors.left: parent.left
        width:80
        height: root.height
        color: "#333333"
        border.color: "#111111"

        onStateChanged: {}

        Text{
            y: root.max - 10
            x: parent.width - 28
            color: "#ffffff"
            text: "2"
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
            y: calculateY(0) - 10
            x: parent.width - 28
            color: "#ffffff"
            text: "0"
            font.family: "Meiryo"
            font.pixelSize: 14
        }

        Rectangle{
            y: calculateY(0)
            anchors.right: parent.right
            width: 10
            height: 2
            color: "#cdcdcd"
        }

        Text{
            y: root.min - 10
            x: parent.width - 35
            color: "#ffffff"
            text: "-2"
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
        id: vibrato_edit_area_scroll_view
        anchors.top: root.top
        anchors.left: vibrato_axis.right
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
                    vibrato_edit_area_scroll_view.flickableItem.contentX = edit_area.xOffset;
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
                y: calculateY(1)
                width : edit_area.editAreaWidth
                height: 1
            }

            Rectangle{
                color: "#555555"
                x: 0
                y: calculateY(0)
                width : edit_area.editAreaWidth
                height: 1
            }

            Rectangle{
                color: "#555555"
                x: 0
                y: calculateY(-1)
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
                id: vibrato_note_repeater
                model:note_list_model_container.getModel()
                Loader{
                    id:noteloader
                    sourceComponent: Component{
                        id: note_volume_bar
                        UndraggableNoteOnXAxis{
                            noteId: noteId
                            noteText: noteText
                            x: positionX
                            y: root.calculateY(0.5)
                            height: (calculateY(-0.5) - calculateY(0.5))
                            opacity: 0.8
                        }
                    }
                    onLoaded: {
                        item.visible = true;
                        item.noteId = noteId
                    }
                }
            }

            Canvas{
                id: vibrato_curve_canvas
                anchors.fill: parent
                onPaint: {
                    var ctx = vibrato_canvas.getContext('2d');
                    ctx.clearRect(0,0,vibrato_canvas.width, vibrato_canvas.height);

                    /*
                    for (var index = 0; index < note_list_model_container.count(); ++index)
                    {
                        //drawVibrato(ctx, index);
                    }
                    */
                }
/*
                function drawVibrato(aCtx, aIndex)
                {
                    aCtx.strokeStyle = Qt.rgba(.5,.9,.7);
                    aCtx.beginPath();

                    var note = note_list_model_container.findByIndex(aIndex);
                    var positionY = calculateY(0);

                    var vibratoStartX = note.positionX + note.noteWidth - note.vibratoLength;
                    var vibratoStartY =  positionY + edit_area.rowHeight / 2;

                    var vibratoEndX = note.positionX + note.noteWidth;
                    var vibratoEndY = positionY + edit_area.rowHeight / 2;

                    var length = vibratoEndX - vibratoStartX;


                    var frequency = note.vibratoFrequency
                    var halfWaveLength = length / frequency / 2;
                    var amplitude = note.vibratoAmplitude * edit_area.rowHeight / 2;

                    aCtx.moveTo(vibratoStartX - 10,
                                vibratoStartY);

                    var preControlX = vibratoStartX - 5;
                    var preControlY = vibratoStartY;

                    for (var index = 0; index < frequency * 2; ++index)
                    {
                        var direction = (index%2 == 0) ? 1 : -1;

                        aCtx.bezierCurveTo(preControlX,
                                           preControlY,
                                           vibratoStartX + halfWaveLength * index- 5,
                                           vibratoStartY + amplitude * direction,
                                           vibratoStartX + halfWaveLength * index ,
                                           vibratoStartY + amplitude * direction);

                        preControlX = vibratoStartX + halfWaveLength * index + 5;
                        preControlY = vibratoStartY + amplitude * direction;

                    }

                    aCtx.bezierCurveTo(preControlX,     preControlY,
                                       vibratoEndX -5 , vibratoEndY,
                                       vibratoEndX, vibratoEndY);
                    aCtx.lineWidth = 2;
                    aCtx.stroke();
                    aCtx.restore();
                }*/
            }
        }
    }
}
