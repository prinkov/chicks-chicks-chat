import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
// Страница авторизации
Rectangle {
    id: root
//    anchors.fill:parent

    Rectangle {
        id: roof
        color : "#0038a5"
        width : parent.width
        height: 40
        visible:true

        // верхнее меню
        TabBar {
            currentIndex: swipeView.currentIndex
            id: tabBar
            anchors.fill: parent
            TabButton {

                text: qsTr("Вход")
            }

            TabButton {
                text: qsTr("Регистрация")
            }
        }
    }

    Rectangle {
        id: mainArea
        color: "#ffffff"
        anchors.top: roof.bottom
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        SwipeView {
            id: swipeView
            anchors.fill: parent
            currentIndex: tabBar.currentIndex

            Login {
            }

            Register{
            }
        }
    }
}
