import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageMoveDetails

    property int moveId: 1
    property string learnMethodName
    property string learnMethodDescription
    property int learnLevel: 1
    property string name
    property string gameDescription
    property string detailedDescription
    property int power
    property int pp
    property int accuracy
    property int priority
    property int effectChance
    property int damageClass: 1
    property int target: 1
    property int type: 1
    property int contestType: 1
    property int contestEffect: 1
    property int superContestEffect: 1
    property int generation: 1

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (moveId > 0) {
                name = modelMoves.getMoveData(moveId, Backend.ModelMoves.NameRole)
                gameDescription = modelMoves.getMoveData(moveId, Backend.ModelMoves.FlavorTextRole)
                detailedDescription = modelMoves.getMoveData(moveId, Backend.ModelMoves.DetailedEffectRole)
                // The learn method name and description is (luckily) not needed to be translated because it's only available in english
            }
        }
    }

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height

        contentHeight: labelName.height + rectangleSeparator.height + typeTag.height + rectangleParameters.height + rectangleLearnMethod.height + rectangleGameDescription.height + rectangleDetailedDescription.height + 90

        Label {
            id: labelName

            y: 12
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: Qt.application.font.pointSize * 1.2
            font.bold: true
            elide: Text.ElideRight
            text: pageMoveDetails.name
            textFormat: Text.PlainText
        }

        RectangleSeparator {
            id: rectangleSeparator
            y: labelName.y + labelName.height + 5
        }

        TypeTag {
            id: typeTag

            x: (parent.width - width)/2
            y: rectangleSeparator.y + rectangleSeparator.height + 5

            type: pageMoveDetails.type
            source: "qrc:/images/types/types/tags/" + type + ".svg"
        }

        Rectangle {
            id: rectangleParameters

            x: 12
            y: typeTag.y + typeTag.height + 5
            width: parent.width - 2*x
            height: _labelParameters.height + rectangleDamageClass.height + moveAttributePower.height + moveAttributeAccuracy.height + moveAttributePp.height + moveAttributePriority.height + 50

            color: pageMoveDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelParameters

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Parameters")
                font.bold: true
                textFormat: Text.PlainText
            }

            Rectangle {
                id: rectangleDamageClass

                readonly property var damageClassNames: [ qsTr("None"), qsTr("Status"), qsTr("Physical"), qsTr("Special") ]

                x: (parent.width - width)/2
                y: _labelParameters.y + _labelParameters.height + 6
                width: 180
                height: 20

                radius: 4
                color: labelDamageClass.Material.accentColor

                Label {
                    id: labelDamageClass

                    x: (parent.width - width)/2
                    y: (parent.height - height)/2

                    text: rectangleDamageClass.damageClassNames[pageMoveDetails.damageClass]
                    color: Material.dialogColor
                    Material.accent: [ "transparent", Material.Grey, Material.Red, Material.Indigo ][pageMoveDetails.damageClass]
                    textFormat: Text.PlainText
                }
            }

            MoveAttribute {
                id: moveAttributePower

                x: (parent.width - width)/2
                y: rectangleDamageClass.y + rectangleDamageClass.height + 5
                width: rectangleDamageClass.width
                height: rectangleDamageClass.height

                radius: 4
                border.color: rectangleDamageClass.color
                color: "transparent"
                nameWidth: width * 0.75
                attributeName: qsTr("Power")
                attributeValue: pageMoveDetails.power ? pageMoveDetails.power : "-"
                iconSource: "qrc:/images/icons/actions/bars.svg"
            }

            MoveAttribute {
                id: moveAttributeAccuracy

                x: (parent.width - width)/2
                y: moveAttributePower.y + moveAttributePower.height + 5
                width: rectangleDamageClass.width
                height: rectangleDamageClass.height

                radius: 4
                border.color: rectangleDamageClass.color
                color: "transparent"
                nameWidth: width * 0.75
                attributeName: qsTr("Accuracy")
                attributeValue: pageMoveDetails.accuracy ? pageMoveDetails.accuracy : "-"
                iconSource: "qrc:/images/icons/actions/aim.svg"
            }

            MoveAttribute {
                id: moveAttributePp

                x: (parent.width - width)/2
                y: moveAttributeAccuracy.y + moveAttributeAccuracy.height + 5
                width: rectangleDamageClass.width
                height: rectangleDamageClass.height

                radius: 4
                border.color: rectangleDamageClass.color
                color: "transparent"
                nameWidth: width * 0.75
                attributeName: qsTr("PP")
                attributeValue: pageMoveDetails.pp ? pageMoveDetails.pp : "-"
                iconSource: "qrc:/images/icons/device/storage.svg"
            }

            MoveAttribute {
                id: moveAttributePriority

                x: (parent.width - width)/2
                y: moveAttributePp.y + moveAttributePp.height + 5
                width: rectangleDamageClass.width
                height: rectangleDamageClass.height

                radius: 4
                border.color: rectangleDamageClass.color
                color: "transparent"
                nameWidth: width * 0.75
                attributeName: qsTr("Priority")
                attributeValue: pageMoveDetails.priority ? pageMoveDetails.priority : "-"
                iconSource: "qrc:/images/icons/device/time.svg"
            }
        }

        // Learn method
        Rectangle {
            id: rectangleLearnMethod

            x: 12
            y: rectangleParameters.y + rectangleParameters.height + 12
            width: parent.width - 2*x
            height: visible ? (_labelLearnMethod.height + labelLearnMethodName.height + labelLearnMethodDescription.height + 25) : 0

            visible: pageMoveDetails.learnMethodName
            color: pageMoveDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelLearnMethod

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Learn method")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelLearnMethodName

                x: 6
                y: _labelLearnMethod.y + _labelLearnMethod.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageMoveDetails.learnMethodName + ':'
                font.italic: true
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
            }

            Label {
                id: labelLearnMethodDescription

                x: 6
                y: labelLearnMethodName.y + labelLearnMethodName.height
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageMoveDetails.learnMethodDescription
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
            }
        } // Rectangle (learn method)

        // Game description
        Rectangle {
            id: rectangleGameDescription

            x: 12
            y: rectangleLearnMethod.y + rectangleLearnMethod.height + (rectangleLearnMethod.visible ? 12 : 0)
            width: parent.width - 2*x
            height: _labelGameDescription.height + labelGameDescription.height + 20

            color: pageMoveDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelGameDescription

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Game description")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelGameDescription

                x: 6
                y: _labelGameDescription.y + _labelGameDescription.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageMoveDetails.gameDescription
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
            }
        } // Rectangle (game description)

        // Detailed description
        Rectangle {
            id: rectangleDetailedDescription

            x: 12
            y: rectangleGameDescription.y + rectangleGameDescription.height + 12
            width: parent.width - 2*x
            height: _labelDetailedDescription.height + labelDetailedDescription.height + 20

            color: pageMoveDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelDetailedDescription

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Detailed description")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailedDescription

                x: 6
                y: _labelDetailedDescription.y + _labelDetailedDescription.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageMoveDetails.detailedDescription
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
            }
        } // Rectangle (detailed description)

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // Flickable
}
