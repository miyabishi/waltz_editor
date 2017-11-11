import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: root
    color: "#222222"
    property int xOffset:0

    onXOffsetChanged: {
        if (portamento_edit_area_scroll_view.flickableItem.contentX === xOffset)
        {
            return;
        }
        portamento_edit_area_scroll_view.flickableItem.contentX = xOffset
    }

    function updateProperty(){
        edit_area.supportOctarve = MainWindowModel.supportOctave()
        edit_area.numberOfRow    = 12 * supportOctarve
        edit_area.rowHeight      = MainWindowModel.rowHeight()
        edit_area.beatChild      = MainWindowModel.beatChild()
        edit_area.beatParent     = MainWindowModel.beatParent()
        edit_area.columnWidth    = MainWindowModel.columnWidth()
        edit_area.editAreaWidth  = MainWindowModel.editAreaWidth()
    }
    function isBlackKey(aIndex){
        switch(aIndex%12){
        case 1:
        case 3:
        case 5:
        case 8:
        case 10:
            return true
        }
        return false
    }
    function reloadCanvas()
    {
        pitch_curve_canvas.requestPaint();
    }

    Rectangle{
        id:portament_area_piano_view
        anchors.top:beat_axis_view.bottom
        width:80
        PianoRoll{
            id: portamento_piano_roll
            width: parent.width
            y: -portamento_edit_area_scroll_view.flickableItem.contentY
        }
    }

    ScrollView{
        id: portamento_edit_area_scroll_view
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        anchors.left: portament_area_piano_view.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: beat_axis_view.bottom
        flickableItem.onContentXChanged: {
            xOffset = flickableItem.contentX;
        }


        Rectangle{
            id: portamento_edit_area
            width: edit_area.editAreaWidth
            height: edit_area.numberOfRow * edit_area.rowHeight

            Connections{
                target: note_list_model_container
                onModelUpdated:{
                    pitch_curve_canvas.requestPaint();
                }
            }


            Repeater{
                model: edit_area.numberOfRow
                Rectangle{
                    width:  parent.width
                    height: edit_area.rowHeight
                    y: index * edit_area.rowHeight
                    color: edit_area.isBlackKey(index) ? "#333333" : "#444444"
                    border.color: "#222222"
                }
            }

            Repeater{
                model: parent.width / edit_area.columnWidth
                Rectangle{
                    height: parent.height
                    width: (index%edit_area.beatChild == 0) ? 3 : 2
                    x: index * edit_area.columnWidth
                    color: (index%edit_area.beatChild == 0) ? "#222222" : "#111111"
                }
            }

            function calcX(aX){
                return aX - aX%edit_area.columnWidth
            }

            function calcY(aY){
                return aY - aY%edit_area.rowHeight
            }

            Repeater{
                id: portamento_note_repeater
                model: note_list_model_container.getModel()
                Loader{
                    id:noteloader
                    sourceComponent: Component{
                        id: note
                        UndraggableNote{
                            pNoteId_: noteId
                            pNoteText_: noteText
                            height: edit_area.rowHeight;
                        }
                    }
                    onLoaded: {
                        item.x = positionX;
                        item.y = positionY;
                        item.visible = true;
                        item.width = noteWidth;
                        pitch_curve_canvas.requestPaint();
                    }
                }
            }

            MouseArea{
                id: portamento_edit_mouse_area
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
                    {
                        pitch_changing_point_list_model_containter.append(mouseX, mouseY)
                    }
                }
            }

            Canvas{
                id: pitch_curve_canvas
                anchors.fill: parent
                onPaint: {
                    var ctx = pitch_curve_canvas.getContext('2d');
                    ctx.clearRect(0,0,pitch_curve_canvas.width, pitch_curve_canvas.height);

                    for (var index = 0; index < note_list_model_container.count(); ++index)
                    {
                        drawPitchCurve(ctx, index);
                    }

                }

                function drawPitchCurve(aCtx, aIndex)
                {
                    drawPortamento(aCtx, aIndex);
                    //drawVibrato(aCtx, aIndex);
                }

                function drawVibrato(aCtx, aIndex)
                {
                    aCtx.strokeStyle = Qt.rgba(.5,.9,.7);
                    aCtx.beginPath();

                    var note = note_list_model_container.findByIndex(aIndex);

                    var vibratoStartX = note.positionX + note.noteWidth - note.vibratoLength;
                    var vibratoStartY =  note.positionY + edit_area.rowHeight / 2;

                    var vibratoEndX = note.positionX + note.noteWidth;
                    var vibratoEndY = note.positionY + edit_area.rowHeight / 2;

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
                }


                function drawPortamento(aCtx, aIndex)
                {
                    aCtx.strokeStyle = Qt.rgba(.6,.8,1);
                    aCtx.beginPath();
                    var note = note_list_model_container.findByIndex(aIndex);

                    var portamentoStartX = note.portamentoStartX + note.portamentoStartXOffset;
                    var portamentoStartY = note.portamentoStartY;

                    var pitchChangingPointCount = note.pitchChangingPointCount;

                    var portamentoEndX = note.portamentoEndX + note.portamentoEndXOffset;
                    var portamentoEndY = note.portamentoEndY;

                    aCtx.moveTo(portamentoStartX,
                                portamentoStartY);

                    var preControlX = portamentoStartX + 30
                    var preControlY = portamentoStartY;

/*
                    for (var index = 0; index < pitchChangingPointCount; ++index)
                    {
                        var changingPointX = note.pitchChangingPointXArray[index];
                        var changingPointY = note.pitchChangingPointYArray[index];

                        aCtx.bezierCurveTo(preControlX,         preControlY,
                                           changingPointX - 10, changingPointY,
                                           changingPointX,      changingPointY);

                        preControlX = changingPointX + 10;
                        preControlY = changingPointY;
                    }
*/

                    aCtx.bezierCurveTo(preControlX, preControlY,
                                       portamentoEndX - 30, portamentoEndY,
                                       portamentoEndX, portamentoEndY);
                    aCtx.lineWidth = 2;
                    aCtx.stroke();
                    aCtx.restore();
                }
            }

            Repeater{
                id: portamento_start_point_repeater
                model:  note_list_model_container.getModel()
                Loader{
                    sourceComponent: PortamentoStartPoint{
                        id: protamento_start_point
                        width: 10
                        height: 10
                    }
                    onLoaded: {
                        item.noteId = noteId
                        item.x = portamentoStartX;
                        item.y = portamentoStartY;
                    }
                }
            }

            Repeater{
                id: portamento_end_point_repeater
                model:  note_list_model_container.getModel()
                Loader{
                    sourceComponent: PortamentoEndPoint{
                        id: protamento_end_point
                        width: 10
                        height: 10
                    }
                    onLoaded: {
                        item.noteId = noteId
                        item.x = portamentoEndX;
                        item.y = portamentoEndY;
                    }
                }
            }

            Repeater{
                id: pitch_changing_point_repeater
                model: pitch_changing_point_list_model_containter.getModel()
                Loader{
                    sourceComponent: Component{
                        id: note
                        PitchangingPoint{
                            id: pitch_changing_point
                            width:10
                            height:10
                        }
                    }
                    onLoaded: {
                        var note = note_list_model_container.find(noteId);
                        item.x = note.positionX + pitchChangingPointX;
                        item.y = note.positionY + pitchChangingPointY;
                        item.visible = true;
                        pitch_curve_canvas.requestPaint();
                    }
                }
            }

            DropArea{
                id: portamento_edit_drop_area
                anchors.fill: parent
            }
        }
    }

    Rectangle{
        id: beat_axis_view
        height: 40
        color: "#222222"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 0
        Rectangle{
            id: beat_axis_area
            color: "#222222"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: edit_area.editAreaWidth
            x: -portamento_edit_area_scroll_view.flickableItem.contentX

            Repeater{
                model: parent.width / edit_area.columnWidth * edit_area.beatChild
                Rectangle{
                    width: 3
                    height: parent.height /2
                    anchors.bottom: parent.bottom
                    color: "#cccccc"
                    x: portament_area_piano_view.width + index * edit_area.columnWidth * edit_area.beatChild
                }
            }

            Repeater{
                model: parent.width / edit_area.columnWidth * edit_area.beatChild
                Text{
                    x: portament_area_piano_view.width + index * edit_area.columnWidth * edit_area.beatChild + 10
                    anchors.bottom: parent.bottom
                    text: index
                    color: "#ffffff"
                    font.family: "Meiryo"
                    font.pointSize: 9
                }
            }
        }
    }
}

