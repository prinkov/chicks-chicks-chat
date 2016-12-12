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
    property var fileLoad
    property var  mod: ListModel{
    }

    Image {
        id: pashalka
        source: "qrc:/img/pas.png"
        width: System.getHeight(120)
        height: System.getWidth(120)
        z: 100
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        SequentialAnimation on y {
            id: yAnim
            running: false
            NumberAnimation { from: y -100; to: y + chat.height/2; duration: 3600; easing.type: Easing.InOutQuad }
            NumberAnimation { from: y + chat.height / 2; to: y - 200; duration: 3600; easing.type: Easing.InOutQuad }
        }

        SequentialAnimation on rotation {
            id: rotAnim
            running: false
            loops: Animation.Infinite
            NumberAnimation { from: -10; to: 10; duration: 900; easing.type: Easing.InOutSine }
            NumberAnimation { from: 10; to: -10; duration: 900; easing.type: Easing.InOutSine }
        }

    }

    Sender{
        id: sender
        onOnAnswer: {
            if(value == "-1")
                var error = rootWindow.createError("Ошибка", "К сожалению файл не загружен, попробуйте еще раз")
            else
                Client.post('<a href=\"' + value+ '\" >Файл</a>', qsTr(User.nickname), User.roomId)
            chat.fileLoad.visible = false
        }
    }

    Component.onCompleted: {
        loadMsg.visible = true
        Client.get(msgLastId, User.roomId)
        Client.iOnline(User.nickname, User.roomId)
        sender.setUrl(System.server + "/sendfile.php")
        timer.start()
    }

    function setMsgLastId(i) {
       msgLastId = i
       list.currentIndex = mod.count - 1
    }

    function sendMessage() {
        if(messageText.text == "Автоматическая оценка") {
            pashalka.visible = true
            yAnim.running = true
            rotAnim.running = true
        }
        if(messageText.text.replace(/\s+/g, '')!="") {
            Client.post(qsTr(messageText.text), qsTr(User.nickname), User.roomId)
        }
        messageText.text = ""
    }

    Timer {
        id: timer
        interval: 100
        repeat: true
        running: false
        onTriggered: {
            Client.get(msgLastId, User.roomId)
            Client.iOnline(User.nickname, User.roomId)
        }
    }


    BusyIndicator {
        id: loadMsg
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        height: System.getHeight(100)
        visible: false
        z: 2
        ColorOverlay {
            source: loadMsg
            anchors.fill: parent
            color: "#FF00FF"
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
        anchors.top: loadMsg.visible ? loadMsg.bottom : roof.bottom
        anchors.topMargin: 0
        anchors.bottom: msgRect.top
        anchors.bottomMargin: 0
        width: parent.width

        cacheBuffer: 100

        spacing: 10
        model: mod
        currentIndex: mod.count - 1
        onDragEnded: {
            if(list.contentY < -50 && mod.get(0).id > 0) {
                loadMsg.visible = true
                Client.update(mod.get(0).id, User.roomId)
                currentIndex = 0
            }
        }

        delegate : ItemDelegate {
            property bool me: author == User.nickname
            id: dlg
            height: txt.height + 40
            width : list.width
            Text {
                id: txt
                anchors.left: parent.left
                anchors.leftMargin: me ? 70 : 15
                anchors.top: parent.top
                anchors.topMargin: 30
                font.pointSize: System.getPointSize(14)
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
        height: System.getHeight(100)
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
                    source:  messageText.text.length!=0 ? "qrc:/img/sendHover.png" :"qrc:/img/send.png"
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
                    var fileDialog = Qt.createQmlObject("FileSelector { id: fileDialog; visible: true; z: 10}", chat, "fileDialog");
                    fileDialog.select.connect(function(){
                        sender.sendImage(fileDialog.path)
                        chat.fileLoad = rootWindow.chiksLoading("загрузка файла")
                        fileDialog.destroy()
                    })
                    fileDialog.rejected.connect(function(){
                        fileDialog.destroy()
                    })
                }
            }

        }
    }
}
