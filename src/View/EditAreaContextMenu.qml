import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: root
    visible: false
    property bool open: false
    width: 100
    height: 200

    function openMenu(aX, aY)
    {
        root.x = aX
        root.y = aY
        visible = true;
        open = true;
    }

    function closeMenu()
    {
        visible = false;
        open = false;
    }

    Item{
        id: actual_context_menu
        width: parent.width - 3
        height: parent.height - 3
        Column{
            WaltzContextMenuItem{
                id: context_menu_undo
                text: "undo"
                width: 200
                height:20
            }

            WaltzContextMenuItem{
                id: context_menu_redo
                text: "redo"
                width: 200
                height:20

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
        source: actual_context_menu
        anchors.fill: actual_context_menu
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
    }

}
