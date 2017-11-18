import QtQuick 2.0

Item{
    id: root
    property int pitchChangingPointId

    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true

    Connections{
        target: pitch_changing_point_list_model_containter
        onModelUpdated:{
            reload();
        }
    }

    Connections{
        target: note_list_model_container
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
        pitch_changing_point_list_model_containter.updatePitchChangingPoint(pitchChangingPointId,
                                                                            root.x + root.width / 2,
                                                                            root.y + root.height / 2);
    }

    Canvas{
        id: pitch_changing_point_canvas
        anchors.fill: parent
        onPaint: {
            var ctx = pitch_changing_point_canvas.getContext('2d');
            ctx.clearRect(0,0,pitch_changing_point_canvas.width, pitch_changing_point_canvas.height);

            ctx.strokeStyle = Qt.rgba(.6,.8,1);
            ctx.beginPath();
            ctx.moveTo(0,0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width, height);
            ctx.lineTo(0, height);
            ctx.lineTo(0,0);

            ctx.lineWidth = 2;
            ctx.stroke();
            ctx.restore();
        }
    }

    MouseArea{
        id: pitch_changing_point_mouse_area
        property int clickedPointX

        anchors.fill: root
        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAndYAxis

        onPositionChanged: {
            updatePitchChangingPoint();
        }

        onReleased: {
            updatePitchChangingPoint();
            root.Drag.drop();
        }

        onClicked: {
            if((mouse.button === Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
            {
                pitch_changing_point_list_model_containter.removePitchChangingPoint(pitchChangingPointId);
            }
        }
    }
}
