import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0

import QtGraphicalEffects 1.0

import xyz.prinkov 1.0

import "qrc:/js/Client.js" as Client
import "../js/System.js" as System
import "../objects"

import "../template"

Rectangle{

    id: chat
    property int msgLastId:-1
    property var  mod: ListModel{
//        ListElement {text1: "hello world 3"; author:"Semen"; time :"20:50"}
    property int lastId:0
    }

    Sender{
        id: sender
        onOnAnswer: {
            console.log(value)
            Client.post('<a href=\"' + value+ '\">Файл</a>', qsTr(User.nickname))
        }
    }

    Component.onCompleted: {
        Client.get(msgLastId)
        sender.setUrl("http://localhost/sendfile.php")

    }

    function setMsgLastId(i) {
       msgLastId = i
    }

    function sendMessage() {
        if(messageText.text.replace(/\s+/g, '')!="") {
            Client.post(qsTr(messageText.text), qsTr(User.nickname))
        }
        messageText.text = ""
    }

    Timer {
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            Client.get(msgLastId)
        }
    }

    FileDialog {
        id: fileDialog
        title: "Выбирите файл для отправки"
        folder: shortcuts.home
        onAccepted: {
            sender.sendImage(fileDialog.fileUrls)
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    Rectangle {
        id: roof
        color: "#FF00FF"
        width: parent.width
        height: System.getHeight(40)
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        z: 1
            Button {
            id: backBtn
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 2 * parent.width / 3
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            background : Image {
                id: backBtnBck
                source: "qrc:/img/drawer.png"
                antialiasing: true
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 10
                height: parent.height
                width: parent.width / 4
                            opacity: 0.6
                anchors.verticalCenter: parent.verticalCenter
            }
            onClicked: {
                animationBack.restart()
            }

            OpacityAnimator {
                  id: animationBack
                  target: backBtnBck
                  from: 1
                  to: 0.6
                  duration: 1000
                  running: false
              }
        }

        Button {
            id: nextBtn
            anchors.left: parent.left
            anchors.leftMargin: 2 * parent.width / 3
            anchors.right: parent.right
            anchors.rightMargin:  0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            text: ""
            background : Image {
                id: nextBtnBck
                source: "qrc:/img/exit.png"
                antialiasing: true
                fillMode: Image.PreserveAspectFit
                anchors.right: parent.right
                anchors.rightMargin: 10
                height: parent.height
                width: parent.width / 4
                            opacity: 0.6
                anchors.verticalCenter: parent.verticalCenter
            }
            onClicked:{
                    animationNext.restart()
                    User.nickname = ""
                    stack.pop()
            }
            OpacityAnimator {
                  id: animationNext
                  target: nextBtnBck
                  from: 1
                  to: 0.6
                  duration: 1000
                  running: false
              }
        }

        ChiksButton {
            id: title
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 3
            anchors.right: parent.right
            anchors.rightMargin:  parent.width / 3
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            text: User.nickname
        }
    }
    ListView {
        id: list
        anchors.top: roof.bottom
        anchors.topMargin: 0
        anchors.bottom: msgRect.top
        anchors.bottomMargin: 0
        width: parent.width

        cacheBuffer: 100

        spacing: 10
        model: mod

        onDragEnded: {
            if(list.contentY < -50 && mod.get(0).id > 0) {
                Client.update(mod.get(0).id)
            }
        }

        delegate : ItemDelegate {
            property bool me: author == User.nickname
            id: dlg
            height: txt.height + 40
            width :parent.width
            Text {
                id: txt
                anchors.left: parent.left
                anchors.leftMargin: me ? 70 : 15
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.right: parent.right
                anchors.rightMargin:me ? 15 : 70
                text:  text1
                wrapMode: Text.WordWrap
                onLinkActivated: Qt.openUrlExternally(link)
                z: 0
                Rectangle {
                    Text {
                        id: authorText
                        text: author
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.left: parent.left
                        color: "gray"
                        anchors.leftMargin: 7
                    }

                    Rectangle {
                        color: !me ? "blue" : "#ff00ff"
                        height: 1
                        anchors.top: authorText.bottom
                        anchors.topMargin: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                    }
                    opacity: 1
                    z: -1
                    anchors.left: parent.left
                    anchors.leftMargin: me ? -20 : -10
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: -25
                    anchors.rightMargin: me ? -10 : -20
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    height: txt.height + 30
                    width: txt.width
                    border.color: !me ? "blue" : "#ff00ff"
                    radius: 12
                    border.width: 1
                    Text {
                        text: time
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.right: parent.right
                        color: "gray"
                        anchors.rightMargin: 5
                    }
                }
            }
        }
}

    Rectangle {
        id: msgRect
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        z: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        border.width: 2
        border.color: messageText.focus ? "#FF00FF" : "gray"
        height: 100
        color: "white"
        radius: 5
        Flickable {
            id: flickable
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            anchors.leftMargin: 0
            anchors.rightMargin: 60
            anchors.topMargin: 0
            anchors.bottomMargin: 0

            TextArea.flickable: TextArea {
                id: messageText
                placeholderText: "Введите сообщение"
                wrapMode: TextArea.Wrap
                Keys.onPressed: {
                      if(event.modifiers && Qt.ControlModifier) {
                          if(event.key === Qt.Key_Return) {
                              sendMessage()
                          }
                      }
                }

            }

            ScrollBar.vertical: ScrollBar { }
            ScrollIndicator.vertical: ScrollIndicator {}

        }
        Rectangle {
            color: "transparent"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            anchors.leftMargin: parent.width - 60
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            Button {
                id: send
                anchors.top: parent.top
                anchors.topMargin: 0
                width: parent.width
                height: parent.height/2

                onClicked: {
                    sendMessage()
                }

                background: Image {
                    id: sendBck
                    anchors.fill: parent
                    scale: 0.8
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit

                    source: "qrc:/img/send.png"
                    ColorOverlay {
                            anchors.fill: sendBck
                            source: sendBck
                            color: "#FF00FF"
                            visible:{
                                return messageText.text.length!=0
                            }
                        }
                }
            }

            Button {
                id: sendFile
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                width: parent.width
                height: parent.height / 2
                background: Image {
                    id: sendFileBck
                    anchors.fill: parent
                    scale: 0.8
                    antialiasing: true
                    source: "qrc:/img/file.png"
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    fileDialog.open()
                }

            }

        }
    }
}
