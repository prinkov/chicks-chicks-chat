import QtQuick 2.0
import QtQuick.Controls 2.0

import "../js/System.js" as System
import "../js/Client.js" as Client

Rectangle {
    id: addRoom

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
            text: "Создание комнаты"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: System.getPointSize(16)
        }


        anchors.margins: 0
        height: System.getHeight(40)
    }

    Text {
        anchors {
            bottom: nameRoom.top
        }
        font.pointSize: System.getPointSize(12)
        anchors.margins: 10

        text: "Введите название комнаты"
        anchors.horizontalCenter: parent.horizontalCenter

    }

    TextField {
        id: nameRoom
        anchors {
            left: parent.left
            right: parent.right
        }
        anchors.margins: 20
        font.pointSize: System.getPointSize(18)
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        anchors.top: nameRoom.bottom
        anchors.topMargin: 10
        height: System.getHeight(50)
        width: System.getHeight(50)
        enabled: nameRoom.text != ""
        onClicked: {
            Client.createRoom(nameRoom.text)
        }
        anchors.horizontalCenter: parent.horizontalCenter
        background: Image {
            source: nameRoom.text == "" ? "qrc:/img/okDef.png" : "qrc:/img/ok.png"
            anchors.fill: parent
            antialiasing: true
        }
    }
}
