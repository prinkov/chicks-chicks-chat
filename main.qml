import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "./pages"
ApplicationWindow {
    visible: true
    id: rootWindow
    width: 360
    height: 640
    title: qsTr("Chiks-chiks")
    StackView {
        id: stack
        anchors.fill: parent
        initialItem: IndexLogin{}
    }
}
