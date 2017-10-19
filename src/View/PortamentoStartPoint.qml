import QtQuick 2.0

Rectangle{
    id: root
    color: "#ffffff"
    property int noteId

    border.color: "#ccddff"
    border.width: 1

    Connections{
        target: MainWindowModel
        onScoreUpdated:{
            reload();
        }
    }

    function reload()
    {
        console.log("noteid" + noteId);
        var startPoint = MainWindowModel.portamentStartPoint(noteId);
        root.x = startPoint.x - width / 2;
        root.y = startPoint.y - height / 2;
        console.log("(" + root.x + ", " + ")");
    }


}

