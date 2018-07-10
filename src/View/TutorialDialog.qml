import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

Dialog {
    id:root

    ColumnLayout{
        Rectangle{
            state:"tutorial_1"
            states:[
                State{
                    PropertyChanges {
                        name:"tutorial_1"
                        target: object
                    }
                }
            ]
            RowLayout{
                Image{}
                Text{}
            }
        }

        RowLayout{
            Button{}
        }
    }
}
