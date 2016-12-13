import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import "./pages"
import "./template"

import xyz.prinkov 1.0

ApplicationWindow {
    id: rootWindow
    visible: true
    property bool debug : false
    property bool phoneEdition: false
    width: !phoneEdition ? 320 : Screen.width
    height: !phoneEdition ? 640 : Screen.height

    title: qsTr("Chicks-chicks")

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: IndexLogin{}

        pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }

        }
    Component.onCompleted: {
        User.nickname = ""
    }

    function createError(title, message) {
        var objStr = "import './template'; ChiksWindow{id: msgErr; visible: true; titleText:'"
                + title + "'; messageText: '" + message + "'; }"
        var msgErr = Qt.createQmlObject(objStr, rootWindow, "msgErr");
        msgErr.visibleChanged.connect(function(){
            msgErr.destroy()
        })
        return msgErr
    }

    function loading() {
        var load = Qt.createQmlObject("import './pages'; Loading{}", rootWindow, "load")
        load.start()
        load.visibleChanged.connect(function(){
            load.destroy()
        })
        return load
    }

    function chiksLoading(text) {
        var fileLoad = Qt.createQmlObject("import './template'; ChiksLoader{text:'" + text + "'}", rootWindow, "fileLoad")
        fileLoad.visibleChanged.connect(function() {
            fileLoad.destroy()
        })
        return fileLoad
    }

}
