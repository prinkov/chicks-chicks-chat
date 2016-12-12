import QtQuick 2.0

Rectangle {
    id: btn
    property string text
    property string source
    color: "#ff00ff"
    signal click();
    MouseArea {
        anchors.fill:parent
        onClicked: {
            btn.click()
        }
    }
    Image {
        source: btn.source
        height: 2 * btn.height / 3
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

}
