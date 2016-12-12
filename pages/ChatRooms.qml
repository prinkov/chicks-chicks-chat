import QtQuick 2.0
import QtQuick.Controls 2.0

import "../js/System.js" as System
import "../js/Client.js" as Client
import "../template"

import xyz.prinkov 1.0

Rectangle {
    id: chatRooms

    property var model: ListModel{}
    property int lastId: -1
    property int lastIndex: 0

    Timer {
        id: timer
        interval: 3000
        running: false
        repeat: true
        onTriggered: {
            Client.getRooms()
        }
    }

    Component.onCompleted: {
        Client.getRooms()
        timer.start()
    }

    Rectangle {
        id: roof
        color: "#FF00FF"
        z:1
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        Text {
            id: title
            color: "white"
            text: "Выбор комнаты"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: System.getPointSize(12)


        }


        anchors.margins: 0
        height: System.getHeight(40)
    }

    ListView {
        id: list
        model: chatRooms.model
        delegate : ChatRoomDelegate{
        }
        anchors {
            top: roof.bottom
            bottom: bot.top
            right: parent.right
            left: parent.left
        }
        anchors.margins: 0
    }

    Rectangle {
        id: bot
        color: "transparent"
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        anchors.margins: 0
        height: System.getHeight(70)

        MenuButton {
            width: parent.width / 3
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 0
            onClick: {
                stack.push(Qt.resolvedUrl("qrc:/pages/AddRoom.qml"))
            }
            source: "qrc:/img/add.png"
        }

        MenuButton {
            width: parent.width / 3
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 3
            source: "qrc:/img/icon.png"
        }

        MenuButton {
            width: parent.width / 3
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 0
            source: "qrc:/img/exit.png"
            onClick: {
                stack.pop()
                User.nickname = ""
            }
        }

    }
}
