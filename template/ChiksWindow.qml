import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

import "qrc:/js/System.js" as System

Item {
    property string bckgColor: "#000000"
    property string mainColor: "#ffffff"
    property string titleText: qsTr("Заголовок")
    property string messageText: qsTr("Сообщение")

    width: rootWindow.width
    height: rootWindow.height

    id: root
    z: 1
    visible: false

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: bckgColor
        opacity: 0.8

        MouseArea {
            id: area
            anchors.fill: background
            onClicked: {
                root.visible = false
            }
        }
    }

    Rectangle {

        MouseArea {
            id: area2
            anchors.fill: mainWindow
            onClicked: {
                root.opacity = 1
            }
        }

        id: mainWindow
        anchors.horizontalCenter: parent.horizontalCenter
        width: background.width - background.width / 5
        height: background.height - background.height / 3
        anchors.verticalCenter: parent.verticalCenter
        color: mainColor
        radius: height / 30
        opacity: 1

        Text {
            id: title
            font.pixelSize: (titleText != "") ?  System.getPointSize(18) :  System.getPointSize(14)
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 40
            text: (titleText != "") ? titleText : messageText
            visible: true
            clip: true
            textFormat: Text.PlainText
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            color: "#0038a5"
        }

        Text {
            id: message
            font.pointSize: System.getPointSize(14)
            anchors.top: title.bottom
            anchors.topMargin: 20

            anchors.right: parent.right
            anchors.rightMargin: 20

            anchors.left: parent.left
            anchors.leftMargin: 20
            visible: true
            clip: true
            textFormat: Text.PlainText
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            color: "#0038a5"
            text: (titleText != "") ? messageText : ""
        }

        RowLayout{
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 70
            anchors.right: parent.right
            anchors.rightMargin: 70
            spacing: 40

            ChiksButton {
                id: no
                text:  qsTr("OK")
                width: rootWindow.width / 3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0

                textColor: "#ffffff"
                border: true
                color:  "#0038a5"
                onClick:{
                    root.visible = false
                }
            }
        }
    }
}
