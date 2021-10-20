import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Page {
    id: pageBerryDetails

    property int berryId: 1
    property string name
    property string gameDescription
    property string detailedDescription
    property int naturalGiftPower
    property int naturalGiftType: 1
    property int size
    property int maxHarvest
    property int growthTime
    property int soilDryness
    property int smoothness
    property string firmness
    property var flavorNames: modelBerries.getFlavorNames()
    property var potencyByFlavor: ["0", "0", "0", "0", "0"]

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
            text: pageBerryDetails.name
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

                source: "qrc:/images/sprites/berries/" + pageBerryDetails.berryId + ".png"
            }
        }

        // Game description
        Rectangle {
            id: rectangleGameDescription

            x: 12
            y: rectangleIcon.y + rectangleIcon.height + 12
            width: parent.width - 2*x
            height: _labelDetailsGameDescription.height + labelDetailsGameDescription.height + 20

            color: pageBerryDetails.Material.dialogColor
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
                enabled: pageBerryDetails.gameDescription
                text: pageBerryDetails.gameDescription ? pageBerryDetails.gameDescription : qsTr("Not available")
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

            color: pageBerryDetails.Material.dialogColor
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
                text: pageBerryDetails.detailedDescription ? pageBerryDetails.detailedDescription : qsTr("Not available")
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
            height: _labelDetailsNaturalGiftPower.height + labelDetailsNaturalGiftPower.height + _labelDetailsSize.height + labelDetailsSize.height + _labelDetailsGrowthTime.height + labelDetailsGrowthTime.height + _labelDetailsSoilDryness.height + labelDetailsSoilDryness.height + _labelDetailsSmoothness.height + labelDetailsSmoothness.height + _labelDetailsFirmness.height + labelDetailsFirmness.height + _labelDetailsPotencyByFlavor.height + labelDetailsPotencyByFlavor.height + 100

            color: pageBerryDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelDetailsNaturalGiftPower

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Natural Gift's power and type")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsNaturalGiftPower

                x: (parent.width - width - typeTagNatureGiftType.width)/2 - 3
                y: _labelDetailsNaturalGiftPower.y + _labelDetailsNaturalGiftPower.height + 5

                horizontalAlignment: Text.AlignHCenter
                text: pageBerryDetails.naturalGiftPower
                textFormat: Text.PlainText
            }

            TypeTag {
                id: typeTagNatureGiftType

                x: labelDetailsNaturalGiftPower.x + labelDetailsNaturalGiftPower.width + 3
                y: labelDetailsNaturalGiftPower.y + (labelDetailsNaturalGiftPower.height - height)/2

                type: pageBerryDetails.naturalGiftType
                source: "qrc:/images/types/types/tags/" + type + ".svg"
                sourceSize.height: 32
            }

            Label {
                id: _labelDetailsSize

                y: labelDetailsNaturalGiftPower.y + labelDetailsNaturalGiftPower.height + 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Size")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsSize

                x: 6
                y: _labelDetailsSize.y + _labelDetailsSize.height
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageBerryDetails.size
                textFormat: Text.PlainText
            }

            Label {
                id: _labelDetailsGrowthTime

                y: labelDetailsSize.y + labelDetailsSize.height + 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Growth time")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsGrowthTime

                x: 6
                y: _labelDetailsGrowthTime.y + _labelDetailsGrowthTime.height
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageBerryDetails.growthTime
                textFormat: Text.PlainText
            }

            Label {
                id: _labelDetailsSoilDryness

                y: labelDetailsGrowthTime.y + labelDetailsGrowthTime.height + 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Soil dryness")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsSoilDryness

                x: 6
                y: _labelDetailsSoilDryness.y + _labelDetailsSoilDryness.height
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageBerryDetails.soilDryness
                textFormat: Text.PlainText
            }

            Label {
                id: _labelDetailsSmoothness

                y: labelDetailsSoilDryness.y + labelDetailsSoilDryness.height + 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Smoothness")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsSmoothness

                x: 6
                y: _labelDetailsSmoothness.y + _labelDetailsSmoothness.height
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageBerryDetails.smoothness
                textFormat: Text.PlainText
            }

            Label {
                id: _labelDetailsFirmness

                y: labelDetailsSmoothness.y + labelDetailsSmoothness.height + 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Firmness")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsFirmness

                x: 6
                y: _labelDetailsFirmness.y + _labelDetailsFirmness.height
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageBerryDetails.firmness
                textFormat: Text.PlainText
            }

            Label {
                id: _labelDetailsPotencyByFlavor

                y: labelDetailsFirmness.y + labelDetailsFirmness.height + 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Potency by flavor")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelDetailsPotencyByFlavor

                x: (parent.width - width)/2
                y: _labelDetailsPotencyByFlavor.y + _labelDetailsPotencyByFlavor.height + 5

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Flavor") + " | " + qsTr("Potency") + "\n" +
                      "-------|------\n" +
                      // Flavor at index 0 is "None", so we start at index 1:
                      qsTr("%1|%2").arg(pageBerryDetails.flavorNames[1]).arg(pageBerryDetails.potencyByFlavor[0]) + "\n" +
                      qsTr("%1|%2").arg(pageBerryDetails.flavorNames[2]).arg(pageBerryDetails.potencyByFlavor[1]) + "\n" +
                      qsTr("%1|%2").arg(pageBerryDetails.flavorNames[3]).arg(pageBerryDetails.potencyByFlavor[2]) + "\n" +
                      qsTr("%1|%2").arg(pageBerryDetails.flavorNames[4]).arg(pageBerryDetails.potencyByFlavor[3]) + "\n" +
                      qsTr("%1|%2").arg(pageBerryDetails.flavorNames[5]).arg(pageBerryDetails.potencyByFlavor[4])
                textFormat: Text.MarkdownText
            }
        } // Rectangle (technical details)

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // Flickable
}
