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
        id: note_actual_context_menu
        width: parent.width - 3
        height: parent.height - 3
        Column{


            WaltzContextMenuItem{
                id: context_menu_pouring_lyrics
                text: "Pouring lyrics"
                width: 300
                height:25
            }

            WaltzContextMenuItem{
                id: context_menu_note_connect_to_previous
                text: "Connect to previous"
                width: 300
                height:25
            }

            WaltzContextMenuItem{
                id: context_menu_note_connect_to_next
                text: "Connect to next"
                width: 300
                height:20
            }

            WaltzContextMenuItem{
                id: context_menu_note_delete
                text: "Delete"
                width: 300
                height:20
            }
        }

    }

    Connections{
        target:context_menu_note_delete
        onMenuClicked:{
            selected_note_list_model_container.removeSelectedNotes();
            closeMenu();
        }
    }

    Connections{
        target:context_menu_note_connect_to_next
        onMenuClicked:{
            selected_note_list_model_container.connectSelectedNotesToNextNote();
            closeMenu();
        }
    }

    Connections{
        target:context_menu_note_connect_to_previous
        onMenuClicked:{
            selected_note_list_model_container.connectSelectedNotesToPreviousNote();
            closeMenu();
        }
    }

    Connections{
        target: context_menu_pouring_lyrics
        onMenuClicked:{
            pouring_lyrics_dialog.open();
            closeMenu();
        }
    }

    DropShadow{
        source: note_actual_context_menu
        anchors.fill: note_actual_context_menu
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
    }
}
