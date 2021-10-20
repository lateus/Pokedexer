import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageItemDetails

    property int itemId: 1
    property string name
    property string gameDescription
    property string detailedDescription
    property int flingPower
    property bool hasBigIcon

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (itemId > 0) {
                name = modelItems.getItemData(itemId, Backend.ModelItems.NameRole)
                gameDescription = modelItems.getItemData(itemId, Backend.ModelItems.FlavorTextRole)
                detailedDescription = modelItems.getItemData(itemId, Backend.ModelItems.DetailedEffectRole)
            }
        }
    }

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height

        contentHeight: labelName.height + rectangleSeparator.height + rectangleIcon.height + rectangleGameDescription.height + rectangleDetailedDescription.height + rectangleTechnicalDetails.height + 120

        Label {
            id: labelName

            y: 12
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: Qt.application.font.pointSize * 1.2
            font.bold: true
            elide: Text.ElideRight
            text: pageItemDetails.name
            textFormat: Text.PlainText
        }

        RectangleSeparator {
            id: rectangleSeparator
            y: labelName.y + labelName.height + 5
        }

        // Icon
        Rectangle {
            id: rectangleIcon

            x: (parent.width - width)/2
            y: rectangleSeparator.y + rectangleSeparator.height + 5
            width: 100
            height: width

            color: Material.dialogColor
            radius: width/2

            // Icon
            Image {
                id: imageTypeIcon

                x: (parent.width  - width)/2
                y: (parent.height - height)/2

                source: "qrc:/images/items/items-icons" + (pageItemDetails.hasBigIcon ? "-big/" : "/") + pageItemDetails.itemId + ".png"
            }
        }

        // Game description
        Rectangle {
            id: rectangleGameDescription

            x: 12
            y: rectangleIcon.y + rectangleIcon.height + 12
            width: parent.width - 2*x
            height: _labelDetailsGameDescription.height + labelDetailsGameDescription.height + 20

            color: pageItemDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelDetailsGameDescription

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Game description")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsGameDescription

                x: 6
                y: _labelDetailsGameDescription.y + _labelDetailsGameDescription.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                enabled: pageItemDetails.gameDescription
                text: pageItemDetails.gameDescription ? pageItemDetails.gameDescription : qsTr("Not available")
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
            height: _labelDetailsDetailedDescription.height + labelDetailsDetailedDescription.height + 20

            color: pageItemDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelDetailsDetailedDescription

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Detailed description")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsDetailedDescription

                x: 6
                y: _labelDetailsDetailedDescription.y + _labelDetailsDetailedDescription.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageItemDetails.detailedDescription ? pageItemDetails.detailedDescription : qsTr("Not available")
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
            }
        } // Rectangle (detailed description)

        Rectangle {
            y: _labelTechnicalDetails.y + _labelTechnicalDetails.height/2
            width: (parent.width - _labelTechnicalDetails.width)/2 - 6
            height: 1

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0;
                    color: "transparent";
                }
                GradientStop {
                    position: 1.0;
                    color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080";
                }
            }
        } // Rectangle

        Label {
            id: _labelTechnicalDetails

            x: (parent.width - width)/2
            y: rectangleDetailedDescription.y + rectangleDetailedDescription.height + 12

            text: qsTr("Technical details")
            font.bold: true
            textFormat: Text.PlainText
        }

        Rectangle {
            x: (parent.width + _labelTechnicalDetails.width)/2 + 6
            y: _labelTechnicalDetails.y + _labelTechnicalDetails.height/2
            width: (parent.width - _labelTechnicalDetails.width)/2 - 6
            height: 1

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 1.0;
                    color: "transparent";
                }
                GradientStop {
                    position: 0.0;
                    color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080";
                }
            }
        } // Rectangle

        // Technical details
        Rectangle {
            id: rectangleTechnicalDetails

            x: 12
            y: _labelTechnicalDetails.y + _labelTechnicalDetails.height + 12
            width: parent.width - 2*x
            height: _labelDetailsFlingPower.height + labelDetailsFlingPower.height + 20

            color: pageBerryDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelDetailsFlingPower

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Fling power")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsFlingPower

                x: 6
                y: _labelDetailsFlingPower.y + _labelDetailsFlingPower.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageItemDetails.flingPower
                textFormat: Text.PlainText
            }
        } // Rectangle (technical details)
    } // Flickable
}
