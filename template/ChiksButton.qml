import QtQuick 2.7
import "qrc:/js/System.js" as System
/*
  Кнопка
  */

Item {
    id: root
    width: System.getWidth(300)
    height: System.getHeight(50)

    property string text: qsTr("Entity")
    property string colorBlue: "#FF00FF"

    property color textColor: "#ffffff"
    property color borderColor: colorBlue
    property color color: colorBlue
    property bool border: false
    signal click();



    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: {
            root.click()
        }
    }

    Rectangle {
        id: frame
        color: root.color

        Text {
            id: label
            color: root.textColor
            text: root.text
            font.pointSize: System.getPointSize(13)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
        }

        anchors.fill: parent
        radius: height / 2
        border.width: root.border ? 1 : 0
        border.color: root.borderColor
    }
}
