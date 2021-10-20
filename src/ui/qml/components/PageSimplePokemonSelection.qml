import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageSimplePokemonSelection

    property bool allowShowDetails: true
    property alias searchFilter: modelPokemonForSimplePokemonSelection.filter
    property alias modelPokemonForSimplePokemonSelection: modelPokemonForSimplePokemonSelection
    property alias currentIndex: listViewSimplePokemonSelection.currentIndex
    onCurrentIndexChanged: {
        listViewSimplePokemonSelection.positionViewAtIndex(currentIndex < 0 ? 0 : currentIndex, ListView.Beginning)
    }
    property int currentlySelectedPokemonSpeciesId: -1

    Backend.ModelPokemon {
        id: modelPokemonForSimplePokemonSelection
        currentLanguage: applicationWindow.applicationLanguageId
    }

    ListView {
        id: listViewSimplePokemonSelection
        width: parent.width
        height: parent.height

        model: modelPokemonForSimplePokemonSelection
        delegate: ItemDelegate {
            width: listViewSimplePokemonSelection.width
            icon.source: "qrc:/images/sprites/pokemon-icons/3ds/normal/" + speciesId + (speciesId !== 0 ? "-1" : "") + ".png"
            icon.color: "transparent"
            text: name
            highlighted: pageSimplePokemonSelection.currentlySelectedPokemonSpeciesId === speciesId
            Material.foreground: highlighted ? Material.accent : pageSimplePokemonSelection.Material.foreground

            onClicked: {
                pageSimplePokemonSelection.currentIndex = index
                pageSimplePokemonSelection.currentlySelectedPokemonSpeciesId = speciesId
                pageTeamPokemonDetails.pokemonId = pokemonId
                pageTeamPokemonDetails.formId = 0
                pageTeamPokemonDetails.abilityId = primaryAbility
                pageTeamPokemonDetails.genderId = genderRateId === 0 ? 0 : (genderRateId === 8 ? 1 : (genderRateId === -1 ? 2 : pageTeamPokemonDetails.genderId > 1 ? 0 : pageTeamPokemonDetails.genderId))
                applicationWindowContent.pop()
            }

            ToolButton {
                id: toolButtonShowPokemonDetails

                x: parent.width - width
                y: (parent.height - height)/2
                icon.source: "qrc:/images/icons/actions/visibility_on.svg"
                opacity: 0.5
                visible: allowShowDetails
                highlighted: parent.highlighted

                onClicked: {
                    pagePokemonDetails.forms = null // to prevent loading invalid images

                    pagePokemonDetails.pokemonId = pokemonId
                    pagePokemonDetails.speciesId = speciesId

                    pagePokemonDetails.name = name
                    pagePokemonDetails.genusName = genusName
                    pagePokemonDetails.gameDescription = speciesFlavorText
                    pagePokemonDetails.description = speciesDescription
                    pagePokemonDetails.nativeGeneration = generation
                    pagePokemonDetails.isDefault = isDefault

                    pagePokemonDetails.genderRateId = genderRateId
                    pagePokemonDetails.captureRate = captureRate
                    pagePokemonDetails.baseHappiness = baseHappiness
                    pagePokemonDetails.isBaby = isBaby
                    pagePokemonDetails.hatchCounter = hatchCounter
                    pagePokemonDetails.hasGenderDifferences = hasGenderDifferences
                    pagePokemonDetails.formsSwitchable = formsSwitchable
                    pagePokemonDetails.growthRateId = growthRateId

                    pagePokemonDetails.primaryType = primaryType
                    pagePokemonDetails.secondaryType = secondaryType

                    pagePokemonDetails.pokemonHeight = pokemonHeight
                    pagePokemonDetails.pokemonWeight = pokemonWeight

                    pagePokemonDetails.baseExperience = baseExperience
                    pagePokemonDetails.baseHp = ~~baseStats[0]
                    pagePokemonDetails.baseAtk = ~~baseStats[1]
                    pagePokemonDetails.baseDef = ~~baseStats[2]
                    pagePokemonDetails.baseSpAtk = ~~baseStats[3]
                    pagePokemonDetails.baseSpDef = ~~baseStats[4]
                    pagePokemonDetails.baseSpd = ~~baseStats[5]

                    pagePokemonDetails.primaryAbility = primaryAbility
                    pagePokemonDetails.secondaryAbility = secondaryAbility
                    pagePokemonDetails.hiddenAbility = hiddenAbility

                    pagePokemonDetails.colorId = colorId
                    pagePokemonDetails.shapeId = shapeId

                    pagePokemonDetails.primaryEggGroup = primaryEggGroup
                    pagePokemonDetails.secondaryEggGroup = secondaryEggGroup
                    pagePokemonDetails.evolutionChainId = evolutionChainId

                    pagePokemonDetails.moves = moves
                    pagePokemonDetails.forms = forms

                    stackView.push(pagePokemonDetails)
                }
            }
        } // ItemDelegate (delegate)

        ScrollBar.vertical: ScrollBar {
            id: scrollBar

            padding: 2
            contentItem: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                radius: width/2

                color: scrollBar.pressed ? scrollBar.Material.scrollBarPressedColor :
                       scrollBar.interactive && scrollBar.hovered ? scrollBar.Material.scrollBarHoveredColor : scrollBar.Material.scrollBarColor
                opacity: 0.0
            }

            background: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                color: "#0e000000"
                opacity: 0.0
            }
        }
    } // ListView
}
