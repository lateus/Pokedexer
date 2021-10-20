import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.0

Rectangle {
    id: moveAttribute

    property alias attributeName: labelAttributeName.text
    property alias attributeValue: labelAttributeValue.text
    property alias iconSource: buttonAttributeSymbol.icon.source
    property alias nameWidth: rectanglePowerSymbol.width
    property color nameFillColor: border.color
    property color iconColor: labelAttributeName.color

    property alias interactive: itemDelegateBackground.enabled

    signal clicked()

    Rectangle {
        id: rectanglePowerSymbol
        height: parent.height
        width: 0.75*parent.width
        
        radius: parent.radius
        border.width: 0
        color: enabled ? nameFillColor : Material.hintTextColor
        
        Rectangle {
            x: parent.width - width
            width: parent.radius
            height: parent.height
            color: enabled ? parent.color : "transparent"
            border.width: 0
        }
        
        Button {
            id: buttonAttributeSymbol
            height: parent.height
            width: height

            padding: 0
            bottomInset: 0
            topInset: 0
            flat: true
            visible: iconSource
            icon.color: enabled ? moveAttribute.iconColor : Material.hintTextColor
            icon.width: width
            icon.height: height
            background: null
        }
        
        Label {
            id: labelAttributeName
            x: buttonAttributeSymbol.width + 8
            z: itemDelegateBackground.z + 1
            height: parent.height
            verticalAlignment: Text.AlignVCenter

            color: enabled ? Material.dialogColor : Material.hintTextColor
            font.bold: true
            font.pixelSize: height/2
        }
    } // Rectangle (symbol)
    
    Label {
        id: labelAttributeValue
        x: parent.width - width
        z: itemDelegateBackground.z + 1
        width: parent.width - x
        height: parent.height
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        
        rightPadding: 8
        font.bold: true
        font.pixelSize: height/2
    }

    ItemDelegate {
        id: itemDelegateBackground

        width: parent.width
        height: parent.height
        enabled: false

        layer.enabled: enabled
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: itemDelegateBackground.width
                height: itemDelegateBackground.height
                radius: moveAttribute.radius
            }
        }

        onClicked: {
            moveAttribute.clicked()
        }
    }
}
