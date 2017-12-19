import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: root
    color: "#222222"
    property int max: 20
    property int min: root.height - 35
    property int xOffset:0
    onVisibleChanged: {
        console.log ("vibrato edit area visible changed");
    }

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

    function baseWidth()
    {
        return (calculateY(-1) - calculateY(1));
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
            id: sample
            color: "#111111"
            width: edit_area.editAreaWidth
            height: parent.height

            Connections{
                target: edit_area
                onXOffsetChanged:{
                    vibrato_edit_area_scroll_view.flickableItem.contentX = edit_area.xOffset;
                }
            }

            Connections{
                target: vibrato_list_model_container
                onModelUpdated:{
                    console.log("request paint");
                    vibrato_canvas.markDirty(Qt.rect(0,0,vibrato_canvas.width, vibrato_canvas.height));
                    vibrato_canvas.requestPaint();
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


            Canvas{
                id: vibrato_canvas
                anchors.fill: parent
                visible: root.visible

                onVisibleChanged: {
                    console.log("canvas visible changed");
                    vibrato_canvas.requestPaint();
                    console.log("abailable:" + vibrato_canvas.available);

                }
                onPaint: {
                    var ctx = vibrato_canvas.getContext('2d');
                    ctx.clearRect(0, 0, vibrato_canvas.width, vibrato_canvas.height);
                    console.log("vibrato count: ", vibrato_list_model_container.count());

                    for (var index = 0; index < vibrato_list_model_container.count(); ++index)
                    {
                        console.log("paint index:" + index);
                        drawVibrato(ctx, index);
                    }
                }

                function drawVibrato(aCtx, aIndex)
                {
                    console.log("draw vibrato index:" + aIndex);
                    aCtx.strokeStyle = Qt.rgba(.5,.9,.7);
                    aCtx.beginPath();

                    var vibrato = vibrato_list_model_container.findByIndex(aIndex);
                    var note = note_list_model_container.find(vibrato.noteId);
                    var positionY = calculateY(0);

                    var vibratoStartX = note.positionX + note.noteWidth - vibrato.length;
                    var vibratoStartY =  positionY;

                    var vibratoEndX = note.positionX + note.noteWidth;
                    var vibratoEndY = positionY;

                    var length = vibratoEndX - vibratoStartX;

                    var frequency = vibrato.frequency
                    var halfWaveLength = length / frequency / 2;
                    var amplitude = vibrato.amplitude * baseWidth();

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
                }
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
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log("clicked!");
                                    if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
                                    {
                                        vibrato_list_model_container.append(parent.noteId,
                                                                            parent.width / 3,
                                                                            5,
                                                                            0.5);
                                    }
                                }
                            }
                        }
                    }
                    onLoaded: {
                        item.visible = true;
                        item.noteId = noteId
                    }
                }
            }
        }
    }
}
