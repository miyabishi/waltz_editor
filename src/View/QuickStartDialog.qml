import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.2


Dialog{
    id: root
    title: qsTr("Quick Start")

    width: 400
    height: 240
    standardButtons: Dialog.NoButton

    onVisibleChanged: {
        if (visible) return;
        MainWindowModel.setShouldOpenQuickStartDialogOnStartUp(
                    check_box_do_not_show_again.checkState != Qt.Checked);
    }


    Item{
        id: quick_start_area
        anchors.fill: parent
        property int state_num: 1
        state:"quick_start_1"
        states:[
            State{
                name: "quick_start_1"
                PropertyChanges {
                    target: quick_start_text
                    text: qsTr('To place a note, \
hold down the \"Ctr\" key and \
click the piano roll.
If you click the note again, you can delete the note.')
                }
                PropertyChanges {
                    target: quick_start_back_button
                    visible: false
                }
                PropertyChanges {
                    target: quick_start_next_button
                    visible: true
                }
            },
            State{
                name: "quick_start_2"
                PropertyChanges {
                    target: quick_start_text
                    text: qsTr('By selecting menu bar item of \"View\", \
It is possible to display editing area of portamento and parameters.')
                }
                PropertyChanges {
                    target: quick_start_back_button
                    visible: true
                }
                PropertyChanges {
                    target: quick_start_next_button
                    visible: true
                }
            },
            State{
                name: "quick_start_3"
                PropertyChanges {
                    target: quick_start_text
                    text: qsTr('In portamento edit view, \
you can move portamento by dragging and dropping. \
It is also possible to add or delete pitch change points \
by clicking while holding down the "Ctr" key.')
                }
                PropertyChanges {
                    target: quick_start_back_button
                    visible: true
                }
                PropertyChanges {
                    target: quick_start_next_button
                    visible: true
                }
            },
            State{
                name: "quick_start_4"
                PropertyChanges {
                    target: quick_start_text
                    text: qsTr('In the parameter edit view, \
you can select parameters to edit by clicking the tab. \
Parameters include volume and vibrato.')
                }
                PropertyChanges {
                    target: quick_start_back_button
                    visible: true
                }
                PropertyChanges {
                    target: quick_start_next_button
                    visible: true
                }
            },
            State{
                name: "quick_start_5"
                PropertyChanges {
                    target: quick_start_text
                    text: qsTr('Volume can be changed by dragging the bar displayed in parameter edit view.')
                }
                PropertyChanges {
                    target: quick_start_back_button
                    visible: true
                }
                PropertyChanges {
                    target: quick_start_next_button
                    visible: true
                }
            },
            State{
                name: "quick_start_6"
                PropertyChanges {
                    target: quick_start_text
                    text: qsTr('Vibrato can be edited by dragging a square mark in parameter edit view.')
                }
                PropertyChanges {
                    target: quick_start_back_button
                    visible: true
                }
                PropertyChanges {
                    target: quick_start_next_button
                    visible: false
                }
            }
        ]

        ColumnLayout{
            Text{
                id: quick_start_text
                Layout.maximumWidth: quick_start_area.width
                font.family: "Mairyo"
                font.pointSize: 11
                Layout.fillHeight: true
                Layout.preferredHeight: 130
                wrapMode: Text.WordWrap
            }
            CheckBox{
                id: check_box_do_not_show_again
                text:qsTr("Do not show this dialog on startup.")
                checked: ! MainWindowModel.shouldOpenQuickStartDialogOnStartUp()
            }

            RowLayout{
                Layout.alignment: Qt.AlignRight

                Button{
                    id: quick_start_back_button
                    text: "Back"
                    onClicked: {
                        quick_start_area.state_num -= 1
                        quick_start_area.state = "quick_start_" + quick_start_area.state_num
                    }
                }

                Button{
                    id: quick_start_next_button
                    text: "Next"
                    onClicked: {
                        quick_start_area.state_num += 1
                        quick_start_area.state = "quick_start_" + quick_start_area.state_num
                    }
                }

                Button{
                    text: "Close"
                    onClicked: {
                        root.close()
                    }
               }

            }
        }
    }
}

