import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import "./pages"

import xyz.prinkov 1.0

ApplicationWindow {
    visible: true
    property bool debug : true
    id: rootWindow
    width: debug ? 320 : Screen.width
    height: debug ? 640 : Screen.height

    title: qsTr("Chicks-chicks")
    StackView {
        id: stack
        anchors.fill: parent
        initialItem: IndexLogin{}
    }
    Component.onCompleted: {
        User.nickname = ""
    }
}
