import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2


ApplicationWindow {
    id:main_window
    visible: true
    width: 1280
    height: 940
    title: qsTr("Waltz Editor")

    Rectangle{
        id: top_bar
        color: "#333333"
        height: 60
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        z: 10

        Rectangle{
            id: file_buttons
            color:parent.color
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 80
            height: 32
            Image {
                id: save_button
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/save.png"
            }

        }

        Rectangle{
            id: tool_buttons
            color:parent.color
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: file_buttons.right
            width: 80
            height: 32
            Image {
                id: edit_button
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/edit.png"
            }

            Image {
                id: cursor_button
                anchors.right: parent.right
                height: parent.height
                width: height
                source: "qrc:/image/cursor.png"
            }

        }

    }

    SplitView{
        anchors.top: top_bar.bottom
        anchors.left: parent.left
        anchors.right:parent.right
        anchors.bottom:bottom_bar.top
        Rectangle{
            id: library_information
            color:"#222222"
            width: 320
            z:1
            anchors.top:parent.top
            anchors.bottom: parent.bottom

            property string character_image: MainWindowModel.characterImageUrl()
            property string library_description: MainWindowModel.libraryDescription()
            property string library_name: MainWindowModel.libraryName()

            Connections{
                target: MainWindowModel
                onLibraryInformationUpdated: {
                    library_information.library_description = MainWindowModel.libraryDescription()
                    library_information.character_image = MainWindowModel.characterImageUrl()
                    library_information.library_name = MainWindowModel.libraryName()
                }
            }

            ColumnLayout{
                anchors.fill:parent
                Image{
                    z:0
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32
                    source:"qrc:/image/open.png"
                    FileDialog{
                        id:vocalOpenDialog
                        nameFilters: ["Vocal File(*." + MainWindowModel.vocalFileExtention() + ")"]
                        selectMultiple: false
                        onAccepted: {
                            MainWindowModel.loadVoiceLibrary(vocalOpenDialog.fileUrl)
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            vocalOpenDialog.open()
                        }
                    }
                }

                Text{
                    id: vocal_name
                    z:0
                    Layout.alignment: Qt.AlignCenter
                    text: library_information.library_name
                    font.pointSize: 14
                    Layout.preferredHeight: 50
                    color: "#ffffff"
                    font.family: "Meiryo"
                }

                Item{
                    z:0
                    id: vocal
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 350
                    Layout.preferredWidth: 200
                    Image{
                        id: vocal_image
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                        source: library_information.character_image
                        smooth: true
                        visible: false
                    }
                    DropShadow {
                        anchors.fill: vocal_image
                        horizontalOffset: -20
                        verticalOffset: 0
                        radius: 4.0
                        samples: 9
                        color: "#000000"
                        source: vocal_image
                    }
                }
/*                Text{
                    z:0
                    Layout.alignment: Qt.AlignCenter
                    color: "#ffffff"
                    font.family: "Meiryo"
                    font.pointSize: 7
                    text:"voice：momoko fujimoto

files : 256
size :  73086636bytes
uses : 93.8%
freq avg : 341.7 Hz (F4)
logical range : A#3～D5
voices : 691"
                }*/
                Rectangle{
                    z:0
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 200
                    Layout.preferredWidth: parent.width
                    color:"#222222"
                    TextArea{
                        anchors.fill:parent
                        anchors.margins: 10
                        text: library_information.library_description
                        textColor: "#ffffff"
                        backgroundVisible:false
                        readOnly: true
                    }
                }

            }

        }

        Rectangle{
            id: edit_area
            color: "#222222"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: library_information.right
            anchors.right: parent.right

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

                    Repeater{
                        id: note_repeater
                        model: ListModel{}
                        Loader{
                            sourceComponent: Component{
                                id: note
                                Rectangle{
                                    id: note_rect
                                    property int pNoteId_: noteId
                                    property string pNoteText_: noteText
                                    property bool pEditing_: false

                                    width: edit_area.columnWidth
                                    height: edit_area.rowHeight

                                    border.color: "#000000"
                                    border.width: 1
                                    color:"#ffd700"

                                    Text{
                                        text: pNoteText_
                                        font.family: "Meiryo"
                                        font.pointSize: 10
                                    }
                                    TextField{
                                        visible: pEditing_
                                        focus: pEditing_
                                        text: parent.pNoteText_
                                        width: 60
                                        onAccepted: {
                                            parent.pEditing_ = false
                                            MainWindowModel.updateNote(parent.pNoteId_, parent.pNoteText_, parent.x, parent.y, parent.width)
                                        }
                                        onFocusChanged: {
                                            piano_roll_mouse_area.enabled = !focus
                                            note_mouse_area.enabled = !focus
                                            if (!focus)
                                            {
                                                parent.pEditing_ = false;
                                                parent.pNoteText_ = text;
                                            }
                                        }
                                    }

                                    MouseArea{
                                        id: note_mouse_area
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton
                                        propagateComposedEvents: true
                                        onDoubleClicked: {
                                            if(mouse.modifiers & Qt.ControlModifier)
                                            {
                                                return
                                            }
                                            note_rect.pEditing_ = true
                                            mouse.accepted = false
                                        }
                                        onClicked: {
                                            mouse.accepted = false
                                        }
                                    }
                                }
                            }
                            onLoaded: {
                                item.x = positionX
                                item.y = positionY
                                item.visible = true
                                item.width = noteWidth
                            }
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
                        propagateComposedEvents: true;
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
                            {
                                var positionX = piano_roll_edit_area.calcX(mouseX)
                                var positionY = piano_roll_edit_area.calcY(mouseY)
                                var noteText = "あ"
                                var noteId = MainWindowModel.publishNoteId();
                                note_repeater.model.append({"noteId": noteId,
                                                            "noteText": noteText,
                                                            "positionX": positionX,
                                                            "positionY": positionY,
                                                            "noteWidth": edit_area.columnWidth});
                                MainWindowModel.appendNote(noteId, noteText, positionX, positionY, edit_area.columnWidth)
                            }
                            mouse.accepted = false
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
    }

    Rectangle{
        id: bottom_bar
        height:71
        color: "#333333"
        width: parent.width
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        Rectangle {
            id: player_controller
            color: "#333333"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 180
            height: parent.height * 0.7

            Image {
                id: stop_button
                anchors.left: parent.left
                height: parent.height
                width: height
                source: "qrc:/image/stop.png"
            }

            Image {
                id: play_button
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height
                width: height
                source: "qrc:/image/play.png"

                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        MainWindowModel.play();
                    }
                }
            }

            Image {
                id: pause_button
                anchors.right: parent.right
                height: parent.height
                width: height
                source: "qrc:/image/pause.png"
            }
        }
        Rectangle{
            width: 300
            anchors.right:parent.right
            color: "#333333"

            Rectangle{
                id: tempo_controller
                height:25
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 5
                color:parent.color
                Text{
                    id: tempo_text
                    text: "Tempo: "
                    font.family: "Meiryo"
                    font.pointSize: 10
                    color:"#ffffff"
                }
                SpinBox{
                    id: tempo_box
                    width: 80
                    anchors.left: tempo_text.right
                    value: MainWindowModel.tempo()
                    maximumValue: 999
                    minimumValue: 0
                    style: SpinBoxStyle{
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 25
                            border.color: "gray"
                            color:"#222222"
                            radius: 2
                        }
                        textColor: "#ffffff"
                    }
                    onValueChanged: {
                        MainWindowModel.setTempo(value)
                    }
                }
            }
            Rectangle{
                id: beat_controller
                anchors.left: parent.left
                anchors.top: tempo_controller.bottom
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 5
                function updateBeat(child, parent)
                {
                    MainWindowModel.setBeat(child, parent)
                    edit_area.updateProperty();
                }

                Text{
                    anchors.left: parent.left
                    id: beat_text
                    text: "Beat:  "
                    font.family: "Meiryo"
                    font.pointSize: 10
                    color:"#ffffff"
                }
                SpinBox{
                    id: beat_box_child
                    width: 60
                    anchors.left: beat_text.right
                    maximumValue: 12
                    minimumValue: 1
                    value: MainWindowModel.beatChild()
                    style: SpinBoxStyle{
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 25
                            border.color: "gray"
                            color:"#222222"
                            radius: 2
                        }
                        textColor: "#ffffff"
                    }
                    onValueChanged: {
                        MainWindowModel.setBeatChild(value);
                        edit_area.updateProperty()
                    }
                }
                Text{
                    id: slash_text
                    text: "/"
                    font.family: "Meiryo"
                    font.pointSize: 10
                    color:"#ffffff"
                    anchors.left: beat_box_child.right
                }
                ComboBox{
                    id: beat_box_parent
                    property int value: MainWindowModel.beatParent()
                    width: 40
                    anchors.left: slash_text.right
                    model:["4","2","8"]
                    style: ComboBoxStyle{
                        background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 25
                            border.color: "gray"
                            color:"#222222"
                            radius: 2
                        }
                        textColor: "#ffffff"
                        property Component __dropDownStyle:MenuStyle{
                            itemDelegate.label:
                                Text {
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 12
                                font.family: "Meiryo"
                                font.capitalization: Font.SmallCaps
                                color: styleData.selected ? "white" : "black"
                                text: styleData.text
                            }
                        }
                    }
                    onCurrentIndexChanged: {
                        value = getCurrentValue(currentIndex)
                        MainWindowModel.setBeatParent(value)
                        edit_area.updateProperty()
                    }
                    function getCurrentValue(aIndex){
                        if (aIndex === 0)
                        {
                            return 4
                        }
                        if (aIndex === 1)
                        {
                            return 2
                        }
                        if (aIndex === 2)
                        {
                            return 8
                        }
                    }
                }
            }
        }
    }

    Dialog {
        id: errorDialog
        visible: false
        title: "Error"
        property string error_message: ""
        modality: Qt.WindowModal
        standardButtons: StandardButton.Ok
    }

    Connections{
        target: MainWindowModel
        onErrorOccurred: {
            errorDialog.error_message = aErrorMessage
            errorDialog.open()
        }
    }

}
