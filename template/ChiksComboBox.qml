import QtQuick 2.6
import QtQuick.Controls 2.0
import "qrc:/js/System.js" as System

Item {

    id: root
    width: System.getWidth(35)
    height: System.getHeight(35)

    property double scaleImg: 1
    property bool hasIcon: true

    property string hoverIcon: qsTr("")
    property string defText: qsTr("")
    property string defaultIcon: qsTr("")

    property string hoverColor: "#0038a5"
    property string defaultColor: "#888888"

    property bool def: true

    property var comboModel: ListModel {}
    property var onChange: undefined

    property alias fieldFooterImage: fieldFooterImage
    property alias container2: container2

    property var bindStack: []

    /** Инициализация значения ComboBox */
    property var setValue: function(value) {
        bindStack.push(false)

        var item = null;
        // TODO ваще переписать, так никто не ищет
        for(var index = 0; index < root.comboModel.count; ++index) {
            item = root.comboModel.get(index);

            if(item['dataId'] === value) {
                field.currentIndex = index;
                return;
            }
        }
    }

    FontLoader {
        id: mainFont
        source: "qrc:/common/fonts/Roboto-Light.ttf"
    }

    Item {
        id: container
        anchors.left: parent.left
        anchors.leftMargin: 2
        width: System.getWidth(35)
        height: System.getHeight(35)
        visible: hasIcon

        Image {
            id: icon
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            scale: scaleImg
            antialiasing: true
            sourceSize.height: 40
            sourceSize.width: 40
            fillMode: Image.PreserveAspectFit
            source: field.activeFocus ? root.hoverIcon : root.defaultIcon
        }

        Rectangle {
            id: imageFooter
            height: 3
            color: field.activeFocus ? hoverColor : defaultColor
            width:  6 + icon.width * scaleImg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
        }
    }

    Rectangle {
        id:container2
        anchors.top: container.top
        anchors.topMargin: 0
        anchors.left: hasIcon  ?  container.right : parent.left
        anchors.leftMargin: hasIcon ?  20 * scaleImg : 0
        anchors.bottom: container.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        ComboBox {
            id: field
            model: root.comboModel
            currentIndex: -1

            onCurrentIndexChanged: {
                var sendData = bindStack.length === 0 || bindStack.pop()
                if(onChange && onChange instanceof Function) {
                    onChange(currentIndex, comboBoxFrame.idComboBox, sendData);
                }

                def = false
            }

            delegate: ItemDelegate {
                width: field.width

                text: modelData

                font.pointSize: System.getPointSize(14)
                font.weight: field.currentIndex === index ? Font.DemiBold : Font.Normal
            }

            indicator: Canvas {
                   id:indic
                   x:  field.width - width - field.rightPadding
                   y: field.topPadding + (field.availableHeight - height) / 2
                   width: System.getWidth(12)
                   height: System.getHeight(8)
                   contextType: "2d"
                   Connections {
                       target: field
                       onFocusChanged: indic.requestPaint()
                   }

                   onPaint: {
                       if(context) {
                           context.reset();
                           context.moveTo(0, 0);
                           context.lineTo(width, 0);
                           context.lineTo(width / 2, height);
                           context.closePath();
                           context.fillStyle = field.activeFocus ? "blue" : "gray";
                           context.fill();
                       }
                   }
               }

            background: Rectangle {
                anchors.fill: parent
                color: "#ffffff"
            }

            contentItem: Text {
                 leftPadding: 0
                 rightPadding: field.indicator.width + field.spacing
                 font.pointSize: System.getPointSize(14)
                 text: root.def ? defText : field.displayText
//                 font.family: mainFont.font
                 color: root.def ? "#bdbebf" : "black"
                 horizontalAlignment: Text.AlignLeft
                 verticalAlignment: Text.AlignVCenter
                 elide: Text.ElideRight

                 Component.onCompleted: {
                     if(mainFont.font) {
                         font.family = mainFont.font
                     }
                 }
           }

            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
        }

        Rectangle {
            id: fieldFooterImage

            color: field.activeFocus ? hoverColor : defaultColor
            height: 3
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
        }
    }
}
