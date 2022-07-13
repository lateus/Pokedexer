import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageTypedex

    property alias searchFilter: modelTypes.filter
    property alias modelTypes: modelTypes

    Backend.ModelTypes {
        id: modelTypes
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewTypes

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10

        displayMarginBeginning: 50
        displayMarginEnd: 50
        headerPositioning: ListView.PullBackHeader
        spacing: 10
        model: modelTypes

        header: Pane {
            z: 2 // above delegates
            width: parent.width
            height: buttonTypeChart.height + 4

            Material.elevation: 10
            padding: 2

            Button {
                id: buttonTypeChart

                width: parent.width/2 - 2

                padding: 0
                topInset: 0
                bottomInset: 0
                text: qsTr("Chart")
                highlighted: true
                flat: true

                onClicked: {
                    pageTypeChart.rowToHighlight = -1
                    pageTypeChart.columnToHighlight = -1
                    stackView.push(pageTypeChart)
                }
            }

            Button {
                id: buttonCheckTypePerformance

                x: buttonTypeChart.x + buttonTypeChart.width + 2
                width: parent.width - buttonTypeChart.width - 2

                padding: 0
                topInset: 0
                bottomInset: 0
                text: qsTr("Combine")
                highlighted: true
                flat: true

                onClicked: {
                    pageTypePerformance.readonly = false
                    stackView.push(pageTypePerformance)
                }
            }
        } // Page

        delegate: Pane {
            width: listViewTypes.contentItem.width
            height: 50
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
                    pageTypeDetails.typeId = typeId
                    pageTypeDetails.name = name
                    pageTypeDetails.generation = generation
                    pageTypeDetails.superEffectiveTo = superEffectiveTo
                    pageTypeDetails.notVeryEffectiveTo = notVeryEffectiveTo
                    pageTypeDetails.nullTo = nullTo
                    pageTypeDetails.superEffectiveFrom = superEffectiveFrom
                    pageTypeDetails.notVeryEffectiveFrom = notVeryEffectiveFrom
                    pageTypeDetails.nullFrom = nullFrom
                    pageTypeDetails.additionalInfo = additionalInfo

                    stackView.push(pageTypeDetails)
                }

                TypeTag {
                    id: typeTagType

                    x: (parent.width - width)/2
                    y: (parent.height - height)/2
                    type: typeId
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
}
