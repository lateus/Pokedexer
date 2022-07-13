import QtQuick 2.15
import QtQuick.Controls 2.15

import Pokedexer 1.0 as Backend

Item {
    id: applicationWindowContent

    property alias pokedexSearchFilter: pagePokedex.searchFilter
    property alias movedexSearchFilter: pageMovedex.searchFilter
    property alias abilitydexSearchFilter: pageAbilitydex.searchFilter
    property alias itemdexSearchFilter: pageItemdex.searchFilter
    property alias berrydexSearchFilter: pageBerrydex.searchFilter
    property alias typedexSearchFilter: pageTypedex.searchFilter
    property alias naturedexSearchFilter: pageNaturedex.searchFilter
    property alias simplePokemonSelectionFilter: pageSimplePokemonSelection.searchFilter
    property alias simpleMoveSelectionFilter: pageSimpleMoveSelection.searchFilter
    property alias simpleItemSelectionFilter: pageSimpleItemSelection.searchFilter

    property alias pokemonMovesSearchFilter: pagePokemonDetails.searchFilterPokemonMoves

    property alias modelPokemon: pagePokedex.modelPokemon
    property alias modelMoves: pageMovedex.modelMoves
    property alias modelAbilities: pageAbilitydex.modelAbilities
    property alias modelItems: pageItemdex.modelItems
    property alias modelBerries: pageBerrydex.modelBerries
    property alias modelTypes: pageTypedex.modelTypes
    property alias modelNatures: pageNaturedex.modelNatures
    property alias modelPokemonTeams: pageTeamEditor.modelPokemonTeams
    property alias modelPokemonForSimplePokemonSelection: pageSimplePokemonSelection.modelPokemonForSimplePokemonSelection
    property alias modelPokemonMovesForSimpleMoveSelection: pageSimpleMoveSelection.modelPokemonMovesForSimpleMoveSelection
    property alias modelItemsForSimpleItemSelection: pageSimpleItemSelection.modelItemsForSimpleItemSelection

    readonly property alias stackViewDepth: stackView.depth

    readonly property bool pagePokedexIsActive: stackView.currentItem === pagePokedex
    readonly property bool pageMovedexIsActive: stackView.currentItem === pageMovedex
    readonly property bool pageAbilitydexIsActive: stackView.currentItem === pageAbilitydex
    readonly property bool pageItemdexIsActive: stackView.currentItem === pageItemdex
    readonly property bool pageBerrydexIsActive: stackView.currentItem === pageBerrydex
    readonly property bool pageTypedexIsActive: stackView.currentItem === pageTypedex
    readonly property bool pageNaturedexIsActive: stackView.currentItem === pageNaturedex
    readonly property bool pageLocationdexIsActive: stackView.currentItem === pageLocationdex
    readonly property bool pageTeamEditorIsActive: stackView.currentItem === pageTeamEditor
//    readonly property bool pageAboutIsActive: stackView.currentItem === pageAbout
//    readonly property bool pageAboutQtIsActive: stackView.currentItem === pageAboutQt
//    readonly property bool pageAboutLicenseIsActive: stackView.currentItem === pageAboutLicense

    readonly property bool pagePokemonDetailsIsActive: stackView.currentItem === pagePokemonDetails
    readonly property bool pageMoveDetailsIsActive: stackView.currentItem === pageMoveDetails
    readonly property bool pageAbilityDetailsIsActive: stackView.currentItem === pageAbilityDetails
    readonly property bool pageItemDetailsIsActive: stackView.currentItem === pageItemDetails
    readonly property bool pageTypeDetailsIsActive: stackView.currentItem === pageTypeDetails
    readonly property bool pageTypePerformanceIsActive: stackView.currentItem === pageTypePerformance
    readonly property bool pageTypeChartIsActive: stackView.currentItem === pageTypeChart
    readonly property bool pageNatureChartIsActive: stackView.currentItem === pageNatureChart
    readonly property bool pageTeamDetailsIsActive: stackView.currentItem === pageTeamDetails
    readonly property bool pageTeamPokemonDetailsIsActive: stackView.currentItem === pageTeamPokemonDetails

    readonly property bool pageSimplePokemonSelectionIsActive: stackView.currentItem === pageSimplePokemonSelection
    readonly property bool pageSimpleMoveSelectionIsActive: stackView.currentItem === pageSimpleMoveSelection
    readonly property bool pageSimpleItemSelectionIsActive: stackView.currentItem === pageSimpleItemSelection

    readonly property alias pagePokemonDetailsCurrentTabIndex: pagePokemonDetails.currentTabIndex
    readonly property alias pageTeamDetailsCurrentTeamName: pageTeamDetails.teamName
    readonly property alias pageTeamDetailsUnsavedChanges: pageTeamDetails.unsavedChanges

    function pop() {
        stackView.pop()
    }

    function showPokedexPage() {
        stackView.pop(null)
        stackView.replace(pagePokedex)
    }

    function showMovedexPage() {
        stackView.pop(null)
        stackView.replace(pageMovedex)
    }

    function showAbilitiesPage() {
        stackView.pop(null)
        stackView.replace(pageAbilitydex)
    }

    function showItemsPage() {
        stackView.pop(null)
        stackView.replace(pageItemdex)
    }

    function showBerriesPage() {
        stackView.pop(null)
        stackView.replace(pageBerrydex)
    }

    function showTypesPage() {
        stackView.pop(null)
        stackView.replace(pageTypedex)
    }

    function showNaturesPage() {
        stackView.pop(null)
        stackView.replace(pageNaturedex)
    }

    function showLocationsPage() {
        stackView.pop(null)
        stackView.replace(pageLocationdex)
    }

    function showTeamBuilderPage() {
        stackView.pop(null)
        stackView.replace(pageTeamEditor)
    }

    function showAboutPage() {
        stackView.push(componentPageAbout)
    }

    function showAboutQtPage() {
        stackView.push(componentPageAboutQt)
    }

    function showAboutLicensePage() {
        stackView.push(componentPageAboutLicense)
    }

    PagePokedex {
        id: pagePokedex
    }

    PageMovedex {
        id: pageMovedex
    }

    PageAbilitydex {
        id: pageAbilitydex
    }

    PageItemdex {
        id: pageItemdex
    }

    PageBerrydex {
        id: pageBerrydex
    }

    PageTypedex {
        id: pageTypedex
        clip: true
    }

    PageNaturedex {
        id: pageNaturedex
    }

    Page {
        id: pageLocationdex

        Label {
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            text: qsTr("Not yet implemented")
        }
    }

    PageTeamEditor {
        id: pageTeamEditor
    }

    Component {
        id: componentPageAbout
        PageAbout {
            id: pageAbout

            onLicenseRequested: {
                stackView.push(componentPageAboutLicense)
            }
        }
    }

    Component {
        id: componentPageAboutQt
        PageAboutQt {
            id: pageAboutQt
        }
    }

    Component {
        id: componentPageAboutLicense
        PageAboutLicense {
            id: pageAboutLicense
        }
    }

    // Detailed views

    PagePokemonDetails {
        id: pagePokemonDetails
    }

    PageMoveDetails {
        id: pageMoveDetails
    }

    PageAbilityDetails {
        id: pageAbilityDetails
    }

    PageItemDetails {
        id: pageItemDetails
    }

    PageBerryDetails {
        id: pageBerryDetails
    }

    PageTypeDetails {
        id: pageTypeDetails
    }

    PageTypePerformance {
        id: pageTypePerformance
    }

    PageTypeChart {
        id: pageTypeChart
    }

    PageNatureChart {
        id: pageNatureChart
    }

    PageTeamDetails {
        id: pageTeamDetails
    }

    PageTeamPokemonDetails {
        id: pageTeamPokemonDetails
    }

    PageSimplePokemonSelection {
        id: pageSimplePokemonSelection
    }

    PageSimpleMoveSelection {
        id: pageSimpleMoveSelection
    }

    PageSimpleItemSelection {
        id: pageSimpleItemSelection
    }

    StackView {
        id: stackView

        width: parent.width
        height: parent.height

        initialItem: pagePokedex
        background: Rectangle {
            color: applicationWindow.color
        }
    }
}
