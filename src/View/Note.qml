import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    id: root
    property int pNoteId_
    property string pNoteText_
    property bool pEditing_: false
    property bool pStretching_: false
    property bool isSelected: false
    focus: true;

    property int positionX
    property int positionY

    border.color: "#000000"
    border.width: 1
    color: "#ffd700"
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0
    Drag.keys: ["note"]

    Keys.onReleased: {
        if(pEditing_ === true) return;

        if (event.key === Qt.Key_Enter ||
                event.key === Qt.Key_Return){
            selected_note_list_model_container.clear();
            selected_note_list_model_container.append(pNoteId_);
        }
    }

    property bool dragActive: note_move_mouse_area.drag.active

    onIsSelectedChanged:{
        if (isSelected)
        {
            root.color = "#00d7cc";
            return;
        }
        root.color = "#ffd700";
    }

    onDragActiveChanged: {
        if (dragActive) {
            Drag.start();
        } else {
            Drag.drop();
        }
    }

    Drag.dragType: Drag.Automatic

    Connections{
        target: note_list_model_container
        onModelUpdated:{
            if (aNoteId !== pNoteId_) return;
            reload();
        }
        onModelUpdatedAll:{
            reload();
        }
        onStartEditNoteText:{
            if(aNoteId !== pNoteId_) return;
            startEditNoteText();
        }
    }

    Connections{
        target: selected_note_list_model_container
        onModelUpdated:{
            isSelected = selected_note_list_model_container.isSelected(pNoteId_);
        }
    }

    function startEditNoteText()
    {
        if (root.pEditing_ === true) return;

        selected_note_list_model_container.clear();

        root.pEditing_ = true;
        note_text_field.forceActiveFocus();
        note_text_field.selectAll();
    }

    function updateNote()
    {
        positionX = x;
        positionY = y;
        note_list_model_container.updateNote({"noteId": pNoteId_,
                                              "noteText": pNoteText_,
                                              "positionX":positionX,
                                              "positionY":positionY,
                                              "noteWidth": root.width});

    }

    function reload()
    {
        var note = note_list_model_container.find(root.pNoteId_);

        note.portamentoEndX = root.x + 30;
        note.portamentoEndY = root.y + root.height / 2;

        root.pNoteText_ = note.noteText;
        root.x = note.positionX
        root.y = note.positionY
        root.positionX = note.positionX;
        root.positionY = note.positionY;
        root.width = note.noteWidth;
    }

    Text{
        text: pNoteText_
        font.family: "Meiryo"
        font.pointSize: 10
    }

    MouseArea{
        id: note_move_mouse_area
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: note_stretch_mouse_area.left
        acceptedButtons: Qt.LeftButton
        propagateComposedEvents: pEditing_
        drag.target: root

        onPressed: {
            if(isSelected) return;

            selected_note_list_model_container.clear();
            selected_note_list_model_container.append(pNoteId_);
        }

        onReleased: {
            root.updateNote()
            root.Drag.drop()
        }

        onClicked: {
            if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
            {
                note_list_model_container.removeNote(pNoteId_);
            }
        }

        onDoubleClicked: {
            if(mouse.modifiers & Qt.ControlModifier)
            {
                return
            }
            startEditNoteText();
        }
    }

    MouseArea{
        id: note_stretch_mouse_area
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        drag.axis: Drag.XAxis
        width: 10
        property int pPressedX_: 0

        acceptedButtons: Qt.LeftButton
        drag.target: root

        onMouseXChanged: {
            if(drag.active)
            {
                root.x = pPressedX_
                root.width += mouseX
            }
        }

        onPressed: {
            root.pStretching_ = true
            pPressedX_ = root.x
            root.focus = true
        }

        onReleased: {
            root.pStretching_ = false
            root.updateNote()
            root.Drag.drop()
        }
    }

    TextField{
        id:note_text_field
        visible: pEditing_
        focus: pEditing_
        text: parent.pNoteText_
        width: 60

        Keys.onBacktabPressed: {
            note_list_model_container.startEditPreviousNoteText(root.pNoteId_);
        }

        Keys.onTabPressed: {
            note_list_model_container.startEditNextNoteText(root.pNoteId_);
        }

        onAccepted: {
            parent.pEditing_ = false;
            parent.pNoteText_ = text;
            root.updateNote();
            MainWindowModel.writeHistory(main_window.createSaveData());
        }

        onEditingFinished: {
            parent.pEditing_ = false;
            parent.pNoteText_ = text;
            root.updateNote();
            root.forceActiveFocus();
        }

        onFocusChanged: {
            piano_roll_mouse_area.enabled = !focus
            note_move_mouse_area.enabled = !focus
        }
    }
}


