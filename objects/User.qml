pragma Singleton
import QtQuick 2.0

QtObject {
    property string nickname: "Hello"
    function printName() {
        console.log(nickname)
    }
}
