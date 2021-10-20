import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageSimpleItemSelection

    property bool allowShowDetails: true
    property alias searchFilter: modelItemsForSimpleItemSelection.filter
    property alias modelItemsForSimpleItemSelection: modelItemsForSimpleItemSelection
    property alias currentIndex: listViewSimpleItemSelection.currentIndex
    onCurrentIndexChanged: {
        listViewSimpleItemSelection.positionViewAtIndex(currentIndex < 0 ? 0 : currentIndex, ListView.Beginning)
    }
    property int currentlySelectedItemId: -1

    Backend.ModelItems {
        id: modelItemsForSimpleItemSelection
        currentLanguage: applicationWindow.applicationLanguageId
        showItemNone: true
    }

    ListView {
        id: listViewSimpleItemSelection
        width: parent.width
        height: parent.height

        model: modelItemsForSimpleItemSelection
        delegate: ItemDelegate {
            width: listViewSimpleItemSelection.width
            icon.source: "qrc:/images/items/items-icons/" + (itemId ? itemId : "0") + ".png"
            icon.color: "transparent"
            text: name
            highlighted: pageSimpleItemSelection.currentlySelectedItemId === itemId
            Material.foreground: highlighted ? Material.accent : pageSimpleItemSelection.Material.foreground

            onClicked: {
                pageSimpleItemSelection.currentIndex = index
                pageSimpleItemSelection.currentlySelectedItemId = itemId
                pageTeamPokemonDetails.itemId = itemId
                applicationWindowContent.pop()
            }

            ToolButton {
                id: toolButtonShowItemDetails

                x: parent.width - width
                y: (parent.height - height)/2
                icon.source: "qrc:/images/icons/actions/visibility_on.svg"
                opacity: 0.5
                visible: allowShowDetails && itemId > 0
                highlighted: parent.highlighted

                onClicked: {
                    pageItemDetails.itemId = itemId
                    pageItemDetails.name = name
                    pageItemDetails.gameDescription = flavorText
                    pageItemDetails.detailedDescription = detailedEffect
                    pageItemDetails.flingPower = flingPower
                    pageItemDetails.hasBigIcon = hasBigIcon

                    stackView.push(pageItemDetails)
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
