import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.4

import "qrc:/js/System.js" as System

import "../template"

Item {
    property var load
    property alias acceptRegText: acceptRegText
    property var msgErr
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
            text: qsTr("")
            visible: true
            textFormat: Text.PlainText
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            color: "blue"
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
                    msgErr = rootWindow.createError("Ошибка", "Заполните все поля")
                } else if(pass1.getText() == pass2.getText())
                    register(nickname.getText(), pass1.getText())
                else {
                    msgErr = rootWindow.createError("Ошибка", "Введенные пароли не совпадают")

                }
            }
        }
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
        load = rootWindow.loading()
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

    function connectError() {
        load.stop()
        msgErr = rootWindow.createError("Ошибка", "Проверьте интернет соединение")
    }

    function registerResolve() {
        load.stop()
        msgErr = rootWindow.createError("", "Регистрация пройдена, теперь пройдите авторизацию")

    }

    function registerError() {
        load.stop()
        msgErr.messageText = rootWindow.createError("Произошла ошибка",
                                                    "Введенный вами ник уже зарегистрирован в системе. Попробуйте восстановить пароль")
    }

}


