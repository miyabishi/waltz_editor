import QtQuick 2.0

Rectangle {
    id:root
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

            width: edit_area.isBlackKey(index) ? parent.width * 0.6 : parent.width
            height: calculateKeyHeight(index)
            y: calculateYPosition(index)
            z: edit_area.isBlackKey(index) ? 10 : 5
            color: edit_area.isBlackKey(index) ? "#333333" : "#eeeeee"
            border.color: "#333333"
        }
    }
}
