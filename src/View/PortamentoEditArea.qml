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
            signal reloadAllNote()

            Connections{
                target:MainWindowModel
                onScoreUpdated:{
                    portamento_edit_area.reloadAllNote();
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
                id: note_repeater
                model: note_list_model
                Loader{
                    id:noteloader
                    sourceComponent: Component{
                        id: note
                        Note{
                            pNoteId_: noteId
                            pNoteText_: noteText
                            pEditing_: false
                            positionX: positionX
                            positionY: positionY
                            portamentoStartX: portamentoStartX;
                            portamentoStartY: portamentoStartY;
                            portamentoEndX: portamentoEndX;
                            portamentoEndY: portamentoEndY;
                            width: edit_area.columnWidth;
                            height: edit_area.rowHeight;
                            color: "#555555";
                            isEditable: false;
                        }
                    }
                    onLoaded: {
                        item.x = positionX;
                        item.y = positionY;
                        item.visible = true;
                        item.width = noteWidth;
                        item.portamentoStartX = portamentoStartX;
                        item.portamentoStartY = portamentoStartY;
                        item.portamentoEndX = portamentoEndX;
                        item.portamentoEndY = portamentoEndY;
                        item.vibratoAmplitude = vibratoAmplitude;
                        item.vibratoFrequency = vibratoFrequency;
                        item.vibratoLength= vibratoLength;
                        pitch_curve_canvas.requestPaint();
                        item.isEditable = false;
                    }
                }
            }

            Canvas{
                id: pitch_curve_canvas
                anchors.fill: parent
                onPaint: {
                    var ctx = pitch_curve_canvas.getContext('2d');
                    ctx.clearRect(0,0,pitch_curve_canvas.width, pitch_curve_canvas.height);

                    for (var index = 0; index < MainWindowModel.noteCount(); ++index)
                    {
                        drawPitchCurve(ctx, MainWindowModel.noteIdFromIndex(index));
                    }

                }

                function drawPitchCurve(aCtx, aNoteId)
                {
                    drawPortamento(aCtx, aNoteId);
                    drawVibrato(aCtx, aNoteId);
                }

                function drawVibrato(aCtx, aNoteId)
                {
                    aCtx.strokeStyle = Qt.rgba(.5,.9,.7);
                    aCtx.beginPath();

                    var vibratoStartPoint = MainWindowModel.vibratoStartPoint(aNoteId);
                    var vibratoStartX = vibratoStartPoint.x;
                    var vibratoStartY = vibratoStartPoint.y;

                    var vibratoEndPoint = MainWindowModel.vibratoEndPoint(aNoteId);
                    var vibratoEndX = vibratoEndPoint.x;
                    var vibratoEndY = vibratoEndPoint.y;

                    var length = vibratoEndX - vibratoStartX;
                    var frequency = MainWindowModel.vibratoFrequency(aNoteId);
                    var halfWaveLength = length / frequency / 2;
                    var amplitude = MainWindowModel.vibratoAmplitude(aNoteId) * edit_area.rowHeight / 2;


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

                function drawPortamento(aCtx, aNoteId)
                {
                    aCtx.strokeStyle = Qt.rgba(.6,.8,1);
                    aCtx.beginPath();

                    var portamentStartPoint = MainWindowModel.portamentStartPoint(aNoteId);
                    var portamentoStartX = portamentStartPoint.x;
                    var portamentoStartY = portamentStartPoint.y;

                    var pitchChangingPointCount = MainWindowModel.pitchChangingPointCount(aNoteId);

                    var portamentEndPoint = MainWindowModel.portamentEndPoint(aNoteId)
                    var portamentoEndX = portamentEndPoint.x;
                    var portamentoEndY = portamentEndPoint.y;

                    aCtx.moveTo(portamentoStartX,
                                portamentoStartY);

                    var preControlX = portamentoStartX + 30
                    var preControlY = portamentoStartY;

                    for (var index = 0; index < pitchChangingPointCount; ++index)
                    {
                        var changingPoint = MainWindowModel.pitchChangingPoint(aNoteId, index);
                        var changingPointX = changingPoint.x;
                        var changingPointY = changingPoint.y;

                        aCtx.bezierCurveTo(preControlX,         preControlY,
                                           changingPointX - 10, changingPointY,
                                           changingPointX,      changingPointY);

                        preControlX = changingPointX + 10;
                        preControlY = changingPointY;
                    }

                    aCtx.bezierCurveTo(preControlX, preControlY,
                                       portamentoEndX - 30, portamentoEndY,
                                       portamentoEndX, portamentoEndY);
                    aCtx.lineWidth = 2;
                    aCtx.stroke();
                    aCtx.restore();
                }
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
