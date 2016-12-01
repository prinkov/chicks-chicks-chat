import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtQml 2.2
import "../template"
import "qrc:/js/System.js" as System
/*
  Страница входа.
*/

Item {
    property string title: "Логин"
    property bool flag: false

    // Главная область
    Rectangle {
        id: frame
        anchors.fill: parent
        color: "#00000000"

        // Логотип
        Image {
            id: logo
            height: 100
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top

            anchors.topMargin: 20
            anchors.right: parent.right

            anchors.rightMargin: 20
            anchors.left: parent.left

            anchors.leftMargin: 20
            source: "qrc:/img/logo.png"
        }

        // Поле ввода номера телефона
        ChiksTextField {
            id: nickname

//            typeInput: "mobil"
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

        // Поле ввода пароля
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

            //  Кнопка входа
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

            // Текстовая подсказка
             Text {
                id: forgotPswdText
                font.pixelSize: System.getHeight(12)
                font.family: mainFont.name
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
//                color: "#ffffff"
                text: qsTr("Восстановить пароль")
                anchors.bottom: rect.bottom
                anchors.bottomMargin: 20
                anchors.left: rect.left
                anchors.leftMargin: 0
                anchors.right: rect.right
                anchors.rightMargin: 0
//                textColor: "#0038a5"
//                border: true
            }
        }
    }

    Component.onCompleted: {
        System.screenWidth = Screen.width
        System.screenHeight = Screen.height
    }

    function login(login, password) {
        var request = new XMLHttpRequest()
        request.open("POST", "http://localhost/login.php")
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        var param = "login=" + login+"&passwd=" + password
        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    if(request.responseText == "1")
                        loginResolve()
                    else
                       loginError()
                } else {
                    view.yaPosition = "interten connection error"
                }
            }
        }
        request.send(param)
    }

    function loginResolve(message) {
        stack.push(Qt.resolvedUrl("qrc:/pages/Chat.qml"))
    }

    function loginError(error) {

        msgErr.visible = true
        msgErr.messageText = User.getLastErrorString()
    }

    ChiksWindow {
        id: msgErr
        twoButtons: false
        titleText: qsTr("Ошибка входа")
        messageText: "Неверный логин/пароль"
    }
}
