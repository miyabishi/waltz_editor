import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: root
    visible: false
    property bool open: false

    width: 100
    height: 100

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
    //    color: "#eeeeee"
        width: parent.width - 3
        height: parent.height - 3
        Column{
            Rectangle{
                id: menu_background
                height: 20
                width: 100
                color: "#eeeeee"

                Text{
                    width: actual_context_menu.width
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Meiryo"
                    font.pixelSize: 16

                    color:"black"
                    text:"undo"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: {
                            console.log("entered");
                            menu_background.color = "#ccccff";
                        }

                        onClicked: {
                            console.log("pressed! ");
                            command_container.undo();
                            edit_area_context_menu.closeMenu();
                        }
                    }
                }
            }



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
