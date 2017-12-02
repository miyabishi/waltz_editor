import QtQuick 2.0

Rectangle {
    id: root
    width: 2
    color: "#ff88ff"
    property int seekBase: 0
    property int timerInterval: 10

    Connections{
        target: MainWindowModel
        onStartSeekBar: {
            root.startSeekBar();
        }
        onResetSeekBar: {
            root.resetSeekBar();
        }
    }

    function startSeekBar()
    {
        seek_bar_timer.start();
    }

    function resetSeekBar()
    {
        seek_bar_timer.stop();
        root.x = root.seekBase;
    }

    function velocity()
    {
        var bpm = MainWindowModel.tempo();

        return bpm * edit_area.barLength() / 240.0 / 1000 * root.timerInterval;
    }

    Timer{
        id:seek_bar_timer
        interval: root.timerInterval;
        running: false;
        repeat: true
        onTriggered: {
            root.x += velocity()
        }
    }
}
