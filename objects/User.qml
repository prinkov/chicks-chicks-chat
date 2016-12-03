pragma Singleton
import QtQuick 2.0

QtObject {
    property string nickname: "Hello"
    function helloWorld() {
        console.log("hello world")
    }
}
