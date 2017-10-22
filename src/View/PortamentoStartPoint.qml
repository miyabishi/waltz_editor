import QtQuick 2.0

Rectangle{
    id: root
    color: "#ffffff"
    property int noteId

    border.color: "#ccddff"
    border.width: 1
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true

    function centerX()
    {
        return root.x + root.width / 2;
    }
    function centerY()
    {
        return root.y + root.height / 2;
    }


    Connections{
        target: MainWindowModel
        onScoreUpdated:{
            reload();
        }
    }

    function reload()
    {
        var startPoint = MainWindowModel.portamentStartPoint(noteId);
        root.x = centerX();
        root.y = centerY();
    }

    function updateScore()
    {
        // スコアを更新する
        updateModel();
    }

    function updateModel()
    {
        // モデルを更新する
        note_list_model_container.updatePortamentoStartPoint(noteId, x, y);
    }

    MouseArea{
        id: portamento_start_point_mouse_area
        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onReleased: {
            root.Drag.drop();
            root.updateScore();
        }
    }
}

