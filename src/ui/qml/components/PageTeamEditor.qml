import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

import "../dialogs" as Dialogs

Page {
    id: pageTeamEditor

    property alias modelPokemonTeams: modelPkmnTeams

    function showTeamDetails(teamModel) {
        pageTeamDetails.teamModel = teamModel
        modelPokemonTeams.saveTeamState(modelPokemonTeams.indexOfTeam(teamModel.name))
        stackView.push(pageTeamDetails)
    }

    Backend.ModelPokemonTeams {
        id: modelPkmnTeams

        onTeamDataChanged: {
            pageTeamDetails.unsavedChanges = !modelPokemonTeams.compareTeamWithState(modelPokemonTeams.indexOfTeam(pageTeamDetails.teamName))
        }

        onTeamStateSaved: {
            pageTeamDetails.unsavedChanges = !modelPokemonTeams.compareTeamWithState(modelPokemonTeams.indexOfTeam(pageTeamDetails.teamName))
        }
    }
    
    ListView {
        id: listViewTeams

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10
        
        displayMarginBeginning: 50
        displayMarginEnd: 50
        spacing: 10
        model: modelPokemonTeams

        delegate: Pane {
            width: listViewTeams.contentItem.width
            height: 64
            leftInset: 10
            rightInset: 10
            padding: 0
            leftPadding: leftInset
            rightPadding: rightInset
            
            Material.elevation: 10
            Material.background: applicationWindow.Material.dialogColor
            
            ItemDelegate {
                id: itemDelegateBackground

                width: parent.width
                height: parent.height

                onClicked: {
                    showTeamDetails(teamModel)
                }
                
                Label {
                    id: labelTeamName
                    y: 6
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: 6
                    rightPadding: 6
                    
                    text: name
                    font.bold: true
                    elide: Text.ElideRight
                }

                Row {
                    id: rowPokemonInTeamIcons
                    x: (parent.width - width)/2
                    y: labelTeamName.y + labelTeamName.height + 2

                    Repeater {
                        id: repeaterPokemonInTeam

                        model: teamModel
                        delegate: Image {
                            id: imagePokemonIcon

                            readonly property int speciesId: pokemonId > 0 ? modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.SpeciesIdRole) : 0

                            sourceSize: "32x32"
                            source: "qrc:/images/sprites/pokemon-icons/3ds/normal/" + speciesId + (speciesId !== 0 ? "-" + (formId >= modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.FormsCountRole) ? 1 : formId + 1) : "") + ".png"
                        }
                    }
                } // Row
            } // ItemDelegate
        } // Pane (delegate)

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // ListView

    RoundButton {
        id: roundButtonAddTeam

        x: parent.width - width
        y: parent.height - height

        highlighted: true
        icon.source: "qrc:/images/icons/actions/add.svg"

        onClicked: {
            textEditDialogAddTeam.text = ""
            textEditDialogAddTeam.maximumTextLength = 30
            textEditDialogAddTeam.open()
        }
    }

    Dialogs.TextEditDialog {
        id: textEditDialogAddTeam

        x: (applicationWindow.width - width)/2
        y: (applicationWindow.height - height)/2
        width: implicitWidth > applicationWindow.width - 40 ? applicationWindow.width - 40 : implicitWidth
        height: implicitHeight > applicationWindow.height - 40 ? applicationWindow.height - 40 : implicitHeight

        modal: true
        focus: visible

        title: qsTr("Team's name")
        allowOK: Backend.Utils.trimmedString(text) && !modelPokemonTeams.teamNameExists(text)
        errorMessage: !allowOK && Backend.Utils.trimmedString(text) ? qsTr("Duplicated name.") : ""

        onAccepted: {
            if (modelPokemonTeams.addTeam(text)) {
                showTeamDetails(modelPokemonTeams.getTeamData(modelPokemonTeams.indexOfTeam(text), Backend.ModelPokemonTeams.TeamModelRole))
            }
        }
    }
}
