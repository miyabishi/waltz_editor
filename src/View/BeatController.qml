import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Rectangle{
    id:root

    function reload()
    {
        beat_box_child.value = MainWindowModel.beatChild();
        beat_box_parent.value = MainWindowModel.beatParent();
    }

    function updateBeat(child, parent)
    {
        MainWindowModel.setBeat(child, parent)
        edit_area.updateProperty();
    }

    Text{
        anchors.left: parent.left
        id: beat_text
        text: "Beat:  "
        font.family: "Meiryo"
        font.pointSize: 10
        color:"#ffffff"
    }
    SpinBox{
        id: beat_box_child
        width: 60
        anchors.left: beat_text.right
        maximumValue: 12
        minimumValue: 1
        value: MainWindowModel.beatChild()
        style: SpinBoxStyle{
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.color: "gray"
                color:"#222222"
                radius: 2
            }
            textColor: "#ffffff"
        }
        onValueChanged: {
            MainWindowModel.setBeatChild(value);
            edit_area.updateProperty()
        }
    }
    Text{
        id: slash_text
        text: "/"
        font.family: "Meiryo"
        font.pointSize: 10
        color:"#ffffff"
        anchors.left: beat_box_child.right
    }
    ComboBox{
        id: beat_box_parent
        property int value: MainWindowModel.beatParent()
        width: 40
        anchors.left: slash_text.right
        model:["4","2","8"]
        style: ComboBoxStyle{
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.color: "gray"
                color:"#222222"
                radius: 2
            }
            textColor: "#ffffff"
            property Component __dropDownStyle:MenuStyle{
                itemDelegate.label:
                    Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 12
                    font.family: "Meiryo"
                    font.capitalization: Font.SmallCaps
                    color: styleData.selected ? "white" : "black"
                    text: styleData.text
                }
            }
        }
        onCurrentIndexChanged: {
            value = getCurrentValue(currentIndex)
            MainWindowModel.setBeatParent(value)
            edit_area.updateProperty()
        }
        function getCurrentValue(aIndex){
            if (aIndex === 0)
            {
                return 4
            }
            if (aIndex === 1)
            {
                return 2
            }
            if (aIndex === 2)
            {
                return 8
            }
        }
    }
}
