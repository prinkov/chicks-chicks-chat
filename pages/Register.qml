import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.4

import "qrc:/js/System.js" as System
/*
    Страница регистрации
*/

import "../template"

Item {
    property var load
    property alias acceptRegText: acceptRegText
    id: reg

    Rectangle {
        id: frame
        anchors.fill: parent
        color: "#00000000"

        Image {
            id: logo
            height: System.getHeight(100)
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            source: "qrc:/img/logo.png"
        }

        Text {
            id: acceptRegText
            font.pointSize: System.getPointSize(14)
            anchors.top: logo.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 40
//            font.family: mainFont.name
            text: qsTr("Мы рады видеть Вас в нашем чате")
            visible: true
            textFormat: Text.PlainText
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            color: "blue"
        }

        ChiksTextField {
            id: nickname
            anchors.top: acceptRegText.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
//            typeInput: "mobil"
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            placeholderText : qsTr("Ник")

            hoverIcon: "qrc:/img/login.png"
            defaultIcon: "qrc:/img/login.png"
        }

        ChiksTextField {
            id: pass1
            placeholderText : qsTr("Пароль")
            anchors.top: nickname.bottom
            typeInput: "password"

            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20

            hoverIcon: "qrc:/img/password_hover.png"
            defaultIcon: "qrc:/img/password_def.png"
        }

        ChiksTextField {
            id: pass2
            placeholderText : qsTr("Повторите пароль")
            typeInput: "password"
            anchors.top: pass1.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20

            hoverIcon: "qrc:/img/password_hover.png"
            defaultIcon: "qrc:/img/password_def.png"
        }

        Text {
            id: regMsg
            font.pointSize: System.getPointSize(14)
            anchors.top: pass2.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 40
//            font.family: mainFont.name
            text: qsTr("")
            visible: true
            textFormat: Text.PlainText
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            color: "blue"
        }

        ChiksWindow{
            id: msgErr
            titleText: qsTr("Произошла ошибка!")
            messageText: qsTr("Введенный вами ник уже зарегистрирован в системе. Восстановить пароль?")
        }


        ChiksButton {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            text : qsTr("Зарегистрироваться")
            y: 301
            onClick: {
                if(pass1.getText() == "" || nickname.getText() == "") {
                    msgErr.titleText = "Ошибка"
                    msgErr.messageText = "Заполните все поля"
                    msgErr.visible = true
                } else if(pass1.getText() == pass2.getText())
                    register(nickname.getText(), pass1.getText())
                else {
                    msgErr.titleText = "Ошибка"
                    msgErr.messageText = "Введенные пароли не совпадают"
                    msgErr.visible = true

                }
            }
        }
    }

    function loading() {
        var component = Qt.createComponent("qrc:/pages/Loading.qml");
        load = component.createObject(rootWindow);
        load.start()
    }

    Timer {
        id: timeout
        running: false
        repeat: false
        interval: 15000
        onTriggered: {
            connectError()
        }
    }

    function register(login, password) {
        loading()
        timeout.start()
        console.log(login)
        console.log(password)
        var request = new XMLHttpRequest()
        request.open("POST", System.server + "/register.php")
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        var param = "login=" + login+"&passwd=" + password
        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    if(request.responseText == "1")
                        registerResolve()
                    else
                       registerError()
                    timeout.stop()
                } else {
                    connectError()
                }
            }
        }
        request.send(param)
    }

    function connectError(error) {
        msgErr.messageText = "Проверьте интернет соединение"
        msgErr.visible = true
        load.stop()

    }

    function registerResolve() {
        load.visible = false
        msgErr.titleText = ""
        msgErr.messageText = "Регистрация пройдена, теперь пройдите авторизацию"
        msgErr.visible = true

    }

    function registerError() {
        load.visible = false
        msgErr.titleText = "Произошла ошибка!"
        msgErr.messageText = "Введенный вами ник уже зарегистрирован в системе. Попробуйте восстановить пароль"
        msgErr.visible = true

    }

}


