import QtQuick 2.0

Rectangle{
    id: root
    color: "#ffffff"
    property int pitchChangingPointId

    border.color: "#ccddff"
    border.width: 1
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true
/*
    Connections{
        target: pitch_changing_point_list_model_containter
        onModelUpdated:{
            reload();
        }
    }

    function reload()
    {
        var pitchChangingPoint = pitch_changing_point_list_model_containter.findPoint(pitchChangingPointId);
        root.x = pitchChangingPoint.x - root.width/2;
        root.y = pitchChangingPoint.y - root.height/2;
    }

    function updatePitchChangingPoint()
    {
        pitch_changing_point_list_model_containter.update(pitchChangingPointId,
                                                          root.x + root.width / 2,
                                                          root.y + root.height / 2);
    }

    MouseArea{
        id: pitch_changing_point_mouse_area
        property int clickedPointX

        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAndYAxis

        onReleased: {
            updatePitchChangingPoint();
            root.Drag.drop();
        }
    }
    */
}
