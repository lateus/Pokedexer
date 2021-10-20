import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pagePokemonDetails

    property string searchFilterPokemonMoves
    onSearchFilterPokemonMovesChanged: {
        moves.filter = searchFilterPokemonMoves
    }

    property int pokemonId
    property int speciesId

    property string name
    property string genusName
    property string gameDescription
    property string description
    property int nativeGeneration
    property bool isDefault

    property int genderRateId
    property int captureRate
    property int baseHappiness
    property bool isBaby
    property int hatchCounter
    property bool hasGenderDifferences
    property bool formsSwitchable
    property int growthRateId

    property int primaryType
    property int secondaryType

    property int pokemonHeight
    property int pokemonWeight

    property int baseExperience
    property int baseHp
    property int baseAtk
    property int baseDef
    property int baseSpAtk
    property int baseSpDef
    property int baseSpd

    property int primaryAbility
    property int secondaryAbility
    property int hiddenAbility

    property int colorId
    property int shapeId

    property int primaryEggGroup
    property int secondaryEggGroup
    property int evolutionChainId

    property alias moves: listViewPokemonMoves.model
    readonly property alias movesCount: listViewPokemonMoves.count
    property alias forms: pathViewForms.model
    readonly property alias formsCount: pathViewForms.count

    property bool shiny: toolButtonShiny.checked && toolButtonShiny.visible
    property bool female: toolButtonGender.female && toolButtonGender.visible
    property alias currentTabIndex: tabBarPokemonDetails.currentIndex

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (pokemonId > 0) {
                name = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole)
                genusName = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.GenusNameRole)
                gameDescription = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.SpeciesFlavorTextRole)
                description = modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.SpeciesDescriptionRole)
                moves.currentLanguage = applicationLanguageId
                forms.currentLanguage = applicationLanguageId
            }
        }
    }

    header: TabBar {
        id: tabBarPokemonDetails

        TabButton {
            icon.source: "qrc:/images/icons/others/pokeball.svg"
        }
        TabButton {
            icon.source: "qrc:/images/icons/others/sword.svg"
        }
        TabButton {
            icon.source: "qrc:/images/icons/user/info.svg"
        }

        background: Rectangle {
            color: applicationWindow.Material.dialogColor
        }
    }

    SwipeView {
        width: parent.width
        height: parent.height

        interactive: false
        currentIndex: tabBarPokemonDetails.currentIndex

        Flickable {
            id: flickable

            contentHeight: labelPokemonName.height + labelPokemonGenusName.height + rectangleSeparator.height + pageIndicatorForms.height + rectangleIcon.height + itemDelegateTypes.height + rectangleAbilities.height + rectangleStats.height + 120

            Label {
                id: labelPokemonName

                y: 12
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: Qt.application.font.pointSize * 1.2
                font.bold: true
                elide: Text.ElideRight
                text: pagePokemonDetails.name
                textFormat: Text.PlainText
            }

            Label {
                id: labelPokemonGenusName

                y: labelPokemonName.y + labelPokemonName.height
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: Qt.application.font.pointSize * 0.8
                font.italic: true
                elide: Text.ElideRight
                text: pagePokemonDetails.genusName
                textFormat: Text.PlainText
            }

            RectangleSeparator {
                id: rectangleSeparator
                y: labelPokemonGenusName.y + labelPokemonGenusName.height + 6
            }

            PageIndicator {
                id: pageIndicatorForms

                x: (parent.width - width)/2
                y: rectangleSeparator.y + rectangleSeparator.height + 6
                width: implicitWidth > parent.width ? parent.width : implicitWidth

                count: pathViewForms.count
                visible: count > 1
                interactive: true
                currentIndex: pathViewForms.currentIndex

                delegate: Rectangle {
                    implicitWidth: 8
                    implicitHeight: 8

                    width: pageIndicatorForms.implicitWidth > pageIndicatorForms.width ? (pageIndicatorForms.width/pageIndicatorForms.count - pageIndicatorForms.spacing) : implicitWidth
                    height: width
                    radius: width / 2
                    color: pageIndicatorForms.enabled ? pageIndicatorForms.Material.foreground : pageIndicatorForms.Material.hintTextColor

                    opacity: index === pageIndicatorForms.currentIndex ? 0.95 : pressed ? 0.7 : 0.45
                    Behavior on opacity { OpacityAnimator { duration: 100 } }
                }
            }

            // Icon
            Rectangle {
                id: rectangleIcon

                x: (parent.width - width)/2
                y: pageIndicatorForms.y + pageIndicatorForms.height + 24
                width: 120
                height: width

                color: Material.dialogColor
                radius: width/2

                PathView {
                    id: pathViewForms
                    x: (parent.width - width)/2
                    y: (parent.height - height)/2
                    height: 120
                    width: pagePokemonDetails.width + 60

                    currentIndex: pageIndicatorForms.currentIndex
                    onCurrentIndexChanged: {
                        pagePokemonDetails.pokemonId = modelPokemon.getPokemonData(pagePokemonDetails.forms.getPokemonFormData(currentIndex, Backend.ModelPokemonForms.PokemonIdRole), Backend.ModelPokemon.IdRole)
                        pagePokemonDetails.speciesId = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.SpeciesIdRole)

                        pagePokemonDetails.name = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.NameRole)
                        pagePokemonDetails.gameDescription = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.SpeciesFlavorTextRole)
                        pagePokemonDetails.description = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.SpeciesDescriptionRole)
                        pagePokemonDetails.nativeGeneration = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.GenerationRole)
                        pagePokemonDetails.isDefault = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.IsDefaultRole)

                        pagePokemonDetails.genderRateId = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.GenderRateIdRole)
                        pagePokemonDetails.captureRate = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.CaptureRateRole)
                        pagePokemonDetails.baseHappiness = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseHappinessRole)
                        pagePokemonDetails.isBaby = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.IsBabyRole)
                        pagePokemonDetails.hatchCounter = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.HatchCounterRole)
                        pagePokemonDetails.hasGenderDifferences = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.HasGenderDifferencesRole)
                        pagePokemonDetails.formsSwitchable = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.FormsSwitchableRole)
                        pagePokemonDetails.growthRateId = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.GrowthRateIdRole)

                        pagePokemonDetails.primaryType = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.PrimaryTypeRole)
                        pagePokemonDetails.secondaryType = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.SecondaryTypeRole)

                        pagePokemonDetails.pokemonHeight = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.HeightRole)
                        pagePokemonDetails.pokemonWeight = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.WeightRole)

                        pagePokemonDetails.baseExperience = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseExperienceRole)
                        pagePokemonDetails.baseHp = ~~modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseStatsRole)[0]
                        pagePokemonDetails.baseAtk = ~~modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseStatsRole)[1]
                        pagePokemonDetails.baseDef = ~~modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseStatsRole)[2]
                        pagePokemonDetails.baseSpAtk = ~~modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseStatsRole)[3]
                        pagePokemonDetails.baseSpDef = ~~modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseStatsRole)[4]
                        pagePokemonDetails.baseSpd = ~~modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.BaseStatsRole)[5]

                        pagePokemonDetails.primaryAbility = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.PrimaryAbilityRole)
                        pagePokemonDetails.secondaryAbility = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.SecondaryAbilityRole)
                        pagePokemonDetails.hiddenAbility = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.HiddenAbilityRole)

                        pagePokemonDetails.colorId = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.ColorRole)
                        pagePokemonDetails.shapeId = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.ShapeRole)

                        pagePokemonDetails.primaryEggGroup = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.PrimaryEggGroupRole)
                        pagePokemonDetails.secondaryEggGroup = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.SecondaryEggGroupRole)
                        pagePokemonDetails.evolutionChainId = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.EvolutionChainIdRole)

                        // It's there a pokemon that learns a totally different move when changes form?
                        // Uncomments the lines bellow if so:
                        // pagePokemonDetails.moves = modelPokemon.getPokemonData(pagePokemonDetails.pokemonId, Backend.ModelPokemon.MovesRole)
                        // console.log("MovesCount", pagePokemonDetails.movesCount)
                    }

                    model: pagePokemonDetails.forms
                    delegate: Image {
                        id: imagePokemonForm
                        width: 120
                        height: 120
                        source: "qrc:/images/sprites/pokemon/3ds/" + (pagePokemonDetails.shiny ? "shiny" : "normal") + (pagePokemonDetails.female && order === 1 ? "/female/" : "/") + pagePokemonDetails.speciesId + (pagePokemonDetails.speciesId > 0 ? ("-" + order) : "") + ".png"

                        scale: PathView.iconScale ? PathView.iconScale : 1
                        opacity: PathView.iconOpacity ? PathView.iconOpacity : 1
                        z: PathView.iconOrder ? PathView.iconOrder : 0

                        Label {
                            x: (parent.width - width)/2
                            y: parent.height - height/2

                            text: name
                            font.pointSize: Qt.application.font.pointSize
                            font.bold: true
                            textFormat: Text.PlainText
                        }
                    }

                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    highlightRangeMode: PathView.StrictlyEnforceRange
                    pathItemCount: 3
                    dragMargin: 20
                    interactive: count > 1
                    path: Path {
                        startX: 0; startY: pathViewForms.height/2
                        PathAttribute { name: "iconScale"; value: 0.1 }
                        PathAttribute { name: "iconOpacity"; value: 0 }
                        PathAttribute { name: "iconOrder"; value: 0 }
                        PathLine { x: pathViewForms.width/2; y: pathViewForms.height/2 }
                        PathAttribute { name: "iconScale"; value: 1 }
                        PathAttribute { name: "iconOpacity"; value: 1 }
                        PathAttribute { name: "iconOrder"; value: pathViewForms.pathItemCount + 1 }
                        PathLine { x: pathViewForms.width; y: pathViewForms.height/2 }
                    }
                } // PathView (forms)

                ToolButton {
                    id: toolButtonShiny

                    x: -width/2
                    y: -height/2

                    checkable: true
                    highlighted: true
                    Material.accent: Material.Amber
                    icon.source: "qrc:/images/icons/toggle/star_" + (checked ? "on" : "off") + ".svg"
                }

                ToolButton {
                    id: toolButtonGender

                    property bool female

                    x: toolButtonShiny.x
                    y: toolButtonShiny.y + toolButtonShiny.height/2 + 4

                    visible: pagePokemonDetails.hasGenderDifferences && pathViewForms.currentIndex === 0
                    highlighted: true
                    Material.accent: female ? Material.Pink : Material.Blue
                    icon.source: "qrc:/images/icons/user/gender_" + (female && visible ? "female" : "male") + ".svg"

                    onClicked: {
                        female = !female
                    }
                }
            } // Rectangle (icon)

            ItemDelegate {
                id: itemDelegateTypes

                y: rectangleIcon.y + rectangleIcon.height + 5
                width: parent.width

                TypeTag {
                    id: typeTagPokemonDetailsPrimaryType

                    x: typeTagPokemonDetailsSecondaryType.visible ? parent.width/2 - width : (parent.width - width)/2
                    y: (parent.height - height)/2

                    type: pagePokemonDetails.primaryType
                    source: "qrc:/images/types/types/tags/" + type + ".svg"
                }

                TypeTag {
                    id: typeTagPokemonDetailsSecondaryType

                    x: typeTagPokemonDetailsPrimaryType.x + typeTagPokemonDetailsPrimaryType.width
                    y: typeTagPokemonDetailsPrimaryType.y

                    type: pagePokemonDetails.secondaryType
                    visible: type > 0
                    source: "qrc:/images/types/types/tags/" + type + ".svg"
                }

                onClicked: {
                    pageTypePerformance.type1 = typeTagPokemonDetailsPrimaryType.type - 1
                    pageTypePerformance.type2 = typeTagPokemonDetailsSecondaryType.type
                    pageTypePerformance.readonly = true

                    stackView.push(pageTypePerformance)
                }
            }

            // Abilities
            Rectangle {
                id: rectangleAbilities

                x: 12
                y: itemDelegateTypes.y + itemDelegateTypes.height + 24
                width: parent.width - 2*x
                height: _labelPokemonDetailsAbilities.height + itemAttributePrimaryAbility.height + itemAttributeSecondaryAbility.height + itemAttributeHiddenAbility.height + 30

                color: Material.dialogColor
                radius: 12
                clip: true

                Label {
                    id: _labelPokemonDetailsAbilities

                    x: (parent.width - width)/2
                    y: 6
                    width: 220

                    horizontalAlignment: Text.AlignHCenter

                    text: qsTr("Abilities")
                    font.bold: true
                    textFormat: Text.PlainText
                }

                MoveAttribute {
                    id: itemAttributePrimaryAbility

                    x: (parent.width - width)/2
                    y: _labelPokemonDetailsAbilities.y + _labelPokemonDetailsAbilities.height + 6
                    width: _labelPokemonDetailsAbilities.width
                    height: 20

                    radius: 4
                    border.color: Material.theme === Material.Light ? "#333333" : "#FFFFFF"
                    color: "transparent"
                    nameWidth: width/2
                    attributeName: qsTr("Primary")
                    attributeValue: pagePokemonDetails.primaryAbility > 0 && applicationWindow.applicationLanguageId >= 0 ? modelAbilities.getAbilityData(pagePokemonDetails.primaryAbility, Backend.ModelAbilities.NameRole) : "-"
                    iconSource: "qrc:/images/icons/numbers/1_fill.svg"
                    interactive: true

                    onClicked: {
                        pageAbilityDetails.abilityId = pagePokemonDetails.primaryAbility
                        pageAbilityDetails.name = modelAbilities.getAbilityData(pagePokemonDetails.primaryAbility, Backend.ModelAbilities.NameRole)
                        pageAbilityDetails.gameDescription = modelAbilities.getAbilityData(pagePokemonDetails.primaryAbility, Backend.ModelAbilities.FlavorTextRole)
                        pageAbilityDetails.detailedDescription = modelAbilities.getAbilityData(pagePokemonDetails.primaryAbility, Backend.ModelAbilities.DetailedEffectRole)
                        pageAbilityDetails.nativeGeneration = modelAbilities.getAbilityData(pagePokemonDetails.primaryAbility, Backend.ModelAbilities.GenerationRole)

                        stackView.push(pageAbilityDetails)
                    }
                }

                MoveAttribute {
                    id: itemAttributeSecondaryAbility

                    x: (parent.width - width)/2
                    y: itemAttributePrimaryAbility.y + itemAttributePrimaryAbility.height + (visible ? 5 : 0)
                    width: _labelPokemonDetailsAbilities.width
                    height: visible ? 20 : 0

                    visible: pagePokemonDetails.secondaryAbility > 0
                    radius: itemAttributePrimaryAbility.radius
                    border.color: itemAttributePrimaryAbility.border.color
                    color: itemAttributePrimaryAbility.color
                    nameWidth: itemAttributePrimaryAbility.nameWidth
                    attributeName: qsTr("Secondary")
                    attributeValue: pagePokemonDetails.secondaryAbility > 0 && applicationWindow.applicationLanguageId >= 0 ? modelAbilities.getAbilityData(pagePokemonDetails.secondaryAbility, Backend.ModelAbilities.NameRole) : "-"
                    iconSource: "qrc:/images/icons/numbers/2_fill.svg"
                    interactive: true

                    onClicked: {
                        pageAbilityDetails.abilityId = pagePokemonDetails.secondaryAbility
                        pageAbilityDetails.name = modelAbilities.getAbilityData(pagePokemonDetails.secondaryAbility, Backend.ModelAbilities.NameRole)
                        pageAbilityDetails.gameDescription = modelAbilities.getAbilityData(pagePokemonDetails.secondaryAbility, Backend.ModelAbilities.FlavorTextRole)
                        pageAbilityDetails.detailedDescription = modelAbilities.getAbilityData(pagePokemonDetails.secondaryAbility, Backend.ModelAbilities.DetailedEffectRole)
                        pageAbilityDetails.nativeGeneration = modelAbilities.getAbilityData(pagePokemonDetails.secondaryAbility, Backend.ModelAbilities.GenerationRole)

                        stackView.push(pageAbilityDetails)
                    }
                }

                MoveAttribute {
                    id: itemAttributeHiddenAbility

                    x: (parent.width - width)/2
                    y: itemAttributeSecondaryAbility.y + itemAttributeSecondaryAbility.height + (visible ? 5 : 0)
                    width: _labelPokemonDetailsAbilities.width
                    height: visible ? 20 : 0

                    visible: pagePokemonDetails.hiddenAbility > 0
                    radius: itemAttributePrimaryAbility.radius
                    Material.accent: Material.Amber
                    Material.foreground: Material.accent
                    border.color: Material.accentColor
                    color: itemAttributePrimaryAbility.color
                    nameWidth: itemAttributePrimaryAbility.nameWidth
                    attributeName: qsTr("Hidden")
                    attributeValue: pagePokemonDetails.hiddenAbility > 0 && applicationWindow.applicationLanguageId >= 0 ? modelAbilities.getAbilityData(pagePokemonDetails.hiddenAbility, Backend.ModelAbilities.NameRole) : "-"
                    iconSource: "qrc:/images/icons/actions/report.svg"
                    interactive: true

                    onClicked: {
                        pageAbilityDetails.abilityId = pagePokemonDetails.hiddenAbility
                        pageAbilityDetails.name = modelAbilities.getAbilityData(pagePokemonDetails.hiddenAbility, Backend.ModelAbilities.NameRole)
                        pageAbilityDetails.gameDescription = modelAbilities.getAbilityData(pagePokemonDetails.hiddenAbility, Backend.ModelAbilities.FlavorTextRole)
                        pageAbilityDetails.detailedDescription = modelAbilities.getAbilityData(pagePokemonDetails.hiddenAbility, Backend.ModelAbilities.DetailedEffectRole)
                        pageAbilityDetails.nativeGeneration = modelAbilities.getAbilityData(pagePokemonDetails.hiddenAbility, Backend.ModelAbilities.GenerationRole)

                        stackView.push(pageAbilityDetails)
                    }
                }
            } // Rectangle (abilities)

            // Stats
            Rectangle {
                id: rectangleStats

                x: 12
                y: rectangleAbilities.y + rectangleAbilities.height + 24
                width: parent.width - 2*x
                height: _labelPokemonDetailsStats.height + statsViewer.height + switchDelegateTestStats.height + 24
                color: Material.dialogColor
                radius: 12
                clip: true

                Label {
                    id: _labelPokemonDetailsStats

                    y: 6
                    width: parent.width

                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("Stats")
                    font.bold: true
                    textFormat: Text.PlainText
                }

                StatsViewer {
                    id: statsViewer

                    x: 6
                    y: _labelPokemonDetailsStats.y + _labelPokemonDetailsStats.height + 6
                    width: parent.width - 2*x
                    height: statsEditor.implicitHeight > implicitHeight ? statsEditor.implicitHeight : implicitHeight

                    contentVisible: !switchDelegateTestStats.checked

                    maxHpValue: 180
                    maxAttackValue: 180
                    maxDefenseValue: 180
                    maxSpecialAttackValue: 180
                    maxSpecialDefenseValue: 180
                    maxSpeedValue: 180

                    hpValue: pagePokemonDetails.baseHp
                    attackValue: pagePokemonDetails.baseAtk
                    defenseValue: pagePokemonDetails.baseDef
                    specialAttackValue: pagePokemonDetails.baseSpAtk
                    specialDefenseValue: pagePokemonDetails.baseSpDef
                    speedValue: pagePokemonDetails.baseSpd

                    Rectangle {
                        width: parent.width
                        height: parent.height

                        visible: switchDelegateTestStats.checked
                        color: rectangleStats.color

                        StatsEditor {
                            id: statsEditor
                            width: parent.width
                            height: parent.height

                            baseHp: pagePokemonDetails.baseHp
                            baseAttack: pagePokemonDetails.baseAtk
                            baseDefense: pagePokemonDetails.baseDef
                            baseSpecialAttack: pagePokemonDetails.baseSpAtk
                            baseSpecialDefense: pagePokemonDetails.baseSpDef
                            baseSpeed: pagePokemonDetails.baseSpd
                        }
                    }
                }

                SwitchDelegate {
                    id: switchDelegateTestStats

                    x: 6
                    y: statsViewer.y + statsViewer.height
                    width: parent.width - 2*x
                    text: qsTr("Test stats")
                }
            } // Rectangle (stats)

            ScrollIndicator.vertical: ScrollIndicator {
                x: parent.width - width
                height: parent.height
            }
        } // Flickable (basic pokemon details)

        ListView {
            id: listViewPokemonMoves

            headerPositioning: ListView.PullBackHeader
            header: Pane {
                id: paneHeader

                property int orderIndex: 1
                property bool ascendingOrder: true

                Binding { target: listViewPokemonMoves.model ? listViewPokemonMoves.model : null; property: "columnToSort"; value: paneHeader.orderIndex }
                Binding { target: listViewPokemonMoves.model ? listViewPokemonMoves.model : null; property: "sortOrder"; value: paneHeader.ascendingOrder ? Qt.AscendingOrder : Qt.DescendingOrder }

                z: 2 // above delegates
                width: parent.width
                height: 24
                padding: 0
                font.pointSize: Qt.application.font.pointSize * 0.75
                Material.elevation: 10

                ItemDelegate {
                    id: itemDelegateOrderByType

                    property bool orderActive: paneHeader.orderIndex === 0
                    property bool ascendingOrder: orderActive ? ascendingOrder : true

                    width: 69 // type tag width
                    height: paneHeader.height

                    font.bold: orderActive
                    text: (orderActive ? ascendingOrder ? "⏷ " : "⏶ " : "") + qsTr("Type")
                    padding: 0
                    leftPadding: 2
                    topInset: 0
                    bottomInset: 0
                    leftInset: 0
                    rightInset: 0

                    onClicked: {
                        if (orderActive) {
                            ascendingOrder = !ascendingOrder
                        }

                        paneHeader.orderIndex = 0
                        paneHeader.ascendingOrder = ascendingOrder
                    }
                } // Button (order by type)

                ItemDelegate {
                    id: itemDelegateOrderByName

                    property bool orderActive: paneHeader.orderIndex === 1
                    property bool ascendingOrder: orderActive ? true : true

                    x: itemDelegateOrderByType.width
                    width: itemDelegateOrderByPower.x - x // name width
                    height: paneHeader.height

                    font.bold: orderActive
                    text: (orderActive ? ascendingOrder ? "⏷ " : "⏶ " : "") + qsTr("Name")
                    padding: 0
                    leftPadding: 2
                    topInset: 0
                    bottomInset: 0
                    leftInset: 0
                    rightInset: 0

                    onClicked: {
                        if (orderActive) {
                            ascendingOrder = !ascendingOrder
                        }

                        paneHeader.orderIndex = 1
                        paneHeader.ascendingOrder = ascendingOrder
                    }
                } // Button (order by name)

                ItemDelegate {
                    id: itemDelegateOrderByPower

                    property bool orderActive: paneHeader.orderIndex === 2
                    property bool ascendingOrder: orderActive ? ascendingOrder : false

                    x: itemDelegateOrderByAccuracy.x - width
                    width: 36 // power width
                    height: paneHeader.height

                    font.bold: orderActive
                    text: (orderActive ? ascendingOrder ? "⏷ " : "⏶ " : "") + qsTr("Power")
                    padding: 0
                    leftPadding: 2
                    topInset: 0
                    bottomInset: 0
                    leftInset: 0
                    rightInset: 0

                    onClicked: {
                        if (orderActive) {
                            ascendingOrder = !ascendingOrder
                        }

                        paneHeader.orderIndex = 2
                        paneHeader.ascendingOrder = ascendingOrder
                    }
                } // ItemDelegate (order by power)

                ItemDelegate {
                    id: itemDelegateOrderByAccuracy

                    property bool orderActive: paneHeader.orderIndex === 3
                    property bool ascendingOrder: orderActive ? ascendingOrder : false

                    x: itemDelegateOrderByDamageClass.x - width
                    width: 46 // accuracy width
                    height: paneHeader.height

                    font.bold: orderActive
                    text: (orderActive ? ascendingOrder ? "⏷ " : "⏶ " : "") + qsTr("Accuracy")
                    padding: 0
                    leftPadding: 2
                    topInset: 0
                    bottomInset: 0
                    leftInset: 0
                    rightInset: 0

                    onClicked: {
                        if (orderActive) {
                            ascendingOrder = !ascendingOrder
                        }

                        paneHeader.orderIndex = 3
                        paneHeader.ascendingOrder = ascendingOrder
                    }
                } // ItemDelegate (order by accuracy)

                ItemDelegate {
                    id: itemDelegateOrderByDamageClass

                    property bool orderActive: paneHeader.orderIndex === 4
                    property bool ascendingOrder: orderActive ? ascendingOrder : false

                    x: paneHeader.width - width
                    width: 47 // damage class width
                    height: paneHeader.height

                    font.bold: orderActive
                    text: (orderActive ? ascendingOrder ? "⏷ " : "⏶ " : "") + qsTr("Class")
                    padding: 0
                    leftPadding: 2
                    topInset: 0
                    bottomInset: 0
                    leftInset: 0
                    rightInset: 0

                    onClicked: {
                        if (orderActive) {
                            ascendingOrder = !ascendingOrder
                        }

                        paneHeader.orderIndex = 4
                        paneHeader.ascendingOrder = ascendingOrder
                    }
                } // ItemDelegate (order by damage class)
            } // Pane (header)

            model: pagePokemonDetails.moves
            delegate: ItemDelegate {
                width: parent ? parent.width : 0
                rightPadding: 4

                TypeTag {
                    id: typeTagPokemonMove
                    y: (parent.height - height)/2
                    height: 26
                    type: modelMoves.getMoveData(moveId, Backend.ModelMoves.TypeRole)
                    source: "qrc:/images/types/types/tags/" + type + ".svg"
                }

                Label {
                    id: labelMoveName
                    x: typeTagPokemonMove.x + typeTagPokemonMove.width
                    y: (parent.height - height)/2
                    text: modelMoves.getMoveData(moveId, Backend.ModelMoves.NameRole)
                    textFormat: Text.PlainText
                }

                Label {
                    id: labelMovePower
                    x: labelMoveAccuracy.x - width - 6
                    y: (parent.height - height)/2
                    width: 30
                    text: modelMoves.getMoveData(moveId, Backend.ModelMoves.PowerRole) <= 0 ? "-" : modelMoves.getMoveData(moveId, Backend.ModelMoves.PowerRole)
                    horizontalAlignment: Text.AlignRight
                    textFormat: Text.PlainText
                }

                Label {
                    id: labelMoveAccuracy
                    x: labelMoveDamageClass.x - width - 6
                    y: (parent.height - height)/2
                    width: 40
                    text: modelMoves.getMoveData(moveId, Backend.ModelMoves.AccuracyRole) <= 0 ? "-" : (modelMoves.getMoveData(moveId, Backend.ModelMoves.AccuracyRole) + '%')
                    horizontalAlignment: Text.AlignRight
                    textFormat: Text.PlainText
                }

                Label {
                    id: labelMoveDamageClass

                    readonly property var damageClassName: [ qsTr("None"), qsTr("Status"), qsTr("Physical"), qsTr("Special") ]
                    readonly property var damageClassColor: [ "transparent", Material.Grey, Material.Red, Material.Indigo ]
                    readonly property int damageClassValue: modelMoves.getMoveData(moveId, Backend.ModelMoves.DamageClassRole)

                    x: parent.width - parent.rightPadding - width
                    y: (parent.height - height)/2
                    width: 40
                    leftPadding: 2
                    rightPadding: 2
                    Material.foreground: Material.dialogColor
                    text: damageClassName[damageClassValue]
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 8
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    textFormat: Text.PlainText

                    background: Rectangle {
                        Material.accent: labelMoveDamageClass.damageClassColor[labelMoveDamageClass.damageClassValue]
                        color: Material.accentColor
                        radius: 4
                    }

                    Label {
                        x: parent.width - 7
                        y: -height/2
                        width: 10
                        height: width

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        visible: modelMoves.getMoveData(moveId, Backend.ModelMoves.PriorityRole) > 0
                        Material.foreground: Material.dialogColor
                        text: "+" + modelMoves.getMoveData(moveId, Backend.ModelMoves.PriorityRole)
                        font.pixelSize: 8
                        background: Rectangle {
                            Material.accent: Material.Amber
                            color: Material.accentColor
                            radius: 3
                        }
                    }
                }

                onClicked: {
                    var regexp = /\n/gi // Remove all new lines
                    pageMoveDetails.moveId = modelMoves.getMoveData(moveId, Backend.ModelMoves.IdRole)
                    pageMoveDetails.learnMethodName = learnMethodName
                    pageMoveDetails.learnMethodDescription = learnMethodDescription
                    pageMoveDetails.learnLevel = level
                    pageMoveDetails.name = modelMoves.getMoveData(moveId, Backend.ModelMoves.NameRole)
                    pageMoveDetails.gameDescription = modelMoves.getMoveData(moveId, Backend.ModelMoves.FlavorTextRole).replace(regexp, ' ')
                    pageMoveDetails.detailedDescription = modelMoves.getMoveData(moveId, Backend.ModelMoves.DetailedEffectRole)
                    pageMoveDetails.power = modelMoves.getMoveData(moveId, Backend.ModelMoves.PowerRole)
                    pageMoveDetails.pp = modelMoves.getMoveData(moveId, Backend.ModelMoves.PpRole)
                    pageMoveDetails.accuracy = modelMoves.getMoveData(moveId, Backend.ModelMoves.AccuracyRole)
                    pageMoveDetails.priority = modelMoves.getMoveData(moveId, Backend.ModelMoves.PriorityRole)
                    pageMoveDetails.effectChance = modelMoves.getMoveData(moveId, Backend.ModelMoves.EffectChanceRole)
                    pageMoveDetails.damageClass = modelMoves.getMoveData(moveId, Backend.ModelMoves.DamageClassRole)
                    pageMoveDetails.target = modelMoves.getMoveData(moveId, Backend.ModelMoves.TargetRole)
                    pageMoveDetails.type = modelMoves.getMoveData(moveId, Backend.ModelMoves.TypeRole)
                    pageMoveDetails.contestType = modelMoves.getMoveData(moveId, Backend.ModelMoves.ContestTypeRole)
                    pageMoveDetails.contestEffect = modelMoves.getMoveData(moveId, Backend.ModelMoves.ContestEffectRole)
                    pageMoveDetails.superContestEffect = modelMoves.getMoveData(moveId, Backend.ModelMoves.SuperContestEffectRole)
                    pageMoveDetails.generation = modelMoves.getMoveData(moveId, Backend.ModelMoves.GenerationRole)

                    stackView.push(pageMoveDetails)
                }

            } // ItemDelegate

            ScrollIndicator.vertical: ScrollIndicator {
                x: parent.width - width
                height: parent.height
            }
        } // ListView (pokemon moves)

        Flickable {
            id: flickableDetailedInfo

            contentHeight: rectangleRelevantInformation.height + 32

            // Relevant information
            Rectangle {
                id: rectangleRelevantInformation

                x: 12
                y: 24
                width: parent.width - 2*x
                height: _labelPokemonRelevantInformation.height + labelPokemonDetailsRelevantInformation.height + 24
                color: Material.dialogColor
                radius: 12
                clip: true

                Label {
                    id: _labelPokemonRelevantInformation

                    y: 6
                    width: parent.width

                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("Relevant information")
                    font.bold: true
                    textFormat: Text.PlainText
                }

                Label {
                    id: labelPokemonDetailsRelevantInformation

                    x: 6
                    y: _labelPokemonRelevantInformation.y + _labelPokemonRelevantInformation.height + 5
                    width: parent.width - 2*x

                    enabled: pagePokemonDetails.description
                    horizontalAlignment: Text.AlignHCenter
                    text: pagePokemonDetails.description ? pagePokemonDetails.description : qsTr("Not available")
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                }
            } // Rectangle (relevant information)

            ScrollIndicator.vertical: ScrollIndicator {
                x: parent.width - width
                height: parent.height
            }
        } // Flickable (detailed info)
    } // SwipeView
}
