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
        id:piano_view
        anchors.top:beat_axis_view.bottom
        width:80
        Rectangle {
            id:piano_roll_area
            height:edit_area.numberOfRow * edit_area.rowHeight
            y: -edit_area_scroll_view.flickableItem.contentY
            Repeater{
                model:edit_area.numberOfRow
                Rectangle{
                    function calculateKeyHeight(aIndex){
                        switch(aIndex%12){
                        case 1:
                        case 3:
                        case 5:
                        case 8:
                        case 10:
                            return edit_area.rowHeight
                        case 0:
                        case 7:
                            return edit_area.rowHeight * 1.5
                        }
                        return edit_area.rowHeight * 2.0
                    }

                    function calculateYPosition(aIndex){
                        switch(aIndex%12){
                        case 2:
                        case 4:
                        case 6:
                        case 9:
                        case 11:
                            return aIndex * edit_area.rowHeight - edit_area.rowHeight / 2
                        }
                        return aIndex * edit_area.rowHeight
                    }

                    width: edit_area.isBlackKey(index) ? piano_view.width * 0.6 : piano_view.width
                    height: calculateKeyHeight(index)
                    y: calculateYPosition(index)
                    z: edit_area.isBlackKey(index) ? 10 : 5
                    color: edit_area.isBlackKey(index) ? "#333333" : "#eeeeee"
                    border.color: "#333333"
                }
            }
        }
    }

    ScrollView{
        id: edit_area_scroll_view
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        anchors.left: piano_view.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: beat_axis_view.bottom

        Rectangle{
            id: piano_roll_edit_area
            width: edit_area.editAreaWidth
            height: edit_area.numberOfRow * edit_area.rowHeight
            signal updateAllNote()

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
                        var portamentStartX = 0;
                        var portamentStartY = MainWindowModel.yPositionOfPreviousNote(positionX - 1,
                                                                                      positionY + edit_area.rowHeight / 2,
                                                                                      noteId);
                        var portamentEndX = 60;
                        var portamentEndY = positionY + edit_area.rowHeight / 2;

                        note_repeater.model.append({"noteId": noteId,
                                                    "noteText": noteText,
                                                    "positionX": positionX,
                                                    "positionY": positionY,
                                                    "noteWidth": noteWidth,
                                                    "portamentoStartX": portamentStartX,
                                                    "portamentoStartY": portamentStartY,
                                                    "portamentoEndX": portamentEndX,
                                                    "portamentoEndY": portamentEndY});
                        MainWindowModel.appendNote(noteId,
                                                   noteText,
                                                   positionX ,
                                                   positionY,
                                                   edit_area.columnWidth,
                                                   portamentStartX,
                                                   portamentStartY,
                                                   portamentEndX,
                                                   portamentEndY);
                    }
                }
            }

            Repeater{
                id: note_repeater
                model: ListModel{}
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
                            width: edit_area.columnWidth
                            height: edit_area.rowHeight
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
                        piano_roll_edit_area.updateAllNote.connect(item.updateNote);
                    }
                }
            }

            DropArea{
                id: edit_drop_area
                anchors.fill: parent
                function calculeDropX(source)
                {
                    var sourceHead = source.x
                    var sourceTail = source.x + source.width
                    var count = MainWindowModel.noteCount()
                    for(var i = 0; i < count; ++i)
                    {
                        var otherNote = note_repeater.itemAt(i)
                        var otherNoteHead = MainWindowModel.findNotePositionX(i)
                        var otherNoteTail = otherNoteHead + otherNote.width

                        if (sourceHead < (otherNoteTail + 10) && sourceHead > (otherNoteTail - 10))
                        {
                            return otherNoteTail
                        }
                        if (sourceTail < (otherNoteHead + 10) && sourceTail > (otherNoteHead -10))
                        {
                            return otherNoteHead - source.width
                        }
                    }
                    return sourceHead
                }

                onPositionChanged:{
                    drag.source.y = piano_roll_edit_area.calcY(drag.y);
                    drag.source.x = calculeDropX(drag.source);
                    drag.source.positionX = drag.source.x;
                    drag.source.positionY = drag.source.y;
                    drag.source.updatePortamento();
                }

                onDropped: {
                    piano_roll_edit_area.updateAllNote()
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

