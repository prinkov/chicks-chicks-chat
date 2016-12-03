import QtQuick 2.7
import QtQuick.Controls 2.0
import "qrc:/js/System.js" as System
/*
    Выпадающий список
  */
Item {
    width: System.getWidth(35)
    height: System.getHeight(35)
    id: root
    property double scaleImg: 1
    property string hoverIcon: qsTr("")
    property string defaultIcon: qsTr("")
    property string hoverColor: "#ff00ff"
    property string defaultColor: "#888888"
    property string placeholderText: ""
    property alias fieldFooterImage: fieldFooterImage
    property alias container2: container2
    property string typeInput: ""
    property var valid
    property bool hasIcon: true
    property int maxLength_: 40

    function getText() {
        return field.text;
    }

    property var onChange: undefined

    property var dataStack: []

    /** Инициализация значения поля */
    property var setValue: function (value) {
        dataStack.push(false)
        field.text = value;
    }



    property var inputMethod : {
        "mobil" : qsTr("+7 (000) 000 - 00 - 00;_"),
        "password": "",
        "wheel": qsTr("000/00R00;_"),
        "digit": qsTr(""),
        "vin": qsTr("")
    }
    property var inputKeyboard: {
           "mobil": Qt.ImhDigitsOnly,
           "password": Qt.ImhHiddenText,
           "wheel": Qt.ImhDigitsOnly,
           "digit": Qt.ImhDigitsOnly,
           "vin": Qt.ImhUppercaseOnly
    }

//    FontLoader {
//        id: mainFont
//        source: "qrc:/common/fonts/Roboto-Light.ttf"
//    }

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
            width: 6 + icon.width * scaleImg
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

        TextField {
            id: field
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            maximumLength: maxLength_
            font.pixelSize: System.getPointSize(16)
//            font.family: mainFont.name
            echoMode: (typeInput == "password") ? TextInput.Password  : TextInput.Normal

            placeholderText : root.placeholderText
            background: Rectangle {
                anchors.fill: parent
                color: "#ffffff"
                border.width: 0
            }

            Component.onCompleted: {
                if(valid) {
                    validator = valid
                }

                if(inputKeyboard [typeInput]) {
                    inputMethodHints = inputKeyboard [typeInput]
                }

                if(inputMethod [typeInput]) {
                    inputMask = inputMethod [typeInput]
                }
            }

            onTextChanged: {
                if(onChange) {
                    if(dataStack.length === 0 || dataStack.pop()) {
                        onChange(text, textFieldFrame.idTextField)
                    }
                }
            }
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
