import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

import "../js/System.js" as System


Rectangle {
    property string text:""

    id: fileLoad
    visible: true

    anchors.fill: parent
    opacity: 0.8

    Text {
        id: info
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        text: fileLoad.text
    }

    BusyIndicator {

        anchors.top: info.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        height: System.getHeight(100)
        ColorOverlay {
            source: parent
            anchors.fill: parent
            color: "white"
        }
    }

    z: 3
    color: "black"
}
