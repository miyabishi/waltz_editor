import QtQuick 2.0

MouseArea{
    acceptedButtons: Qt.LeftButton
    hoverEnabled: true
    onEntered: {
        parent.color = "#666666"
    }
    onExited: {
        parent.color = "#333333"
    }
    onPressed: {
        parent.color = "#444488"
    }
    onReleased: {
        parent.color = "#666666"
    }
}

