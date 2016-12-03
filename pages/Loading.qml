import QtQuick 2.7
import QtGraphicalEffects 1.0


Rectangle {
    anchors.fill: parent
    color: "white"

    Image {
        id: load
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 130
        height: 130

        source: "qrc:/img/load.png"

        ColorOverlay {
                    anchors.fill: load
                    source: load
                    color: "#FF00FF"

        }



        RotationAnimator on rotation{
               id: anim
               loops: Animation.Infinite
               target: load
               easing.type: Easing.InElastic
               easing.amplitude: 4.0;
                easing.period: 6

               from: 0
               to: 360
               duration: 3000
               running: false
           }
    }

    function start() {
        anim.start()
        visible = true
    }

    function stop() {
        anim.stop()
        visible = false
    }

}
