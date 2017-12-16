import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2


Rectangle{
    id: root
    property bool showDetail: true

    color:"#222222"
    width: showDetail ? 320 : 32

    property string character_image: MainWindowModel.characterImageUrl()
    property string library_description: MainWindowModel.libraryDescription()
    property string library_name: MainWindowModel.libraryName()

    Connections{
        target: MainWindowModel
        onLibraryInformationUpdated: {
            root.library_description = MainWindowModel.libraryDescription()
            root.character_image = MainWindowModel.characterImageUrl()
            root.library_name = MainWindowModel.libraryName()
        }
    }

    ColumnLayout{
        anchors.fill:parent
        Image{
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            source:"qrc:/image/expand_less.png"

            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }
        }

        Image{
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
            WButtonMouseArea{
                anchors.fill: parent
                onClicked: {
                    vocalOpenDialog.open()
                }
            }
        }

        Text{
            id: vocal_name
            visible: showDetail
            Layout.alignment: Qt.AlignCenter
            text: root.library_name
            font.pointSize: 14
            Layout.preferredHeight: 50
            color: "#ffffff"
            font.family: "Meiryo"
        }

        Item{
            id: vocal
            visible: showDetail
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 350
            Layout.preferredWidth: 200
            Image{
                id: vocal_image
                fillMode: Image.PreserveAspectFit
                visible: showDetail
                anchors.fill: parent
                source: root.character_image
                smooth: true
            }

            DropShadow {
                anchors.fill: vocal_image
                visible: showDetail
                horizontalOffset: -20
                verticalOffset: 0
                radius: 4.0
                samples: 9
                color: "#000000"
                source: vocal_image
            }
        }

        Rectangle{
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 200
            Layout.preferredWidth: parent.width
            color:"#222222"
            visible: showDetail

            TextArea{
                visible: showDetail
                anchors.fill:parent
                anchors.margins: 10
                text: root.library_description
                textColor: "#ffffff"
                backgroundVisible:false
                readOnly: true
            }
        }
    }
}
