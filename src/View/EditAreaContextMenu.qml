import QtQuick 2.0
import QtQuick.Window 2.2

Window{
    id: root
    visible: false
    width: edit_area_actual_context_menu.width
    height: edit_area_actual_context_menu.height
    flags: Qt.ToolTip

    function openMenu()
    {
        var mousePos = MainWindowModel.cursorPosition();
        root.x = mousePos.x;
        root.y = mousePos.y;
        visible = true;
    }

    function closeMenu()
    {
        visible = false;
    }

    Rectangle{
        id: edit_area_actual_context_menu
        border.color: "#999999"
        border.width: 1
        width:  edit_area_actual_context_column.width + border.width * 2
        height: edit_area_actual_context_column.height + border.width * 2

        Column{
            id: edit_area_actual_context_column
            x: edit_area_actual_context_menu.border.width
            y: edit_area_actual_context_menu.border.width

            WaltzContextMenuItem{
                id: context_menu_paste
                text: "Paste"
                width: 300
                height: 30
            }

            WaltzContextMenuItem{
                id: context_menu_select_all
                text: "Select All"
                width: 300
                height: 30
            }

            WaltzContextMenuItem{
                id: context_menu_undo
                text: "Undo"
                width: 300
                height: 30
            }

            WaltzContextMenuItem{
                id: context_menu_redo
                text: "Redo"
                width: 300
                height: 30
            }
        }
    }

    Connections{
        target:context_menu_redo
        onMenuClicked:{
            command_container.redo();
            closeMenu();
        }
    }

    Connections{
        target:context_menu_paste
        onMenuClicked:{
            command_container.paste(edit_area.calculateDropX(context_menu_delegate));
            closeMenu();
        }
    }

    Connections{
        target:context_menu_select_all
        onMenuClicked:{
            note_list_model_container.selectAll();
            closeMenu();
        }
    }

    Connections{
        target:context_menu_undo
        onMenuClicked:{
            command_container.undo();
            closeMenu();
        }
    }
}
