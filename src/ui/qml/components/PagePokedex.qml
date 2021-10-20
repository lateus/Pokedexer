import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pagePokedex

    property alias searchFilter: modelPokemon.filter
    property alias modelPokemon: modelPokemon

    Backend.ModelPokemon {
        id: modelPokemon
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewPokemon

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10
        
        displayMarginBeginning: 60
        displayMarginEnd: 60
        spacing: 10
        model: modelPokemon
        delegate: Pane {
            width: listViewPokemon.contentItem.width
            height: 60
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

                    console.log("PagePokedex", "pokemonId", pokemonId)
                    console.log("PagePokemonDetails", "movesCount", pagePokemonDetails.movesCount)
                    stackView.push(pagePokemonDetails)
                }

                Image {
                    id: imagePokemonSprite

                    height: parent.height
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/images/sprites/pokemon/3ds/normal/" + speciesId + "-1.png"
                }
                
                Label {
                    id: labelPokemon
                    x: imagePokemonSprite.width + 7
                    y: 6
                    
                    text: name
                    font.bold: true
                    elide: Text.ElideRight
                    textFormat: Text.PlainText
                }

                TypeTag {
                    id: typeTagPrimaryType

                    x: imagePokemonSprite.width
                    y: labelPokemon.y + labelPokemon.height
                    sourceSize.height: 36
                    type: primaryType
                    source: "qrc:/images/types/types/tags/" + type + ".svg"
                }

                TypeTag {
                    id: typeTagSecondaryType

                    x: typeTagPrimaryType.x + typeTagPrimaryType.width
                    y: typeTagPrimaryType.y
                    height: typeTagPrimaryType.height
                    visible: secondaryType
                    type: secondaryType
                    source: "qrc:/images/types/types/tags/" + type + ".svg"
                }
            } // ItemDelegate
        } // Pane (delegate)

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

    RoundButton {
        id: roundButtonFilterByColor

        x: roundButtonFilter.x
        y: roundButtonFilterByType.y - height

        icon.source: "qrc:/images/icons/others/rgb.svg"
        icon.color: "transparent"
        scale: roundButtonFilterByType.scale
        visible: false

        onClicked: {
//            drawerFilter.model = modelTypes.getTypeNames()
//            drawerFilter.delegate = componentTypeDelegate
//            drawerFilter.open()
        }
    }

    RoundButton {
        id: roundButtonFilterByType

        x: roundButtonFilter.x
        y: roundButtonFilter.y - height

        icon.source: "qrc:/images/icons/others/types.svg"
        icon.color: "transparent"
        scale: roundButtonFilter.checked ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 250; easing.type: roundButtonFilterByType.scale === 0 ? Easing.OutBack : Easing.InBack } }

        onClicked: {
            drawerFilter.model = modelTypes.getTypeNames()
            drawerFilter.delegate = componentTypeDelegate
            drawerFilter.open()
        }
    }

    RoundButton {
        id: roundButtonFilter

        x: parent.width - width
        y: parent.height - height

        checkable: true
        icon.source: checked ? "qrc:/images/icons/actions/clear.svg" : "qrc:/images/icons/actions/filter.svg"
    }

    Drawer {
        id: drawerFilter

        property alias model: listViewFilter.model
        property alias delegate: listViewFilter.delegate

        width: 140
        height: parent.height

        enabled: visible
        edge: Qt.RightEdge
        dragMargin: 0

        onClosed: roundButtonFilter.scale = 1

        ListView {
            id: listViewFilter

            height: parent.height
            width: parent.width

            ScrollIndicator.vertical: ScrollIndicator {
                x: parent.width - width
                height: parent.height
            }
        }
    } // Drawer (filter)

    Component {
        id: componentTypeDelegate

        ItemDelegate {
            width: parent ? parent.width : width

            text: index === 0 ? qsTr("No filter") : ""
            icon.source: index === 0 ? "qrc:/images/icons/actions/clear.svg" : ""
            Material.accent: Material.Red
            Material.foreground: Material.accent
            font.bold: true

            TypeTag {
                x: (parent.width - width)/2
                y: (parent.height - height)/2

                visible: index > 0
                sourceSize.height: 42
                type: index
            }

            onClicked: {
                modelPokemon.filterType = index
                roundButtonFilter.checked = false
                drawerFilter.close()
            }
        }
    } // Component (type delegate)
}
