import QtQuick 2.1
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.1
 import QtQuick.Dialogs 1.2
Rectangle {
    id: fileSelector
    anchors.fill: parent
    color: "black"
//    opacity: 0.5
    signal select();
    signal rejected();
    property string path

    function open() {
        fileSelector.visible  = true
    }

    Rectangle {
        id: title
        opacity: 0.7
        height: titleLabel.height + 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.rightMargin: parent.width / 2 - 30
        anchors.leftMargin: 20
        anchors.bottomMargin: 30
        color: backMA.pressed ? "gray" : "black"
        border.color: Qt.lighter("#67b0d1")

        MouseArea {
            id: backMA
            anchors.fill: parent
            onClicked: {
                var str = folderList.folder.toString()
                folderList.folder = str.substring(0, str.lastIndexOf("/"))
                console.log(folderList.folder)
            }
        }
        Text {
            id: titleLabel
            text: "Назад"
            color: "white"
            font.bold: true
            font.pointSize: 15
            anchors.centerIn: parent
        }
    }


    Rectangle {
        id: exit
        opacity: 0.7
        height: titleLabel.height + 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.rightMargin: 20
        anchors.leftMargin: parent.width / 2 + 30
        anchors.bottomMargin: 30
        color: backE.pressed ? "gray" : "black"
        border.color: Qt.lighter("#67b0d1")

        MouseArea {
            id: backE
            anchors.fill: parent
            onClicked: {
                fileSelector.visible = false
                rejected()
            }
        }
        Text {
            id: titleExit
            text: "Выход"
            color: "white"
            font.bold: true
            font.pointSize: 15
            anchors.centerIn: parent
        }
    }

    ListView {
        id: listView
        clip: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: title.bottom
        anchors.topMargin: 0
        anchors.margins: 20
        spacing: 5
        add: Transition {
            NumberAnimation { properties: "x"; from: 1000; duration: 500 }
        }
        FileDialog{
            Component.onCompleted: {
                console.log(shortcuts.home)
            }
        }
        model: FolderListModel {
            id: folderList
            showDirs: true
            folder: "file:///home/akaroot"
            showHidden: false
        }

        delegate: Rectangle {
            opacity: 1
            height: label.height + 50
            width: listView.width + 2
            x: -1
            border.color: Qt.lighter("#67b0d1")
            border.width: 1
            color: mArea.pressed ? "#ff00ff" : "#ee00ee"
            Image {
                id: picture
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height-10
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                scale: 0.8
                z:1
                source: !model.fileIsDir ? "qrc:/img/fileHover.png" : "qrc:/img/folder.png"
            }

            Text {
                id: label
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.margins: 10
                anchors.left: picture.right
                text: model.fileName

                color: "white"
                wrapMode: Text.WordWrap
            }
            MouseArea {
                id: mArea
                anchors.fill: parent
                onClicked: {
                    path = model.fileURL
                    if(fileIsDir)
                        folderList.folder = path
                    else {
                        select()
                        fileSelector.visible = false
                    }
                }
            }
        }
    }
}
