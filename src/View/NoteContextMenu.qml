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
        id: note_actual_context_menu
        border.color: "#999999"
        border.width: 1
        width: context_menu_column.width + border.width * 2
        height: context_menu_column.height + border.width * 2

        Column{
            id: context_menu_column
            x: note_actual_context_menu.border.width
            y: note_actual_context_menu.border.width

            WaltzContextMenuItem{
                id: context_menu_note_copy
                text: "Copy"
                width: 300
                height:30
            }

            WaltzContextMenuItem{
                id: context_menu_note_cut
                text: "Cut"
                width: 300
                height:30
            }

            WaltzContextMenuItem{
                id: context_menu_note_paste
                text: "Paste"
                width: 300
                height:30
            }

            WaltzContextMenuItem{
                id: context_menu_note_delete
                text: "Delete"
                width: 300
                height:30
            }

            WaltzContextMenuItem{
                id: context_menu_pouring_lyrics
                text: "Pouring lyrics..."
                width: 300
                height:30
            }

            WaltzContextMenuItem{
                id: context_menu_note_connect_to_previous
                text: "Connect to previous"
                width: 300
                height:30
            }

            WaltzContextMenuItem{
                id: context_menu_note_connect_to_next
                text: "Connect to next"
                width: 300
                height:30
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
}
