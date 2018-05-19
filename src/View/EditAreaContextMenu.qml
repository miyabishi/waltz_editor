import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: root
    visible: false
    width: 400
    height: 200

    function openMenu(aX, aY)
    {
        root.x = aX
        root.y = aY
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
            command_container.paste(edit_area.calculateDropX(root));
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
