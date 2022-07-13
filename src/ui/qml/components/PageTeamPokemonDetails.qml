import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Qt5Compat.GraphicalEffects

import Pokedexer 1.0 as Backend

import "../dialogs" as Dialogs

Page {
    id: pageTeamPokemonDetails

    property int pokemonIndexInTeam
    property int pokemonId
    readonly property int speciesId: pokemonId > 0 ? modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.SpeciesIdRole) : 0
    property int formId
    property int genderId
    property bool shiny
    property string nickname
    property int abilityId
    property int itemId
    property alias level: statsEditor.level
    property alias natureId: statsEditor.natureId
    property alias ivHp: statsEditor.statHpIvValue
    property alias ivAtk: statsEditor.statAttackIvValue
    property alias ivDef: statsEditor.statDefenseIvValue
    property alias ivSpAtk: statsEditor.statSpecialAttackIvValue
    property alias ivSpDef: statsEditor.statSpecialDefenseIvValue
    property alias ivSpd: statsEditor.statSpeedIvValue
    property alias evHp: statsEditor.statHpEvValue
    property alias evAtk: statsEditor.statAttackEvValue
    property alias evDef: statsEditor.statDefenseEvValue
    property alias evSpAtk: statsEditor.statSpecialAttackEvValue
    property alias evSpDef: statsEditor.statSpecialDefenseEvValue
    property alias evSpd: statsEditor.statSpeedEvValue
    property int move1Id
    property int move2Id
    property int move3Id
    property int move4Id

    property alias currentTabIndex: tabBarTeamPokemonDetails.currentIndex

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (pokemonId > 0) {
                pathViewForms.model.currentLanguage = applicationLanguageId
                moveAttributeAbility.attributeValue = abilityId > 0 ? modelAbilities.getAbilityData(abilityId, Backend.ModelAbilities.NameRole) : moveAttributeAbility.attributeValue
                menuItemPrimaryAbility.text = moveAttributeAbility.primaryAbilityId > 0 ? modelAbilities.getAbilityData(moveAttributeAbility.primaryAbilityId, Backend.ModelAbilities.NameRole) : menuItemPrimaryAbility.text
                menuItemSecondaryAbility.text = moveAttributeAbility.secondaryAbilityId > 0 ? modelAbilities.getAbilityData(moveAttributeAbility.secondaryAbilityId, Backend.ModelAbilities.NameRole) : menuItemSecondaryAbility.text
                menuItemHiddenAbility.text = moveAttributeAbility.hiddenAbilityId > 0 ? modelAbilities.getAbilityData(moveAttributeAbility.hiddenAbilityId, Backend.ModelAbilities.NameRole) : menuItemHiddenAbility.text
                moveAttributeItem.attributeValue  = itemId  > 0 ? modelItems.getItemData(itemId, Backend.ModelItems.NameRole)  : moveAttributeItem.attributeValue
                moveAttributeMove1.attributeValue = move1Id > 0 ? modelMoves.getMoveData(move1Id, Backend.ModelMoves.NameRole) : moveAttributeMove1.attributeValue
                moveAttributeMove2.attributeValue = move2Id > 0 ? modelMoves.getMoveData(move2Id, Backend.ModelMoves.NameRole) : moveAttributeMove2.attributeValue
                moveAttributeMove3.attributeValue = move3Id > 0 ? modelMoves.getMoveData(move3Id, Backend.ModelMoves.NameRole) : moveAttributeMove3.attributeValue
                moveAttributeMove4.attributeValue = move4Id > 0 ? modelMoves.getMoveData(move4Id, Backend.ModelMoves.NameRole) : moveAttributeMove4.attributeValue
            }
        }
    }

    function updateTeamPokemonValue(index, value, role) {
        if (pageTeamDetails.teamModel) {
            pageTeamDetails.teamModel.setTeamPokemonData(index, value, role)
        }
    }

    function positionFormAtIndex(index) {
        if (index >= 0 && index < pathViewForms.count) {
            pathViewForms.positionViewAtIndex(index, PathView.Center)
        }
    }

    onPokemonIdChanged: updateTeamPokemonValue(pokemonIndexInTeam, pokemonId, Backend.ModelPokemonInTeam.PokemonIdRole)
    onSpeciesIdChanged: updateTeamPokemonValue(pokemonIndexInTeam, speciesId, Backend.ModelPokemonInTeam.SpeciesIdRole)
    onFormIdChanged:    updateTeamPokemonValue(pokemonIndexInTeam, formId,    Backend.ModelPokemonInTeam.FormIdRole)
    onGenderIdChanged:  updateTeamPokemonValue(pokemonIndexInTeam, genderId,  Backend.ModelPokemonInTeam.GenderIdRole)
    onShinyChanged:     updateTeamPokemonValue(pokemonIndexInTeam, shiny,     Backend.ModelPokemonInTeam.ShinyRole)
    onNicknameChanged:  updateTeamPokemonValue(pokemonIndexInTeam, nickname,  Backend.ModelPokemonInTeam.NicknameRole)
    onAbilityIdChanged: updateTeamPokemonValue(pokemonIndexInTeam, abilityId, Backend.ModelPokemonInTeam.AbilityIdRole)
    onLevelChanged:     updateTeamPokemonValue(pokemonIndexInTeam, level,     Backend.ModelPokemonInTeam.LevelRole)
    onNatureIdChanged:  updateTeamPokemonValue(pokemonIndexInTeam, natureId,  Backend.ModelPokemonInTeam.NatureIdRole)
    onItemIdChanged:    updateTeamPokemonValue(pokemonIndexInTeam, itemId,    Backend.ModelPokemonInTeam.ItemIdRole)
    onIvHpChanged:      updateTeamPokemonValue(pokemonIndexInTeam, ivHp,      Backend.ModelPokemonInTeam.IvHpRole)
    onIvAtkChanged:     updateTeamPokemonValue(pokemonIndexInTeam, ivAtk,     Backend.ModelPokemonInTeam.IvAtkRole)
    onIvDefChanged:     updateTeamPokemonValue(pokemonIndexInTeam, ivDef,     Backend.ModelPokemonInTeam.IvDefRole)
    onIvSpAtkChanged:   updateTeamPokemonValue(pokemonIndexInTeam, ivSpAtk,   Backend.ModelPokemonInTeam.IvSpAtkRole)
    onIvSpDefChanged:   updateTeamPokemonValue(pokemonIndexInTeam, ivSpDef,   Backend.ModelPokemonInTeam.IvSpDefRole)
    onIvSpdChanged:     updateTeamPokemonValue(pokemonIndexInTeam, ivSpd,     Backend.ModelPokemonInTeam.IvSpdRole)
    onEvHpChanged:      updateTeamPokemonValue(pokemonIndexInTeam, evHp,      Backend.ModelPokemonInTeam.EvHpRole)
    onEvAtkChanged:     updateTeamPokemonValue(pokemonIndexInTeam, evAtk,     Backend.ModelPokemonInTeam.EvAtkRole)
    onEvDefChanged:     updateTeamPokemonValue(pokemonIndexInTeam, evDef,     Backend.ModelPokemonInTeam.EvDefRole)
    onEvSpAtkChanged:   updateTeamPokemonValue(pokemonIndexInTeam, evSpAtk,   Backend.ModelPokemonInTeam.EvSpAtkRole)
    onEvSpDefChanged:   updateTeamPokemonValue(pokemonIndexInTeam, evSpDef,   Backend.ModelPokemonInTeam.EvSpDefRole)
    onEvSpdChanged:     updateTeamPokemonValue(pokemonIndexInTeam, evSpd,     Backend.ModelPokemonInTeam.EvSpdRole)
    onMove1IdChanged:   updateTeamPokemonValue(pokemonIndexInTeam, move1Id,   Backend.ModelPokemonInTeam.Move1IdRole)
    onMove2IdChanged:   updateTeamPokemonValue(pokemonIndexInTeam, move2Id,   Backend.ModelPokemonInTeam.Move2IdRole)
    onMove3IdChanged:   updateTeamPokemonValue(pokemonIndexInTeam, move3Id,   Backend.ModelPokemonInTeam.Move3IdRole)
    onMove4IdChanged:   updateTeamPokemonValue(pokemonIndexInTeam, move4Id,   Backend.ModelPokemonInTeam.Move4IdRole)

    header: TabBar {
        id: tabBarTeamPokemonDetails

        TabButton {
            icon.source: "qrc:/images/icons/others/pokeball.svg"
        }
        TabButton {
            icon.source: "qrc:/images/icons/actions/bars.svg"
            enabled: speciesId > 0 && pokemonId > 0

            onEnabledChanged: {
                if (!enabled) {
                    tabBarTeamPokemonDetails.currentIndex = 0
                }
            }
        }

        background: Rectangle {
            color: tabBarTeamPokemonDetails.Material.dialogColor
        }
    }


    SwipeView {
        width: parent.width
        height: parent.height

        interactive: false
        currentIndex: tabBarTeamPokemonDetails.currentIndex

        Flickable {
            id: flickableMainDetails

            contentHeight: moveAttributeMove4.y + moveAttributeMove4.height + 10


            //! Form

            ItemDelegate {
                id: itemDelegatePokemon

                x: 6
                y: 6
                width: 100
                height: width + labelAbility.height + 18
                padding: 6
                topPadding: 6
                bottomPadding: 6

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: itemDelegatePokemon.width
                        height: itemDelegatePokemon.height
                        radius: 10
                    }
                }

                onClicked: {
                    pageSimplePokemonSelection.searchFilter = ""
                    pageSimplePokemonSelection.currentIndex = speciesId - 1
                    pageSimplePokemonSelection.currentlySelectedPokemonSpeciesId = speciesId
                    stackView.push(pageSimplePokemonSelection)
                }

                ToolButton {
                    id: toolButtonClearPokemon

                    x: parent.width - width
                    width: 16
                    height: 16
                    padding: 0
                    leftInset: 0
                    rightInset: 0
                    topInset: 0
                    bottomInset: 0

                    icon.source: "qrc:/images/icons/actions/cancel.svg"
                    opacity: 0.5
                    onClicked: {
                        messageDialogRemovePokemon.teamName = pageTeamDetails.teamName
                        messageDialogRemovePokemon.pokemonIndexInTeam = pokemonIndexInTeam
                        messageDialogRemovePokemon.open()
                    }
                }

                PathView {
                    id: pathViewForms

                    x: (parent.width - width)/2
                    y: -12
                    width: 240
                    height: parent.height

                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    highlightRangeMode: PathView.StrictlyEnforceRange
                    pathItemCount: 3
                    interactive: false
                    path: Path {
                        startX: pathViewForms.width * 0.25; startY: pathViewForms.height/2
                        PathAttribute { name: "iconScale"; value: 0.2 }
                        PathAttribute { name: "iconOpacity"; value: 0 }
                        PathAttribute { name: "iconOrder"; value: 0 }
                        PathLine { x: pathViewForms.width * 0.5; y: pathViewForms.height/2 }
                        PathAttribute { name: "iconScale"; value: 1 }
                        PathAttribute { name: "iconOpacity"; value: 1 }
                        PathAttribute { name: "iconOrder"; value: pathViewForms.pathItemCount + 1 }
                        PathLine { x: pathViewForms.width * 0.75; y: pathViewForms.height/2 }
                    }

                    currentIndex: formId
                    onCurrentIndexChanged: {
                        if (currentIndex >= 0 && pathViewForms.model && pathViewForms.count !== 1) {
                            pageTeamPokemonDetails.formId = currentIndex
                            pageTeamPokemonDetails.pokemonId = modelPokemon.getPokemonData(pathViewForms.model.getPokemonFormData(currentIndex, Backend.ModelPokemonForms.PokemonIdRole), Backend.ModelPokemon.IdRole)
                            if (abilityId !== moveAttributeAbility.primaryAbilityId && abilityId !== moveAttributeAbility.secondaryAbilityId && abilityId !== moveAttributeAbility.hiddenAbilityId) {
                                abilityId = moveAttributeAbility.primaryAbilityId
                            }
                        }
                    }

                    model: speciesId > 0 ? modelPokemon.getPokemonData(speciesId, Backend.ModelPokemon.FormsRole) : 1
                    delegate: Image {
                        id: imagePokemonSprite

                        width: itemDelegatePokemon.width
                        scale: PathView.iconScale ? PathView.iconScale : 1
                        opacity: PathView.iconOpacity ? PathView.iconOpacity : 1
                        z: PathView.iconOrder ? PathView.iconOrder : 0

                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/images/sprites/pokemon/3ds/" + (shiny ? "shiny" : "normal") + (pokemonId > 0 && modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.HasGenderDifferencesRole) && genderId === 1 /*db_common.h?*/ && order === 1 ? "/female/" : "/") + speciesId + (speciesId > 0 ? ("-" + order) : "") + ".png"

                        Label {
                            id: labelPokemonSpeciesName

                            x: 6
                            y: parent.height + 6
                            width: parent.width - 2*x
                            horizontalAlignment: Text.AlignHCenter

                            text: pokemonId <= 0 || speciesId <= 0 ? qsTr("MissingNo") : name ? name : modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole)
                            fontSizeMode: Text.HorizontalFit
                            font.bold: true
                            minimumPointSize: 1
                            minimumPixelSize: 1
                            elide: Text.ElideRight
                            textFormat: Text.PlainText
                        }
                    } // Image (delegate)
                } // PathView (forms)
            } // ItemDelegate (pokemon form's sprites and names)

            ToolButton {
                id: toolButtonPreviousForm

                x: itemDelegatePokemon.x
                y: itemDelegatePokemon.y + itemDelegatePokemon.height + 6

                enabled: pathViewForms.count > 1
                icon.source: "qrc:/images/icons/arrows/chevron_left.svg"

                onClicked: {
                    pathViewForms.decrementCurrentIndex()
                }
            }

            ToolButton {
                id: toolButtonNextForm

                x: itemDelegatePokemon.x + itemDelegatePokemon.width - width
                y: toolButtonPreviousForm.y

                enabled: pathViewForms.count > 1
                icon.source: "qrc:/images/icons/arrows/chevron_right.svg"

                onClicked: {
                    pathViewForms.incrementCurrentIndex()
                }
            }


            //! Nickname

            Label {
                id: labelNickname

                x: itemDelegatePokemon.x + itemDelegatePokemon.width + 12
                y: itemDelegatePokemon.y
                width: parent.width - x - 6

                enabled: speciesId > 0 && pokemonId > 0
                text: qsTr("Nickname")
                font.italic: true
            }

            RectangleSeparator {
                id: rectangleSeparatorNickname

                x: labelNickname.x
                y: labelNickname.y + labelNickname.height + 2
                width: labelNickname.width
                height: 1

                stayInterval: 0.2
                leaveInterval: 0.2
                alignment: Qt.AlignLeft
            }

            MoveAttribute {
                id: moveAttributeNickname

                x: labelNickname.x
                y: rectangleSeparatorNickname.y + rectangleSeparatorNickname.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                border.color: enabled ? (Material.theme === Material.Light ? "#333333" : "#FFFFFF") : Material.hintTextColor
                color: "transparent"
                nameWidth: height
                attributeValue: nickname
                iconSource: "qrc:/images/icons/actions/edit.svg"

                onClicked: {
                    textEditDialogChangeNickname.maximumTextLength = 12
                    textEditDialogChangeNickname.open()
                }
            } // MoveAttribute (nickname)


            //! Ability

            Label {
                id: labelAbility

                x: labelNickname.x
                y: moveAttributeNickname.y + moveAttributeNickname.height + 6
                width: parent.width - x - 6

                enabled: speciesId > 0 && pokemonId > 0
                text: qsTr("Ability")
                font.italic: true
            }

            RectangleSeparator {
                id: rectangleSeparatorAbility

                x: labelAbility.x
                y: labelAbility.y + labelAbility.height + 2
                width: labelAbility.width
                height: 1

                stayInterval: 0.2
                leaveInterval: 0.2
                alignment: Qt.AlignLeft
            }

            MoveAttribute {
                id: moveAttributeAbility

                readonly property int primaryAbilityId: pokemonId > 0 ? applicationWindowContent.modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.PrimaryAbilityRole) : 0
                readonly property int secondaryAbilityId: pokemonId > 0 ? applicationWindowContent.modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.SecondaryAbilityRole) : 0
                readonly property int hiddenAbilityId: pokemonId > 0 ? applicationWindowContent.modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.HiddenAbilityRole) : 0

                x: labelAbility.x
                y: rectangleSeparatorAbility.y + rectangleSeparatorAbility.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                Material.accent: abilityId === hiddenAbilityId ? Material.Amber : parent.Material.accent
                Material.foreground: abilityId === hiddenAbilityId ? Material.accent : parent.Material.foreground
                radius: 4
                border.color: enabled ? (abilityId === hiddenAbilityId ? Material.accent : (Material.theme === Material.Light ? "#333333" : "#FFFFFF")) : Material.hintTextColor
                color: "transparent"
                nameWidth: height
                attributeValue: abilityId > 0 ? modelAbilities.getAbilityData(abilityId, Backend.ModelAbilities.NameRole) : qsTr("None")
                iconSource: {
                    if (pokemonId > 0 && abilityId === hiddenAbilityId) {
                        return "qrc:/images/icons/actions/report.svg"
                    } else if (abilityId === secondaryAbilityId) {
                        return "qrc:/images/icons/numbers/2_fill.svg"
                    } else if (abilityId === primaryAbilityId) {
                        return "qrc:/images/icons/numbers/1_fill.svg"
                    } else {
                        return ""
                    }
                }

                onClicked: {
                    menuAvailableAbilities.open()
                }

                Menu {
                    id: menuAvailableAbilities

                    y: parent.height
                    width: parent.width

                    enabled: speciesId > 0 && pokemonId > 0
                    modal: true

                    MenuItem {
                        id: menuItemPrimaryAbility

                        icon.source: "qrc:/images/icons/numbers/1_fill.svg"
                        text: moveAttributeAbility.primaryAbilityId > 0 ? modelAbilities.getAbilityData(moveAttributeAbility.primaryAbilityId, Backend.ModelAbilities.NameRole) : "-"

                        onTriggered: {
                            abilityId = moveAttributeAbility.primaryAbilityId
                        }

                        ToolButton {
                            id: toolButtonShowPrimaryAbilityDetails

                            x: parent.width - width
                            y: (parent.height - height)/2
                            icon.source: "qrc:/images/icons/actions/visibility_on.svg"
                            opacity: 0.5

                            onClicked: {
                                menuAvailableAbilities.close()
                                pageAbilityDetails.abilityId = moveAttributeAbility.primaryAbilityId
                                pageAbilityDetails.name = modelAbilities.getAbilityData(moveAttributeAbility.primaryAbilityId, Backend.ModelAbilities.NameRole)
                                pageAbilityDetails.gameDescription = modelAbilities.getAbilityData(moveAttributeAbility.primaryAbilityId, Backend.ModelAbilities.FlavorTextRole)
                                pageAbilityDetails.detailedDescription = modelAbilities.getAbilityData(moveAttributeAbility.primaryAbilityId, Backend.ModelAbilities.DetailedEffectRole)
                                pageAbilityDetails.nativeGeneration = modelAbilities.getAbilityData(moveAttributeAbility.primaryAbilityId, Backend.ModelAbilities.GenerationRole)
                                stackView.push(pageAbilityDetails)
                            }
                        }
                    } // MenuItem (primary ability)

                    MenuItem {
                        id: menuItemSecondaryAbility

                        height: visible ? menuItemPrimaryAbility.height : 0
                        visible: moveAttributeAbility.secondaryAbilityId > 0
                        enabled: visible
                        icon.source: "qrc:/images/icons/numbers/2_fill.svg"
                        text: moveAttributeAbility.secondaryAbilityId > 0 ? modelAbilities.getAbilityData(moveAttributeAbility.secondaryAbilityId, Backend.ModelAbilities.NameRole) : "-"

                        onTriggered: {
                            abilityId = moveAttributeAbility.secondaryAbilityId
                        }

                        ToolButton {
                            id: toolButtonShowSecondaryAbilityDetails

                            x: parent.width - width
                            y: (parent.height - height)/2
                            icon.source: "qrc:/images/icons/actions/visibility_on.svg"
                            opacity: 0.5

                            onClicked: {
                                menuAvailableAbilities.close()
                                pageAbilityDetails.abilityId = moveAttributeAbility.secondaryAbilityId
                                pageAbilityDetails.name = modelAbilities.getAbilityData(moveAttributeAbility.secondaryAbilityId, Backend.ModelAbilities.NameRole)
                                pageAbilityDetails.gameDescription = modelAbilities.getAbilityData(moveAttributeAbility.secondaryAbilityId, Backend.ModelAbilities.FlavorTextRole)
                                pageAbilityDetails.detailedDescription = modelAbilities.getAbilityData(moveAttributeAbility.secondaryAbilityId, Backend.ModelAbilities.DetailedEffectRole)
                                pageAbilityDetails.nativeGeneration = modelAbilities.getAbilityData(moveAttributeAbility.secondaryAbilityId, Backend.ModelAbilities.GenerationRole)
                                stackView.push(pageAbilityDetails)
                            }
                        }
                    } // MenuItem (secondary ability)

                    MenuItem {
                        id: menuItemHiddenAbility

                        height: visible ? menuItemPrimaryAbility.height : 0
                        visible: moveAttributeAbility.hiddenAbilityId > 0
                        enabled: visible
                        Material.accent: Material.Amber
                        Material.foreground: menuItemHiddenAbility.Material.accent
                        icon.source: "qrc:/images/icons/actions/report.svg"
                        text: moveAttributeAbility.hiddenAbilityId > 0 ? modelAbilities.getAbilityData(moveAttributeAbility.hiddenAbilityId, Backend.ModelAbilities.NameRole) : "-"

                        onTriggered: {
                            abilityId = moveAttributeAbility.hiddenAbilityId
                        }

                        ToolButton {
                            id: toolButtonShowHiddenAbilityDetails

                            x: parent.width - width
                            y: (parent.height - height)/2
                            icon.source: "qrc:/images/icons/actions/visibility_on.svg"
                            opacity: 0.5

                            onClicked: {
                                menuAvailableAbilities.close()
                                pageAbilityDetails.abilityId = moveAttributeAbility.hiddenAbilityId
                                pageAbilityDetails.name = modelAbilities.getAbilityData(moveAttributeAbility.hiddenAbilityId, Backend.ModelAbilities.NameRole)
                                pageAbilityDetails.gameDescription = modelAbilities.getAbilityData(moveAttributeAbility.hiddenAbilityId, Backend.ModelAbilities.FlavorTextRole)
                                pageAbilityDetails.detailedDescription = modelAbilities.getAbilityData(moveAttributeAbility.hiddenAbilityId, Backend.ModelAbilities.DetailedEffectRole)
                                pageAbilityDetails.nativeGeneration = modelAbilities.getAbilityData(moveAttributeAbility.hiddenAbilityId, Backend.ModelAbilities.GenerationRole)
                                stackView.push(pageAbilityDetails)
                            }
                        }
                    } // MenuItem (hidden ability)
                } // Menu (available abilities)
            } // MoveAttribute (ability)


            //! Item

            Label {
                id: labelItem

                x: labelAbility.x
                y: moveAttributeAbility.y + moveAttributeAbility.height + 6
                width: parent.width - x - 6

                enabled: speciesId > 0 && pokemonId > 0
                text: qsTr("Item")
                font.italic: true
            }

            RectangleSeparator {
                id: rectangleSeparatorItem

                x: labelItem.x
                y: labelItem.y + labelItem.height + 2
                width: labelItem.width
                height: 1

                stayInterval: 0.2
                leaveInterval: 0.2
                alignment: Qt.AlignLeft
            }

            MoveAttribute {
                id: moveAttributeItem

                x: labelItem.x
                y: rectangleSeparatorItem.y + rectangleSeparatorItem.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                border.color: enabled ? (Material.theme === Material.Light ? "#333333" : "#FFFFFF") : Material.hintTextColor
                color: "transparent"
                iconColor: "transparent"
                nameWidth: height
                attributeValue: itemId > 0 ? modelItems.getItemData(itemId, Backend.ModelItems.NameRole) : qsTr("None")
                iconSource: "qrc:/images/items/items-icons/" + itemId + ".png"

                onClicked: {
                    pageSimpleItemSelection.searchFilter = ""
                    pageSimpleItemSelection.currentIndex = itemId
                    stackView.push(pageSimpleItemSelection)
                }
            } // MoveAttribute (item)


            //! Gender and shinyness

            Label {
                id: labelGenderAndShinyness

                x: itemDelegatePokemon.x
                y: toolButtonPreviousForm.y + toolButtonPreviousForm.height
                width: parent.width - x - 6

                enabled: speciesId > 0 && pokemonId > 0
                text: qsTr("Gender and shinyness")
                font.italic: true
            }

            RectangleSeparator {
                id: rectangleSeparatorGenderAndShinyness

                x: labelGenderAndShinyness.x
                y: labelGenderAndShinyness.y + labelGenderAndShinyness.height + 2
                width: labelGenderAndShinyness.width
                height: 1

                stayInterval: 0.2
                leaveInterval: 0.2
                alignment: Qt.AlignLeft
            }

            MoveAttribute {
                id: moveAttributeShinyness

                x: itemDelegatePokemon.x
                y: rectangleSeparatorGenderAndShinyness.y + rectangleSeparatorGenderAndShinyness.height + 6
                width: parent.width/2 - x - 3
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                Material.accent: shiny ? Material.Amber : parent.Material.accent
                Material.foreground: shiny ? Material.accent : parent.Material.foreground
                border.color: enabled ? (shiny ? Material.accent : (Material.theme === Material.Light ? "#333333" : "#FFFFFF")) : Material.hintTextColor
                color: "transparent"
                iconColor: Material.dialogColor
                nameWidth: height
                attributeValue: qsTr("Shiny")
                iconSource: "qrc:/images/icons/toggle/star_" + (shiny ? "on" : "off") + ".svg"

                onClicked: {
                    shiny = !shiny
                }
            } // MoveAttribute (shinyness)

            MoveAttribute {
                id: moveAttributeGender

                readonly property int genderRateId: pokemonId > 0 ? modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.GenderRateIdRole) : -1

                x: moveAttributeShinyness.x + moveAttributeShinyness.width + 6
                y: moveAttributeShinyness.y
                width: moveAttributeShinyness.width
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                Material.accent: (genderId > 1 ? Material.Green : (genderId === 1 ? Material.Pink : Material.Blue))
                Material.foreground: Material.accent
                border.color: enabled ? Material.accent : Material.hintTextColor
                color: "transparent"
                iconColor: Material.dialogColor
                nameWidth: height
                attributeValue: (genderId > 1 ? qsTr("Genderless") : (genderId === 1 ? qsTr("Female") : qsTr("Male")))
                iconSource: "qrc:/images/icons/user/gender" + (genderId > 1 ? "less" : (genderId === 1 ? "_female" : "_male")) + ".svg"
                iconSize: height - 4

                onClicked: {
                    if (genderRateId > 0 && genderRateId < 8) {
                        genderId = genderId === 0 ? 1 : 0
                    }
                }
            } // MoveAttribute (gender)


            //! Moves

            Label {
                id: labelMoves

                x: labelGenderAndShinyness.x
                y: moveAttributeShinyness.y + moveAttributeShinyness.height + 6
                width: parent.width - x - 6

                enabled: speciesId > 0 && pokemonId > 0
                text: qsTr("Moves")
                font.italic: true
            }

            RectangleSeparator {
                id: rectangleSeparatorMoves

                x: labelMoves.x
                y: labelMoves.y + labelMoves.height + 2
                width: labelMoves.width
                height: 1

                stayInterval: 0.2
                leaveInterval: 0.2
                alignment: Qt.AlignLeft
            }

            MoveAttribute {
                id: moveAttributeMove1

                x: labelMoves.x
                y: rectangleSeparatorMoves.y + rectangleSeparatorMoves.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                border.color: enabled ? (Material.theme === Material.Light ? "#333333" : "#FFFFFF") : Material.hintTextColor
                color: "transparent"
                iconColor: "transparent"
                nameWidth: height
                attributeValue: move1Id > 0 ? modelMoves.getMoveData(move1Id, Backend.ModelMoves.NameRole) : qsTr("None")
                iconSource: "qrc:/images/types/types/icons/" + (modelMoves.getMoveData(move1Id, Backend.ModelMoves.TypeRole)) + ".svg"
                iconSize: height - 4

                onClicked: {
                    pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)
                    pageSimpleMoveSelection.searchFilter = ""
                    pageSimpleMoveSelection.currentIndex = move1Id
                    pageSimpleMoveSelection.moveOrder = 1
                    stackView.push(pageSimpleMoveSelection)
                }
                onPressAndHold: move1Id = 0
            } // MoveAttribute (move 1)

            MoveAttribute {
                id: moveAttributeMove2

                x: labelMoves.x
                y: moveAttributeMove1.y + moveAttributeMove1.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                border.color: enabled ? (Material.theme === Material.Light ? "#333333" : "#FFFFFF") : Material.hintTextColor
                color: "transparent"
                iconColor: "transparent"
                nameWidth: height
                attributeValue: move2Id > 0 ? modelMoves.getMoveData(move2Id, Backend.ModelMoves.NameRole) : qsTr("None")
                iconSource: "qrc:/images/types/types/icons/" + (modelMoves.getMoveData(move2Id, Backend.ModelMoves.TypeRole)) + ".svg"
                iconSize: height - 4

                onClicked: {
                    if (pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection !== modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)) {
                        pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)
                    }
                    pageSimpleMoveSelection.searchFilter = ""
                    pageSimpleMoveSelection.currentIndex = move2Id
                    pageSimpleMoveSelection.moveOrder = 2
                    stackView.push(pageSimpleMoveSelection)
                }
                onPressAndHold: move2Id = 0
            } // MoveAttribute (move 2)

            MoveAttribute {
                id: moveAttributeMove3

                x: labelMoves.x
                y: moveAttributeMove2.y + moveAttributeMove2.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                border.color: enabled ? (Material.theme === Material.Light ? "#333333" : "#FFFFFF") : Material.hintTextColor
                color: "transparent"
                iconColor: "transparent"
                nameWidth: height
                attributeValue: move3Id > 0 ? modelMoves.getMoveData(move3Id, Backend.ModelMoves.NameRole) : qsTr("None")
                iconSource: "qrc:/images/types/types/icons/" + (modelMoves.getMoveData(move3Id, Backend.ModelMoves.TypeRole)) + ".svg"
                iconSize: height - 4

                onClicked: {
                    if (pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection !== modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)) {
                        pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)
                    }
                    pageSimpleMoveSelection.searchFilter = ""
                    pageSimpleMoveSelection.currentIndex = move3Id
                    pageSimpleMoveSelection.moveOrder = 3
                    stackView.push(pageSimpleMoveSelection)
                }
                onPressAndHold: move3Id = 0
            } // MoveAttribute (move 3)

            MoveAttribute {
                id: moveAttributeMove4

                x: labelMoves.x
                y: moveAttributeMove3.y + moveAttributeMove3.height + 6
                width: parent.width - x - 6
                height: 24

                enabled: speciesId > 0 && pokemonId > 0
                interactive: true
                radius: 4
                border.color: enabled ? (Material.theme === Material.Light ? "#333333" : "#FFFFFF") : Material.hintTextColor
                color: "transparent"
                iconColor: "transparent"
                nameWidth: height
                attributeValue: move4Id > 0 ? modelMoves.getMoveData(move4Id, Backend.ModelMoves.NameRole) : qsTr("None")
                iconSource: "qrc:/images/types/types/icons/" + (modelMoves.getMoveData(move4Id, Backend.ModelMoves.TypeRole)) + ".svg"
                iconSize: height - 4

                onClicked: {
                    if (pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection !== modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)) {
                        pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.MovesRole)
                    }
                    pageSimpleMoveSelection.searchFilter = ""
                    pageSimpleMoveSelection.currentIndex = move4Id
                    pageSimpleMoveSelection.moveOrder = 4
                    stackView.push(pageSimpleMoveSelection)
                }
                onPressAndHold: move4Id = 0
            } // MoveAttribute (move 4)

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
        } // Flickable (main details)

        Flickable {
            id: flickableStatDetails

            enabled: speciesId > 0 && pokemonId > 0
            contentHeight: statsEditor.height

            StatsEditor {
                id: statsEditor

                readonly property var baseStats: enabled ? modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.BaseStatsRole) : [0, 0, 0, 0, 0, 0]

                x: 4
                y: 6
                width: parent.width - 2*x

                simpleMode: false
                baseHp: ~~baseStats[0]
                baseAttack: ~~baseStats[1]
                baseDefense: ~~baseStats[2]
                baseSpecialAttack: ~~baseStats[3]
                baseSpecialDefense: ~~baseStats[4]
                baseSpeed: ~~baseStats[5]
            }

            ScrollBar.vertical: ScrollBar {
                id: scrollBar2

                padding: 2
                contentItem: Rectangle {
                    implicitWidth: 6
                    implicitHeight: 6
                    radius: width/2

                    color: scrollBar2.pressed ? scrollBar2.Material.scrollBarPressedColor :
                           scrollBar2.interactive && scrollBar2.hovered ? scrollBar2.Material.scrollBarHoveredColor : scrollBar2.Material.scrollBarColor
                    opacity: 0.0
                }

                background: Rectangle {
                    implicitWidth: 6
                    implicitHeight: 6
                    color: "#0e000000"
                    opacity: 0.0
                }
            }
        } // Flickable (stat details)
    } // SwipeView

    Dialogs.TextEditDialog {
        id: textEditDialogChangeNickname

        x: (parent.width - width)/2
        y: (parent.height - height)/2
        width: implicitWidth > applicationWindow.width - 40 ? applicationWindow.width - 40 : implicitWidth
        height: implicitHeight > applicationWindow.height - 40 ? applicationWindow.height - 40 : implicitHeight

        modal: true
        focus: visible

        title: qsTr("Nickname")

        onAccepted: {
            nickname = text
        }
    }
}
