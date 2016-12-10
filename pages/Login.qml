import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtQml 2.2
import "../template"
import "qrc:/js/System.js" as System
import "../objects"

import xyz.prinkov 1.0

Item {
    property string title: "Логин"
    property bool flag: false
    property var load
    property var msgErr

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

        ChiksTextField {
            id: nickname

            anchors.top: logo.bottom
            anchors.topMargin: 15

            anchors.right: parent.right
            anchors.rightMargin: 20

            anchors.left: parent.left
            anchors.leftMargin: 20

            placeholderText: qsTr("Ник")

            hoverIcon: "qrc:/img/login.png"
            defaultIcon: "qrc:/img/login.png"
        }

        ChiksTextField {
            id: pass

            typeInput: "password"
            anchors.top: nickname.bottom
            anchors.topMargin: 15

            anchors.right: parent.right
            anchors.rightMargin: 20

            anchors.left: parent.left
            anchors.leftMargin: 20

            placeholderText: qsTr("Пароль")

            hoverIcon: "qrc:/img/password_hover.png"
            defaultIcon: "qrc:/img/password_def.png"
        }

        Rectangle {
            id: rect
            anchors.top: pass.bottom
            anchors.topMargin: 100
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

            ChiksButton {
                id: submit

                anchors.bottom: forgotPswdText.top
                anchors.bottomMargin: 30

                anchors.right: parent.right
                anchors.rightMargin: 0

                anchors.left: parent.left
                anchors.leftMargin: 0

                text: qsTr("Войти")

                onClick: {
                        login(nickname.getText(), pass.getText())
                }
            }

             Text {
                id: forgotPswdText
                font.pixelSize: System.getHeight(12)
                anchors.verticalCenter: rect.verticalCenter
                anchors.horizontalCenter: rect.horizontalCenter
                text: qsTr("Забыли пароль?")
                visible: true
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: "blue"
            }


            ChiksButton {
                id: resetPass
                text: qsTr("Восстановить пароль")
                anchors.bottom: rect.bottom
                anchors.bottomMargin: 20
                anchors.left: rect.left
                anchors.leftMargin: 0
                anchors.right: rect.right
                anchors.rightMargin: 0
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

    function login(login, password) {
        load = rootWindow.loading()
        timeout.start()
        var request = new XMLHttpRequest()

        console.log(System.server + "/login.php")
        request.open("POST", System.server + "/login.php")
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        var param = "login=" + login+"&passwd=" + password
        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    if(request.responseText == "1")
                        loginResolve(login)
                    else if(request.responseText == "-1")
                       loginError()
                    timeout.stop()
                }
                else
                    connectError()
            }
        }
        request.send(param)
    }

    function loginResolve(login) {
        User.nickname = login
        stack.push(Qt.resolvedUrl("qrc:/pages/Chat.qml"))
        load.stop()

    }

    function loginError(error) {
        msgErr = rootWindow.createError("Ошибка", "Неверный логин/пароль")
        load.stop()
    }


    function connectError(error) {
        msgErr = rootWindow.createError("Ошибка", "Проверьте интернет соединение")
        load.stop()
    }

}
