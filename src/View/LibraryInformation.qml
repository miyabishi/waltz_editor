import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2


Rectangle{
    id: library_information
    color:"#222222"

    property string character_image: MainWindowModel.characterImageUrl()
    property string library_description: MainWindowModel.libraryDescription()
    property string library_name: MainWindowModel.libraryName()

    Connections{
        target: MainWindowModel
        onLibraryInformationUpdated: {
            library_information.library_description = MainWindowModel.libraryDescription()
            library_information.character_image = MainWindowModel.characterImageUrl()
            library_information.library_name = MainWindowModel.libraryName()
        }
    }

    ColumnLayout{
        anchors.fill:parent
        Image{
            z:0
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            source:"qrc:/image/open.png"
            FileDialog{
                id:vocalOpenDialog
                nameFilters: ["Vocal File(*." + MainWindowModel.vocalFileExtention() + ")"]
                selectMultiple: false
                onAccepted: {
                    MainWindowModel.loadVoiceLibrary(vocalOpenDialog.fileUrl)
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    vocalOpenDialog.open()
                }
            }
        }

        Text{
            id: vocal_name
            z:0
            Layout.alignment: Qt.AlignCenter
            text: library_information.library_name
            font.pointSize: 14
            Layout.preferredHeight: 50
            color: "#ffffff"
            font.family: "Meiryo"
        }

        Item{
            z:0
            id: vocal
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 350
            Layout.preferredWidth: 200
            Image{
                id: vocal_image
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                source: library_information.character_image
                smooth: true
                visible: false
            }

            DropShadow {
                anchors.fill: vocal_image
                horizontalOffset: -20
                verticalOffset: 0
                radius: 4.0
                samples: 9
                color: "#000000"
                source: vocal_image
            }
        }

        Rectangle{
            z:0
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 200
            Layout.preferredWidth: parent.width
            color:"#222222"

            TextArea{
                anchors.fill:parent
                anchors.margins: 10
                text: library_information.library_description
                textColor: "#ffffff"
                backgroundVisible:false
                readOnly: true
            }
        }
    }
}
