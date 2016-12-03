import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0

import QtGraphicalEffects 1.0

import xyz.prinkov 1.0

import "../js/System.js" as System
import "../objects"

import "../template"

Rectangle{

    id: chat
    anchors.fill: parent

    FileDialog {
        id: fileDialog
        title: "Выбирите файл для отправки"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)

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
        currentIndex: mod.count-1
        spacing: 10
        model:  ListModel {
            id: mod
            ListElement {text1: "hello world"; type: "me"}
            ListElement {text1: "hello world 2"; type: "they"}
              ListElement {text1: "hello world 3";type: "me" }
                ListElement {text1: "hello o world 4 hello  o world 4 hello  o world 4 hello  o world 4 hello o world 4 hello o world 4 hello o world 4 hello o world 4 hello o world 4 hello o world 4 hello world 4 hello <a href='http://www.kde.org'>click here</a> world 4 hello world 4 hello world 4 hello world 4 hello world 4 hello world 4 hello world 4
hello world 4 hello world 4 hello world 4 hello world 4"; type:"me"}
                ListElement {text1: "hello o world 4 hello  o world 4 hello  o world 4 hello  o world 4 hello o world 4 hello o world 4 hello o world 4 hello o world 4 hello o world 4 hello o world 4 hello world 4 hello <a href='http://www.kde.org'>click here</a> world 4 hello world 4 hello world 4 hello world 4 hello world 4 hello world 4 hello world 4
hello world 4 hello world 4 hello world 4 hello world 4"; type:"they"}
                  ListElement {text1: "<img src='https://vk.com/images/emoji/D83DDE34.png'></img>"; type:"me"}
                    ListElement {text1: "hello world 6"; type:"they"}
        }
        delegate : ItemDelegate {
            property bool me: type == "me"
            id: dlg
            height: txt.height+20
            width :parent.width
            Text {
                id: txt
                anchors.left: parent.left
                anchors.leftMargin: me ? 70 : 15
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin:me ? 15 : 70
                text:  text1
                wrapMode: Text.WordWrap
                onLinkActivated: Qt.openUrlExternally(link)
                z: 0
                Rectangle {
                    opacity: 1
                    z: -1
                    anchors.left: parent.left
                    anchors.leftMargin: me ? -20 : -10
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: -5
                    anchors.rightMargin: me ? -10 : -20
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    height: txt.height + 30
                    width: txt.width
                    border.color: !me ? "blue" : "#ff00ff"
                    radius: 12
                    border.width: 1
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
                              if(messageText.text.replace(/\s+/g, '')!="")
                                  list.model.append({"text1":messageText.text, "type" :"me"})
                              messageText.text = ""
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
                    if(messageText.text.replace(/\s+/g, '')!="")
                        list.model.append({"text1": messageText.text, "type" :"me"})
                    messageText.text = ""
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
