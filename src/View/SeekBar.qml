import QtQuick 2.0

Rectangle {
    id: root
    width: 3
    color: "#ee77ee"
    property int seekBase: 0
    property double seekBarOffset: 0.0
    property int timerInterval: 100

    Connections{
        target: MainWindowModel
        onStartSeekBar: {
            root.startSeekBar();
        }
        onResetSeekBar: {
            root.resetSeekBar();
        }
        onPauseSeekBar: {
            root.pauseSeekBar();
        }
    }

    function moveTo(aX)
    {
        root.x = aX;
    }

    function startSeekBar()
    {
        edit_area.xOffset = 0;
        seek_bar_timer.start();
    }

    function resetSeekBar()
    {
        seek_bar_timer.stop();
        root.seekBarOffset = 0;
        root.x = root.seekBase;
    }

    function pauseSeekBar()
    {
        seek_bar_timer.stop();
        root.seekBarOffset = root.x;
    }

    function velocity()
    {
        var bpm = MainWindowModel.tempo();

        return bpm * edit_area.barLength() / 240.0 / 1000.0 * root.timerInterval;
    }


    Timer{
        id:seek_bar_timer
        interval: root.timerInterval;
        running: false;
        repeat: true
        onTriggered: {
            root.seekBarOffset += velocity();
            root.x = root.seekBase + root.seekBarOffset;
            if ( (edit_area.xOffset + edit_area.width/2) < root.x &&
                 root.x < (edit_area.xOffset + edit_area.width) )
            {
                edit_area.xOffset += velocity();
            }
        }
    }
}
