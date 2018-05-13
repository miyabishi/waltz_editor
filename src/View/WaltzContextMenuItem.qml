import QtQuick 2.0

Rectangle{
    id: root
    height: parent.height
    width: parent.width
    color: "#eeeeee"
    property string text: ""
    signal menuClicked();

    Text{
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Meiryo"
        font.pixelSize: 16
        text: root.text
        color:"black"

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                root.color = "#ccccff";
            }
            onExited: {
                root.color = "#eeeeee"
            }
            onClicked: {
                root.menuClicked();
            }
        }
    }
}
