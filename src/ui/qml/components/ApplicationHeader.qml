import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Pane {
    id: applicationHeader

    property int selectedLanguage: ~~settings.value("language/id", 9) // 9 = english
    onSelectedLanguageChanged: {
        settings.setValue("language/id", selectedLanguage)
    }

    function goBack() {
        if (applicationWindow.stackViewIsOverfilled) {
            if (applicationWindowContent.pageTeamDetailsIsActive && applicationWindowContent.pageTeamDetailsUnsavedChanges) {
                if (applicationWindowContent.modelPokemonTeams.saveTeam(applicationWindowContent.pageTeamDetailsCurrentTeamName)) {
                    toolTipCenteredMessage.show(qsTr("Team saved."), 2000)
                }
            }

            applicationWindowContent.pop()
            if (applicationMenu.currentIndex > 9) {
                applicationMenu.currentIndex = applicationMenu.lastValidIndex
            }
            return true
        }
        return false
    }

    Material.background: applicationWindow.Material.dialogColor
    Material.elevation: 6

    Item {
        id: itemMenu
        y: -applicationHeader.topPadding
        x: -applicationHeader.leftPadding
        width: 100
        height: applicationHeader.height

        clip: true
        z: 1

        ToolButton {
            id: toolButtonMenu

            x: -10
            y: (parent.height - height)/2
            width: 70
            height: 70
            padding: 0
            topInset: 6
            bottomInset: 6
            leftInset: 6
            rightInset: 6

            icon.source: applicationWindow.stackViewIsOverfilled ? "qrc:/images/icons/arrows/arrow_back.svg" : "qrc:/images/icons/menu/menu.svg"

            onClicked: {
                if (!goBack()) {
                    applicationMenu.visible = !applicationMenu.visible
                }
            }
        } // ToolButton (menu)
    } // Item (menu)

    ToolButton {
        id: toolButtonLanguage

        readonly property var countriesByLanguage: [ qsTr("None"), qsTr("Japanese"), qsTr("Romaji"), qsTr("Korean"), qsTr("Chinese"), qsTr("French"), qsTr("Deutch"), qsTr("Spanish"), qsTr("Italian"), qsTr("English"), qsTr("Czech")]
        readonly property var flagsByLanguage: [ "", "japan", "japan", "south_korea", "china", "france", "germany", "spain", "italy", "united_states", "czech_republic"]

        y: (parent.height - height)/2
        x: parent.width - width + 6

        icon.source: "qrc:/images/icons/flags/" + flagsByLanguage[applicationHeader.selectedLanguage] + ".svg"
        icon.color: "transparent"

        onClicked: {
            menuLanguage.open()
        }

        Menu {
            id: menuLanguage

            modal: true

            MenuItem {
                id: menuItemEnglish

                readonly property int languageId: 9

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }

            MenuItem {
                id: menuItemJapanese

                readonly property int languageId: 1

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }

            MenuItem {
                id: menuItemDeutch

                readonly property int languageId: 6

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }

            MenuItem {
                id: menuItemSpanish

                readonly property int languageId: 7

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }

            MenuItem {
                id: menuItemFrench

                readonly property int languageId: 5

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }

            MenuItem {
                id: menuItemItalian

                readonly property int languageId: 8

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }

            MenuItem {
                id: menuItemChinese

                readonly property int languageId: 4

                text: toolButtonLanguage.countriesByLanguage[languageId]
                highlighted: languageId === applicationHeader.selectedLanguage
                icon.source: "qrc:/images/icons/flags/" + toolButtonLanguage.flagsByLanguage[languageId] + ".svg"
                icon.color: "transparent"

                onClicked: {
                    applicationHeader.selectedLanguage = languageId
                }
            }
        } // Menu (language)
    } // ToolButton (language)

    ToolButton {
        id: toolButtonSaveTeam

        readonly property bool shown: applicationWindowContent.pageTeamDetailsIsActive

        y: shown ? toolButtonLanguage.y : -height
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonLanguage.x - width

        enabled: shown && applicationWindowContent.pageTeamDetailsUnsavedChanges
        icon.source: "qrc:/images/icons/actions/save.svg"

        onClicked: {
            if (applicationWindowContent.modelPokemonTeams.saveTeam(applicationWindowContent.pageTeamDetailsCurrentTeamName)) {
                applicationWindowContent.modelPokemonTeams.saveTeamState(applicationWindowContent.pageTeamDetailsCurrentTeamName)
                toolButtonDoneIcon.runAnimation()
            }
        }
    } // ToolButton (save team)

    ToolButton {
        id: toolButtonDoneIcon

        function runAnimation() {
            sequentialAnimationOpacity.start()
        }

        x: toolButtonSaveTeam.x + (toolButtonSaveTeam.width - width)/2
        y: toolButtonSaveTeam.y + (toolButtonSaveTeam.height - height)/2
        icon.width: toolButtonSaveTeam.icon.width + 10
        icon.height: toolButtonSaveTeam.icon.height + 10

        Material.foreground: Material.Green
        icon.source: "qrc:/images/icons/actions/done.svg"
        opacity: 0
        visible: opacity > 0

        background: null

        SequentialAnimation on opacity {
            id: sequentialAnimationOpacity
            NumberAnimation { duration: 100; to: 1.0 }
            PauseAnimation { duration: 200 }
            NumberAnimation { duration: 100; to: 0.0 }
        }
    }

    ToolButton {
        id: toolButtonRestoreTeam

        readonly property bool shown: applicationWindowContent.pageTeamDetailsIsActive

        y: shown ? toolButtonLanguage.y : -height
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonSaveTeam.x - width

        enabled: shown && applicationWindowContent.pageTeamDetailsUnsavedChanges
        icon.source: "qrc:/images/icons/actions/restore.svg"

        onClicked: {
            messageDialogRestoreTeam.teamName = applicationWindowContent.pageTeamDetailsCurrentTeamName
            messageDialogRestoreTeam.open()
        }
    } // ToolButton (restore team)

    ToolButton {
        id: toolButtonDeleteTeam

        readonly property bool shown: applicationWindowContent.pageTeamDetailsIsActive

        y: shown ? toolButtonLanguage.y : -height
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonRestoreTeam.x - width

        enabled: shown
        icon.source: "qrc:/images/icons/actions/delete.svg"
        Material.accent: Material.Red
        Material.foreground: hovered ? Material.accent : parent.Material.foreground

        onClicked: {
            messageDialogRemoveTeam.teamName = applicationWindowContent.pageTeamDetailsCurrentTeamName
            messageDialogRemoveTeam.open()
        }
    } // ToolButton (delete team)


    //! Text fields (search)

    SearchField {
        id: searchFieldPokemon

        readonly property bool shown: applicationMenu.currentIndex === 0 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.pokedexSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldMoves

        readonly property bool shown: applicationMenu.currentIndex === 1 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.movedexSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldAbilities

        readonly property bool shown: applicationMenu.currentIndex === 2 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.abilitydexSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldItems

        readonly property bool shown: applicationMenu.currentIndex === 3 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.itemdexSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldBerries

        readonly property bool shown: applicationMenu.currentIndex === 4 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.berrydexSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldTypes

        readonly property bool shown: applicationMenu.currentIndex === 5 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.typedexSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldNatures

        readonly property bool shown: applicationMenu.currentIndex === 6 && !applicationWindow.stackViewIsOverfilled

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.naturedexSearchFilter = displayText
        }
    } // SearchField

    // StackView overfilled

    SearchField {
        id: searchFieldPokemonMoves

        readonly property bool shown: applicationWindow.stackViewIsOverfilled && applicationWindowContent.pagePokemonDetailsIsActive && applicationWindowContent.pagePokemonDetailsCurrentTabIndex === 1

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown

        onDisplayTextChanged: {
            applicationWindowContent.pokemonMovesSearchFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldSimplePokemonSelection

        readonly property bool shown: applicationWindow.stackViewIsOverfilled && applicationWindowContent.pageSimplePokemonSelectionIsActive

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown
        text: applicationWindowContent.simplePokemonSelectionFilter

        onDisplayTextChanged: {
            applicationWindowContent.simplePokemonSelectionFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldSimpleItemSelection

        readonly property bool shown: applicationWindow.stackViewIsOverfilled && applicationWindowContent.pageSimpleItemSelectionIsActive

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown
        text: applicationWindowContent.simpleItemSelectionFilter

        onDisplayTextChanged: {
            applicationWindowContent.simpleItemSelectionFilter = displayText
        }
    } // SearchField

    SearchField {
        id: searchFieldSimpleMoveSelection

        readonly property bool shown: applicationWindow.stackViewIsOverfilled && applicationWindowContent.pageSimpleMoveSelectionIsActive

        y: shown ? (parent.height - height)/2 : -height - 4
        Behavior on y { NumberAnimation { easing.type: Easing.OutQuint } }
        x: toolButtonMenu.x + toolButtonMenu.width - 16
        width: parent.width - x - toolButtonLanguage.width + 6

        enabled: shown
        text: applicationWindowContent.simpleMoveSelectionFilter

        onDisplayTextChanged: {
            applicationWindowContent.simpleMoveSelectionFilter = displayText
        }
    } // SearchField
}
