import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
//import Qt5Compat.GraphicalEffects

// Qt Labs
import Qt.labs.settings 1.0 as QtLabsSettings

// Folders
import "dialogs" as Dialogs
import "components" as Components

ApplicationWindow {
    id: applicationWindow

    property int applicationLanguageId: applicationHeader.selectedLanguage

    readonly property bool stackViewIsOverfilled: applicationWindowContent.stackViewDepth > 1

    width: 360
    height: 660

    visible: true
    title: Qt.application.name
    Material.theme: ~~settings.value("style/theme", Material.Light)

    Component.onDestruction: {
        // save settings here before closing the application
    }

    onClosing: {
        if (Qt.platform.os === "android") {
            close.accepted = false
            if (stackViewIsOverfilled) {
                applicationWindowContent.pop()
            }
        }
    }

    //! Settings
    QtLabsSettings.Settings {
        id: settings
    }

    header: Components.ApplicationHeader {
        id: applicationHeader
        height: 40
    }

    //! Drawer (menu)
    Components.ApplicationMenu {
        id: applicationMenu
        y: applicationHeader.height
        width: 0.75 * applicationWindow.width + rightInset
        height: applicationWindow.height - applicationHeader.height
        rightInset: 40
        clip: true

        onPokedexRequested: {
            applicationWindowContent.showPokedexPage()
        }

        onMovedexRequested: {
            applicationWindowContent.showMovedexPage()
        }

        onAbilitydexRequested: {
            applicationWindowContent.showAbilitiesPage()
        }

        onItemdexRequested: {
            applicationWindowContent.showItemsPage()
        }

        onBerrydexRequested: {
            applicationWindowContent.showBerriesPage()
        }

        onTypedexRequested: {
            applicationWindowContent.showTypesPage()
        }

        onNaturedexRequested: {
            applicationWindowContent.showNaturesPage()
        }

        onLocationdexRequested: {
            applicationWindowContent.showLocationsPage()
        }

        onTeamBuilderRequested: {
            applicationWindowContent.showTeamBuilderPage()
        }

        onAboutRequested: {
            applicationWindowContent.showAboutPage()
        }

        onAboutQtRequested: {
            applicationWindowContent.showAboutQtPage()
        }

        onLicenseRequested: {
            applicationWindowContent.showAboutLicensePage()
        }
    }

    //! Application Window's content
    Components.ApplicationWindowContent {
        id: applicationWindowContent
        anchors.fill: parent
    }

    //! Graphical effects
    /*
    FastBlur {
        id: blurEffectMenu
        visible: radius > 0
        anchors.fill: applicationWindowContent
        source: applicationWindowContent
        radius: applicationMenu.position * 128
    }
    */

    //! Dialogs
    Dialogs.MessageDialog {
        id: messageDialogRemoveTeam

        property string teamName

        x: (parent.width - width)/2
        y: (parent.height - height)/2
        width: implicitWidth > applicationWindow.width - 40 ? applicationWindow.width - 40 : implicitWidth
        height: implicitHeight > applicationWindow.height - 40 ? applicationWindow.height - 40 : implicitHeight

        modal: true
        focus: visible

        messageType: Dialogs.MessageDialog.MessageType.Question
        title: qsTr("Confirm team deletion")
        text: qsTr("Delete team <i>%1</i>?").arg(teamName)

        onAccepted: {
            if (applicationWindowContent.modelPokemonTeams.removeTeam(teamName)) {
                applicationHeader.goBack()
            }
        }
    } // MessageDialog (remove team)

    Dialogs.MessageDialog {
        id: messageDialogRestoreTeam

        property string teamName

        x: (parent.width - width)/2
        y: (parent.height - height)/2
        width: implicitWidth > applicationWindow.width - 40 ? applicationWindow.width - 40 : implicitWidth
        height: implicitHeight > applicationWindow.height - 40 ? applicationWindow.height - 40 : implicitHeight

        modal: true
        focus: visible

        messageType: Dialogs.MessageDialog.MessageType.Question
        title: qsTr("Confirm team restore")
        text: qsTr("Restore team <i>%1</i> to its previous saved state?").arg(teamName)

        onAccepted: {
            if (applicationWindowContent.modelPokemonTeams.restoreTeamState(teamName)) {
                // nothing to do, but ensure that the `PageTeamDetails` is up-to-date
            }
        }
    } // MessageDialog (remove team)

    Dialogs.MessageDialog {
        id: messageDialogRemovePokemon

        property string teamName
        property int pokemonIndexInTeam

        x: (parent.width - width)/2
        y: (parent.height - height)/2
        width: implicitWidth > applicationWindow.width - 40 ? applicationWindow.width - 40 : implicitWidth
        height: implicitHeight > applicationWindow.height - 40 ? applicationWindow.height - 40 : implicitHeight

        modal: true
        focus: visible

        messageType: Dialogs.MessageDialog.MessageType.Question
        title: qsTr("Confirm pokémon clearing")
        text: qsTr("Clear this pokémon slot?")

        onAccepted: {
            if (applicationWindowContent.modelPokemonTeams.clearTeamPokemon(teamName, pokemonIndexInTeam)) {
                applicationHeader.goBack()
            }
        }
    } // MessageDialog (remove pokemon)

    ToolTip {
        id: toolTipCenteredMessage
    }
}
