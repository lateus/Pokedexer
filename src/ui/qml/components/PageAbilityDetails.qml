import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageAbilityDetails

    property int abilityId: 1
    property string name
    property string gameDescription
    property string detailedDescription
    property int nativeGeneration

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (abilityId > 0) {
                name = modelAbilities.getAbilityData(abilityId, Backend.ModelAbilities.NameRole)
                gameDescription = modelAbilities.getAbilityData(abilityId, Backend.ModelAbilities.FlavorTextRole)
                detailedDescription = modelAbilities.getAbilityData(abilityId, Backend.ModelAbilities.DetailedEffectRole)
                nativeGeneration = modelAbilities.getAbilityData(abilityId, Backend.ModelAbilities.GenerationRole)
            }
        }
    }

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height

        contentHeight: labelAbilityName.height + rectangleSeparator.height + rectangleGameDescription.height + rectangleDetailedDescription.height + 70

        Label {
            id: labelAbilityName

            y: 12
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: Qt.application.font.pointSize * 1.2
            font.bold: true
            elide: Text.ElideRight
            text: pageAbilityDetails.name
            textFormat: Text.PlainText
        }

        RectangleSeparator {
            id: rectangleSeparator
            y: labelAbilityName.y + labelAbilityName.height + 5
        }

        // Game description
        Rectangle {
            id: rectangleGameDescription

            x: 12
            y: rectangleSeparator.y + rectangleSeparator.height + 12
            width: parent.width - 2*x
            height: _labelAbilityDetailsGameDescription.height + labelAbilityDetailsGameDescription.height + 20

            color: pageAbilityDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelAbilityDetailsGameDescription

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Game description")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelAbilityDetailsGameDescription

                x: 6
                y: _labelAbilityDetailsGameDescription.y + _labelAbilityDetailsGameDescription.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageAbilityDetails.gameDescription
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
            height: _labelAbilityDetailsDetailedDescription.height + labelAbilityDetailsDetailedDescription.height + 20

            color: pageAbilityDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelAbilityDetailsDetailedDescription

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Detailed description")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelAbilityDetailsDetailedDescription

                x: 6
                y: _labelAbilityDetailsDetailedDescription.y + _labelAbilityDetailsDetailedDescription.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageAbilityDetails.detailedDescription
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
