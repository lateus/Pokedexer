import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

import "../dialogs" as Dialogs

Page {
    id: pageTeamDetails

    property alias teamModel: listViewPokemonInTeam.model
    readonly property string teamName: teamModel ? teamModel.name : ""
    property bool unsavedChanges: false

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height

        contentHeight: itemDelegateTeamName.height + rectangleSeparator.height + listViewPokemonInTeam.height + 17

        ItemDelegate {
            id: itemDelegateTeamName

            y: 12
            width: parent.width
            font.pointSize: Qt.application.font.pointSize * 1.2
            font.bold: true

            text: teamName

            onClicked: {
                textEditDialogChangeTeamName.text = itemDelegateTeamName.text
                textEditDialogChangeTeamName.placeholderText = qsTr("Type the new name")
                textEditDialogChangeTeamName.open()
            }
        }

        RectangleSeparator {
            id: rectangleSeparator
            y: itemDelegateTeamName.y + itemDelegateTeamName.height + 5
        }

        ListView {
            id: listViewPokemonInTeam
            y: rectangleSeparator.y + rectangleSeparator.height
            topMargin: 16
            width: parent.width
            height: contentHeight + topMargin + 8

            interactive: false
            spacing: 16
            clip: true
            model: teamModel
            delegate: TeamPokemon {
                id: teamPokemon

                width: parent.width
                height: 64

                pokemonId: model.pokemonId
                formId: model.formId
                natureId: model.natureId
                itemId: model.itemId
                shiny: model.shiny
                move1Id: model.move1Id
                move2Id: model.move2Id
                move3Id: model.move3Id
                move4Id: model.move4Id

                onClicked: {
                    pageTeamPokemonDetails.pokemonIndexInTeam = index
                    pageTeamPokemonDetails.pokemonId = model.pokemonId
                    pageTeamPokemonDetails.formId = model.formId
                    pageTeamPokemonDetails.genderId = model.genderId
                    pageTeamPokemonDetails.shiny = model.shiny
                    pageTeamPokemonDetails.nickname = model.nickname
                    pageTeamPokemonDetails.abilityId = model.abilityId
                    pageTeamPokemonDetails.level = model.level
                    pageTeamPokemonDetails.natureId = model.natureId
                    pageTeamPokemonDetails.itemId = model.itemId
                    pageTeamPokemonDetails.ivHp = model.ivHp
                    pageTeamPokemonDetails.ivAtk = model.ivAtk
                    pageTeamPokemonDetails.ivDef = model.ivDef
                    pageTeamPokemonDetails.ivSpAtk = model.ivSpAtk
                    pageTeamPokemonDetails.ivSpDef = model.ivSpDef
                    pageTeamPokemonDetails.ivSpd = model.ivSpd
                    pageTeamPokemonDetails.evHp = model.evHp
                    pageTeamPokemonDetails.evAtk = model.evAtk
                    pageTeamPokemonDetails.evDef = model.evDef
                    pageTeamPokemonDetails.evSpAtk = model.evSpAtk
                    pageTeamPokemonDetails.evSpDef = model.evSpDef
                    pageTeamPokemonDetails.evSpd = model.evSpd
                    pageTeamPokemonDetails.move1Id = model.move1Id
                    pageTeamPokemonDetails.move2Id = model.move2Id
                    pageTeamPokemonDetails.move3Id = model.move3Id
                    pageTeamPokemonDetails.move4Id = model.move4Id
                    pageTeamPokemonDetails.positionFormAtIndex(model.formId)
                    stackView.push(pageTeamPokemonDetails)
                }
            }
        }

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // Flickable

    Dialogs.TextEditDialog {
        id: textEditDialogChangeTeamName

        anchors.centerIn: Overlay.overlay
        width: implicitWidth > applicationWindow.width - 40 ? applicationWindow.width - 40 : implicitWidth
        height: implicitHeight > applicationWindow.height - 40 ? applicationWindow.height - 40 : implicitHeight

        modal: true
        focus: visible

        title: qsTr("Team's name")
        allowOK: Backend.Utils.trimmedString(text) && !modelPokemonTeams.teamNameExists(text)
        errorMessage: !allowOK && Backend.Utils.trimmedString(text) && text !== itemDelegateTeamName.text ? qsTr("Duplicated name.") : ""

        onAccepted: {
            modelPokemonTeams.setTeamData(modelPokemonTeams.indexOfTeam(teamName), text, Backend.ModelPokemonTeams.NameRole)
        }
    }
}
