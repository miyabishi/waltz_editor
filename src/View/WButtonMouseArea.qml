import QtQuick 2.0

MouseArea{
    acceptedButtons: Qt.LeftButton
    property string backgroundColor: "#333333"
    hoverEnabled: true
    onEntered: {
        parent.color = "#666666";
    }
    onExited: {
        parent.color = backgroundColor;
    }
    onPressed: {
        parent.color = "#444488";
    }
    onReleased: {
        parent.color = "#666666";
    }
}

