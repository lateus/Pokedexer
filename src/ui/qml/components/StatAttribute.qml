import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import QtGraphicalEffects 1.0

Item {
    id: statAttribute

    required property int maxValue
    required property int value

    property alias borderColor: rectangleRoot.border.color

    property alias attributeName: labelAttributeName.text
    property alias attributeNameColor: labelAttributeName.color
    property alias attributeNameWidth: labelAttributeName.width

    property alias attributeValueColor: labelAttributeValue.color

    implicitHeight: 20

    Rectangle {
        id: rectangleRoot

        readonly property real colorMargin: 20

        width: attributeNameWidth + colorMargin + (parent.width - attributeNameWidth - colorMargin) * (value/maxValue > 1 ? 1 : value/maxValue)
        height: parent.height
        radius: height/2
        border.color: Material.theme === Material.Light ? "#333333" : "#FFFFFF"
        color: "transparent"

        Label {
            id: labelAttributeName
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            leftPadding: 8
            rightPadding: 8
            elide: Text.ElideRight

            font.bold: true
            font.pixelSize: height/2
            textFormat: Text.PlainText
        }

        Rectangle {
            id: rectangleFillAttributeValue
            x: attributeNameWidth
            width: parent.width - x
            height: parent.height

            radius: parent.radius
            border.width: 0
            color: parent.border.color
            z: parent.z - 1

            Rectangle {
                width: parent.radius
                height: parent.height
                color: parent.color
                border.width: 0
            }
        } // Rectangle (symbol)

        LinearGradient {
            x: rectangleFillAttributeValue.x
            y: rectangleFillAttributeValue.y
            width: rectangleFillAttributeValue.width
            height: rectangleFillAttributeValue.height
            source: rectangleFillAttributeValue
            end: Qt.point(statAttribute.width - attributeNameWidth, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: applicationWindow.Material.theme === Material.Light ? "#F44336" : "#EF9A9A" }
                GradientStop { position: 0.5; color: applicationWindow.Material.theme === Material.Light ? "#4CAF50" : "#A5D6A7" }
                GradientStop { position: 0.7; color: applicationWindow.Material.theme === Material.Light ? "#4CAF50" : "#A5D6A7" }
                GradientStop { position: 1.0; color: applicationWindow.Material.theme === Material.Light ? "#2196F3" : "#90CAF9" }
            }
        }

        Label {
            id: labelAttributeValue
            x: parent.width - width
            height: parent.height
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter

            text: value
            rightPadding: 8
            font.bold: true
            font.pixelSize: height/2
            textFormat: Text.PlainText
        }
    }
}
