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

    Item{
        id: edit_area_actual_context_menu
        width: parent.width - 3
        height: parent.height - 3

        Column{
            WaltzContextMenuItem{
                id: context_menu_undo
                text: "Undo"
                width: 300
                height: 25
            }

            WaltzContextMenuItem{
                id: context_menu_redo
                text: "Redo"
                width: 300
                height: 25

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
        target:context_menu_undo
        onMenuClicked:{
            command_container.undo();
            closeMenu();
        }
    }

    DropShadow{
        source: edit_area_actual_context_menu
        anchors.fill: edit_area_actual_context_menu
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
    }
}
