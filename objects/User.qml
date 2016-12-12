pragma Singleton
import QtQuick 2.0

QtObject {
    property string nickname: "Hello"
    property string roomId: ""
    function printName() {
        console.log(nickname)
    }
}
