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

    ScrollView{
        id:portament_area_piano_view
        anchors.top:beat_axis_view.bottom
        width:80
        height: parent.height

        flickableItem.onContentYChanged: {
            portamento_edit_area_scroll_view.flickableItem.contentY = flickableItem.contentY
        }
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        PianoRoll{
            id: portamento_piano_roll
            width:80
            height: parent.height
        }
    }

    Timer {
        id: updateContentDelay
        interval: 200
        repeat: false

        onTriggered: {
            portament_area_piano_view.flickableItem.contentY = edit_area.contentY;
        }
    }

    ScrollView{
        id: portamento_edit_area_scroll_view
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        anchors.left: portament_area_piano_view.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: beat_axis_view.bottom

        flickableItem.visibleArea.onHeightRatioChanged: {
            updateContentDelay.restart();
        }

        flickableItem.onContentXChanged: {
            xOffset = flickableItem.contentX;
        }

        flickableItem.onContentYChanged: {
            portament_area_piano_view.flickableItem.contentY = flickableItem.contentY;
        }

        Rectangle{
            id: portamento_edit_area_in
            width: edit_area.editAreaWidth
            height: edit_area.numberOfRow * edit_area.rowHeight

            Connections{
                target: note_list_model_container
                onModelUpdated:{
                    pitch_curve_canvas.requestPaint();
                    portamento_edit_area_in.scrollToNote(aNoteId);
                }
            }

            Connections{
                target: portamento_start_point_list_model_container
                onModelUpdated:{
                    pitch_curve_canvas.requestPaint();
                }
            }

            Connections{
                target: portamento_end_point_list_model_container
                onModelUpdated:{
                    pitch_curve_canvas.requestPaint();
                }
            }

            Connections{
                target: pitch_changing_point_list_model_containter
                onModelUpdated:{
                    pitch_curve_canvas.requestPaint();
                }
            }

            function scrollToNote(aNoteId)
            {
                var note = note_list_model_container.find(aNoteId);
                if (! note) return;
                var visibleRangeYPositionMin = portamento_edit_area_scroll_view.flickableItem.contentY;
                var visibleRangeYPositionMax = visibleRangeYPositionMin + root.height;

                if (visibleRangeYPositionMin > note.positionY ||
                    visibleRangeYPositionMax < (note.positionY + edit_area.rowHeight))
                {
                    var scrollPosition = note.positionY - root.height / 2 + edit_area.rowHeight / 2;
                    portamento_edit_area_scroll_view.flickableItem.contentY = scrollPosition;
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
                        MainWindowModel.writeHistory(main_window.createSaveData());
                    }
                }
            }

            Canvas{
                parent:portamento_edit_area_scroll_view
                id: pitch_curve_canvas
                contextType: "2d"
                anchors.fill: parent

                canvasSize: Qt.size(portamento_edit_area_scroll_view.flickableItem.contentWidth,
                                    portamento_edit_area_scroll_view.flickableItem.contentHeight)

                canvasWindow: Qt.rect(portamento_edit_area_scroll_view.flickableItem.contentX,
                                      portamento_edit_area_scroll_view.flickableItem.contentY,
                                      portamento_edit_area_scroll_view.width,
                                      portamento_edit_area_scroll_view.height)

                tileSize: Qt.size(portamento_edit_area_scroll_view.width,
                                  portamento_edit_area_scroll_view.height)

                onCanvasWindowChanged: requestPaint()

                onPaint: {
                    var ctx = pitch_curve_canvas.getContext('2d');
                    ctx.clearRect(portamento_edit_area_scroll_view.flickableItem.contentX,
                                  portamento_edit_area_scroll_view.flickableItem.contentY,
                                  portamento_edit_area_scroll_view.width,
                                  portamento_edit_area_scroll_view.height);

                    for (var index = 0; index < note_list_model_container.count(); ++index)
                    {
                        drawPitchCurve(ctx, index);
                    }
                }

                function drawPitchCurve(aCtx, aIndex)
                {
                    drawPortamento(aCtx, aIndex);
                }

                // TODO リファクタリング　コードが汚い
                function drawPortamento(aCtx, aIndex)
                {
                    aCtx.strokeStyle = Qt.rgba(.6,.8,1);
                    aCtx.beginPath();

                    var note = note_list_model_container.findByIndex(aIndex);

                    var pitchChangingPointListModel =
                            pitch_changing_point_list_model_containter.createChangingPointListModelByNoteId(note.noteId);

                    var portamentoStartPoint = portamento_start_point_list_model_container.findByNoteId(note.noteId);
                    var portamentoStartX = portamentoStartPoint.portamentoStartX
                                         + portamentoStartPoint.portamentoStartXOffset;
                    var portamentoStartY = portamentoStartPoint.portamentoStartY;

                    var portamentoEndPoint = portamento_end_point_list_model_container.findByNoteId(note.noteId);
                    var portamentoEndX = portamentoEndPoint.portamentoEndX
                                       + portamentoEndPoint.portamentoEndXOffset;
                    var portamentoEndY = portamentoEndPoint.portamentoEndY;

                    aCtx.moveTo(portamentoStartX,
                                portamentoStartY);

                    var preControlX = 0;
                    var preControlY = portamentoStartY;


                    if (pitchChangingPointListModel.count === 0)
                    {
                        preControlX = portamentoStartX +
                                      (portamentoEndX - portamentoStartX) / 2;
                    }
                    else
                    {
                        var firstChangingPoint = pitchChangingPointListModel.get(0);
                        var firstChangingPointX = note.positionX + firstChangingPoint.pitchChangingPointX;
                        preControlX = portamentoStartX +
                                      (firstChangingPointX - portamentoStartX) / 2;
                    }

                    for (var index = 0; index < pitchChangingPointListModel.count; ++index)
                    {
                        var changingPoint = pitchChangingPointListModel.get(index);
                        if (changingPoint.noteId !== note.noteId) continue;

                        var changingPointX = note.positionX + changingPoint.pitchChangingPointX;
                        var changingPointY = note.positionY + changingPoint.pitchChangingPointY;

                        aCtx.bezierCurveTo(preControlX,         preControlY,
                                           preControlX, changingPointY,
                                           changingPointX,      changingPointY);

                        if (index + 1  === pitchChangingPointListModel.count)
                        {
                            preControlX = changingPointX +
                                          (portamentoEndX - changingPointX) / 2;
                        }
                        else
                        {
                            var nextChangingPoint = pitchChangingPointListModel.get(index + 1);
                            var nextChangingPointX = note.positionX + nextChangingPoint.pitchChangingPointX;
                            preControlX = changingPointX +
                                          (nextChangingPointX - changingPointX) / 2;
                        }


                        preControlY = changingPointY;
                    }

                    aCtx.bezierCurveTo(preControlX, preControlY,
                                       preControlX, portamentoEndY,
                                       portamentoEndX, portamentoEndY);

                    pitchChangingPointListModel.destroy();
                    aCtx.lineWidth = 1;
                    aCtx.stroke();
                    aCtx.restore();
                }
            }

            Repeater{
                id: portamento_start_point_repeater
                model: portamento_start_point_list_model_container.getModel()
                Loader{
                    sourceComponent: PortamentoStartPoint{
                        id: protamento_start_point
                        width: 10
                        height: 10
                    }
                    onLoaded: {
                        item.noteId = noteId
                        item.portamentoStartPointId = portamentoStartPointId;
                        item.x = portamentoStartX;
                        item.y = portamentoStartY;
                    }
                }
            }

            Repeater{
                id: portamento_end_point_repeater
                model:portamento_end_point_list_model_container.getModel()
                Loader{
                    sourceComponent: PortamentoEndPoint{
                        id: protamento_end_point
                        width: 10
                        height: 10
                    }
                    onLoaded: {
                        item.noteId = noteId
                        item.portamentoEndPointId = portamentoEndPointId;
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
                        PitchChangingPoint{
                            id: pitch_changing_point
                            width:10
                            height:10
                        }
                    }
                    onLoaded: {
                        var note = note_list_model_container.find(noteId);
                        item.noteId = noteId
                        item.x = note.positionX + pitchChangingPointX - 5;
                        item.y = note.positionY + pitchChangingPointY - 5;
                        item.pitchChangingPointId = pitchChangingPointId;
                        item.visible = true;
                        pitch_curve_canvas.requestPaint();
                    }
                }
            }

            DropArea{
                id: portamento_edit_drop_area
                anchors.fill: parent
                onDropped: {
                    MainWindowModel.writeHistory(main_window.createSaveData());
                }
            }
        }
    }

    Rectangle{
        id: beat_axis_view
        height: 20
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
                    font.pointSize: 7
                }
            }
        }
    }
}

