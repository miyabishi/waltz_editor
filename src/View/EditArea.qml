import QtQuick 2.7
import QtQuick.Controls 1.4

Rectangle{
    id: edit_area

    color: "#222222"
    property int supportOctarve: MainWindowModel.supportOctave()
    property int numberOfRow:    12 * supportOctarve
    property int rowHeight:      MainWindowModel.rowHeight()
    property int beatChild:      MainWindowModel.beatChild()
    property int beatParent:     MainWindowModel.beatParent()
    property int columnWidth:    MainWindowModel.columnWidth()
    property int editAreaWidth:  MainWindowModel.editAreaWidth()
    property int xOffset:0

    onXOffsetChanged: {
        if (edit_area_scroll_view.flickableItem.contentX === xOffset)
        {
            return;
        }
        edit_area_scroll_view.flickableItem.contentX = xOffset
    }



    function updateProperty(){
        edit_area.supportOctarve = MainWindowModel.supportOctave();
        edit_area.numberOfRow    = 12 * supportOctarve;
        edit_area.rowHeight      = MainWindowModel.rowHeight();
        edit_area.beatChild      = MainWindowModel.beatChild();
        edit_area.beatParent     = MainWindowModel.beatParent();
        edit_area.columnWidth    = MainWindowModel.columnWidth();
        edit_area.editAreaWidth  = MainWindowModel.editAreaWidth();
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
        id:piano_view
        anchors.top:beat_axis_view.bottom
        width:80
        PianoRoll{
            id:piano_roll_area
            width: parent.width
            x: 0
            y: -edit_area_scroll_view.flickableItem.contentY
        }
    }

    ScrollView{
        id: edit_area_scroll_view
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        anchors.left: piano_view.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: beat_axis_view.bottom

        flickableItem.onContentXChanged: {
            xOffset = flickableItem.contentX;
        }

        Rectangle{
            id: piano_roll_edit_area
            width: edit_area.editAreaWidth
            height: edit_area.numberOfRow * edit_area.rowHeight

            Repeater{
                model: edit_area.numberOfRow
                Rectangle{
                    width:  parent.width
                    height: edit_area.rowHeight
                    y: index * edit_area.rowHeight
                    color: edit_area.isBlackKey(index) ? "#eeeeee" : "#ffffff"
                    border.color: "#ddddee"
                }
            }

            Repeater{
                model: parent.width / edit_area.columnWidth
                Rectangle{
                    height: parent.height
                    width: (index%edit_area.beatChild == 0) ? 3 : 2
                    x: index * edit_area.columnWidth
                    color: (index%edit_area.beatChild == 0) ? "#ccccdd" : "#ddddee"
                }
            }

            function calcX(aX){
                return aX - aX%edit_area.columnWidth
            }

            function calcY(aY){
                return aY - aY%edit_area.rowHeight
            }

            MouseArea{
                id: piano_roll_mouse_area
                anchors.fill:parent
                property bool control_pressing :false
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
                    {
                        var positionX = piano_roll_edit_area.calcX(mouseX);
                        var positionY = piano_roll_edit_area.calcY(mouseY);
                        var noteText = "あ";
                        var noteId = MainWindowModel.publishNoteId();

                        var noteWidth = edit_area.columnWidth;
                        var portamentoStartX = positionX - 30;
                        var portamentoStartY = note_list_model_container.yPositionOfPreviousNote(positionX - 1,
                                                                                                 positionY + edit_area.rowHeight / 2,
                                                                                                 noteId);
                        var portamentoEndX = positionX + 30;
                        var portamentoEndY = positionY + edit_area.rowHeight / 2;

                        var vibratoAmplitude = 1.2;
                        var vibratoFrequency = 4;
                        var vibratoLength = edit_area.columnWidth /2 ;

                        note_list_model_container.append({"noteId": noteId,
                                                "noteText": noteText,
                                                "positionX": positionX,
                                                "positionY": positionY,
                                                "noteWidth": noteWidth,
                                                "portamentoStartX": portamentoStartX,
                                                "portamentoStartY": portamentoStartY,
                                                "portamentoStartXOffset":0,
                                                "portamentoEndX": portamentoEndX,
                                                "portamentoEndY": portamentoEndY,
                                                "portamentoEndXOffset":0,
                                                "vibratoAmplitude": vibratoAmplitude,
                                                "vibratoFrequency": vibratoFrequency,
                                                "vibratoLength": vibratoLength});
                    }
                }
            }

            Repeater{
                id: note_repeater
                model:note_list_model_container.getModel()
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
                            portamentoStartX: portamentoStartX
                            portamentoStartY: portamentoStartY
                            portamentoEndX: portamentoEndX
                            portamentoEndY: portamentoEndY
                            vibratoAmplitude: vibratoAmplitude
                            vibratoFrequency: vibratoFrequency
                            vibratoLength: vibratoLength
                            width: noteWidth
                            height: edit_area.rowHeight
                        }
                    }
                    onLoaded: {
                        item.x = positionX;
                        item.y = positionY;
                        item.positionX = positionX;
                        item.positionY = positionY;
                        item.visible = true;
                        item.portamentoStartX = portamentoStartX;
                        item.portamentoStartY = portamentoStartY;
                        item.portamentoEndX = portamentoEndX;
                        item.portamentoEndY = portamentoEndY;
                        item.vibratoLength = vibratoLength;
                        item.vibratoAmplitude = vibratoAmplitude;
                        item.vibratoFrequency = vibratoFrequency;
                    }
                }
            }

            DropArea{
                id: edit_drop_area
                anchors.fill: parent

                function calculateDropX(source)
                {
                    var sourceHead = source.x
                    var sourceTail = source.x + source.width

                    for(var index = 0; index < note_list_model_container.count(); ++index)
                    {
                        var otherNote = note_list_model_container.findByIndex(index)
                        var otherNoteHead = otherNote.positionX;
                        var otherNoteTail = otherNoteHead + otherNote.width;

                        if (otherNote.pNoteId_ === source.pNoteId_) continue;

                        if (sourceHead < (otherNoteTail + 10) && sourceHead > (otherNoteTail - 10))
                        {
                            return otherNoteTail;
                        }
                        if (sourceTail < (otherNoteHead + 10) && sourceTail > (otherNoteHead -10))
                        {
                            return otherNoteHead - source.width;
                        }
                    }
                    return sourceHead
                }

                function calculateDropY(source)
                {
                    return source.y - source.y%edit_area.rowHeight
                }

                onPositionChanged:{
                    drag.source.y = calculateDropY(drag.source);
                    drag.source.x = calculateDropX(drag.source);
                }

                onDropped: {
                    //drag.source.updateNote();

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
            x: -edit_area_scroll_view.flickableItem.contentX

            Repeater{
                model: parent.width / edit_area.columnWidth * edit_area.beatChild
                Rectangle{
                    width: 3
                    height: parent.height /2
                    anchors.bottom: parent.bottom
                    color: "#cccccc"
                    x: piano_view.width + index * edit_area.columnWidth * edit_area.beatChild
                }
            }

            Repeater{
                model: parent.width / edit_area.columnWidth * edit_area.beatChild
                Text{
                    x: piano_view.width + index * edit_area.columnWidth * edit_area.beatChild + 10
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
