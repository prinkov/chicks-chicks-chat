import QtQuick 2.0
import QtQuick.Controls 2.0

import "../js/System.js" as System
import xyz.prinkov 1.0

Component {
    id: listRooms
        Rectangle {
            id: main
            signal click();
            onClick: {
                User.roomId = model.uid;
                stack.push(Qt.resolvedUrl("qrc:/pages/Chat.qml"))
            }
            width: parent.width
            height: lbl.height + 20

            Label {
                id: lbl
                width: parent.width
                font.pointSize: System.getPointSize(18)
                anchors {
                    left: parent.left
                    right: people.left
                }

                anchors {
                    leftMargin: 40
                    rightMargin: 10
                }

                anchors.verticalCenter: parent.verticalCenter
                text: label
                wrapMode: Text.WordWrap
            }

            Image {
                id: next
                antialiasing: true
                fillMode: Image.PreserveAspectFit
                height: System.getHeight(25)
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        main.click()
                    }
                }
                source: "qrc:/img/next.png"
            }

            Rectangle {
                id: people
                border.color: "#ff00ff"
                width : count.width + 20
                height: count.height + 10
                radius: 0.5 * width
                antialiasing: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: next.left
                anchors.rightMargin: 5
                Text {
                    id: count
                    text: model.people
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        main.click()
                    }
                }
            }



            Rectangle {
                id: botLine
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                opacity: 0.8
                anchors.margins: System.getWidth(20)
                anchors.bottomMargin: 0
                height: System.getHeight(1)
                color: "#B25AE5"
            }
        }
}
