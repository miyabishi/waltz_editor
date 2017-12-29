import QtQuick 2.0

Item {
    id: root
    property int vibratoId
    property int noteId

    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    Drag.active: true

    function updateVibratoWavelengthEndPoint()
    {
    }

    function calculateWavelength(aVibratoStartPointX)
    {
        return aVibratoStartPointX *4/3;
    }

    Canvas{
        id: vibrato_wavelength_end_point_canvas
        anchors.fill: parent
        onPaint: {
            var ctx = vibrato_wavelength_end_point_canvas.getContext('2d');
            ctx.clearRect(0,0,vibrato_wavelength_end_point_canvas.width, vibrato_wavelength_end_point_canvas.height);
            ctx.strokeStyle = Qt.rgba(.5,.9,.7);

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
        id: vibrato_wavelength_end_point_mouse_area
        anchors.fill: root

        acceptedButtons: Qt.LeftButton
        drag.target: root
        drag.axis: Drag.XAxis

        onPositionChanged: {
            updateVibratoWevelengthEndPoint();
        }

        onReleased: {
            root.Drag.drop();
        }
    }
}
