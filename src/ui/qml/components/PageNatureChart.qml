import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageNatureChart

    property int selectedNatureId: 0
    property int rowToHighlight: -1
    property int columnToHighlight: -1

    signal natureSelected(selectedNatureId: int)

    enabled: visible

    Rectangle {
        id: rectangleCorner

        readonly property alias hovered: mouseAreaCorner.containsMouse
        onHoveredChanged: {
            if (hovered) {
                rowToHighlight = columnToHighlight = -1
            }
        }

        z: horizontalHeaderView.z + 1
        width: horizontalHeaderView.x
        height: verticalHeaderView.y

        color: hovered ? "#30777777" : "transparent"

        Label {
            width: parent.width
            height: parent.height

            leftPadding: width/4
            rightPadding: leftPadding
            topPadding: height/4
            bottomPadding: topPadding
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pointSize: 100
            font.bold: true
            text: qsTr("Neutral")
            textFormat: Text.PlainText
        }

        Rectangle {
            x: parent.width - 2
            y: parent.height - 2
            width: 2
            height: 2

            color: Material.accent
        }

        MouseArea {
            id: mouseAreaCorner
            width: parent.width
            height: parent.height

            hoverEnabled: true
        }
    } // Rectangle (corner)

    Pane {
        id: paneHorizontalHeaderView

        x: horizontalHeaderView.x
        y: horizontalHeaderView.y
        z: horizontalHeaderView.z - 1 // above the chart but under the header
        width: horizontalHeaderView.width
        height: horizontalHeaderView.height

        padding: 0
        Material.elevation: 10

        Rectangle {
            y: parent.height - 2
            width: parent.width
            height: 2

            color: Material.accent
        }
    }

    HorizontalHeaderView {
        id: horizontalHeaderView

        x: tableViewNatureChart.x
        z: 5

        syncView: tableViewNatureChart
        delegate: Rectangle {
            id: rectangleHorizontalHeaderDelegate

            implicitWidth: 100 // same as the view's delegate
            implicitHeight: 80
            color: index === columnToHighlight ? "#30777777" : "transparent"

            Button {
                id: buttonStatDown
                width: parent.width
                height: parent.height
                padding: 0
                topInset: 0
                bottomInset: 0

                flat: true
                text: modelNatures.getNatureData(modelNatures.getNatureIdFromStatBonus(index + 2, index === 0 ? 3 : 2), Backend.ModelNatures.StatDownRole).replace(' ', '\n')
                icon.source: "qrc:/images/icons/arrows/double_chevron_down.svg"
                icon.width: 12
                icon.height: 12
                Material.accent: Material.Blue
                Material.foreground: Material.accent
                background: null

                onHoveredChanged: {
                    if (hovered) {
                        rowToHighlight = -1
                        columnToHighlight = index
                    }
                }
            } // Button (stat down)
        } // Rectangle (delegate horizontal header)
    } // HorizontalHeaderView

    Pane {
        id: paneVerticalHeaderView

        x: verticalHeaderView.x
        y: verticalHeaderView.y
        z: verticalHeaderView.z - 1 // above the chart but under the header
        width: verticalHeaderView.width
        height: verticalHeaderView.height

        padding: 0
        Material.elevation: 10

        Rectangle {
            x: parent.width - 2
            width: 2
            height: parent.height

            color: Material.accent
        }
    }

    VerticalHeaderView {
        id: verticalHeaderView

        y: tableViewNatureChart.y
        z: 5

        syncView: tableViewNatureChart
        delegate: Rectangle {
            id: rectangleVerticalHeaderDelegate

            implicitHeight: 40 // same as the view's delegate
            implicitWidth: 100
            color: index === rowToHighlight ? "#30777777" : "transparent"

            Button {
                id: buttonStatUp
                x: 12
                y: (parent.height - height)/2
                padding: 0
                topInset: 0
                bottomInset: 0

                flat: true
                text: modelNatures.getNatureData(modelNatures.getNatureIdFromStatBonus(index === 0 ? 3 : 2, index + 2), Backend.ModelNatures.StatUpRole).replace(' ', '\n')
                icon.source: "qrc:/images/icons/arrows/double_chevron_up.svg"
                icon.width: 12
                icon.height: 12
                Material.accent: Material.Red
                Material.foreground: Material.accent
                background: null

                onHoveredChanged: {
                    if (hovered) {
                        rowToHighlight = index
                        columnToHighlight = -1
                    }
                }
            } // Button (stat down)
        } // Rectangle (delegate vertical header)

        Rectangle {
            id: rectangleRightLineVerticalHeader

            x: parent.width - 2
            width: 2
            height: parent.height

            color: Material.accent
        }
    } // VerticalHeaderView

    TableView {
        id: tableViewNatureChart

        x: verticalHeaderView.width
        y: horizontalHeaderView.height
        width: parent.width - x
        height: parent.height - y

        clip: true
        model: modelNatures.modelNatureChart
        delegate: Rectangle {
            implicitWidth: 100
            implicitHeight: 40

            clip: true
            color: "transparent"
            border.width: 3
            border.color: Material.background
            radius: 8

            Rectangle {
                width: parent.width
                height: parent.height
                visible: ((rowToHighlight === row || columnToHighlight === column) && (rowToHighlight >= row && columnToHighlight >= column || rowToHighlight === -1 || columnToHighlight === -1)) || rectangleCorner.hovered && row === column
                color: "#30777777"
            }

            ItemDelegate {
                id: itemDelegateNatureName

                width: parent.width
                height: parent.height

                text: modelNatures.getNatureData(natureId, Backend.ModelNatures.NameRole)
                display: ItemDelegate.TextUnderIcon

                onHoveredChanged: {
                    if (hovered) {
                        rowToHighlight = row
                        columnToHighlight = column
                    }
                }

                onPressed: {
                    rowToHighlight = row
                    columnToHighlight = column
                }

                onClicked: {
                    pageNatureChart.selectedNatureId = natureId
                    pageNatureChart.natureSelected(pageNatureChart.selectedNatureId)
                    stackView.pop()
                }
            }
        } // Rectangle

        ScrollBar.horizontal: ScrollBar {
            id: scrollBarHorizontal

            padding: 2
            contentItem: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                radius: width/2

                color: scrollBarHorizontal.pressed ? scrollBarHorizontal.Material.scrollBarPressedColor :
                       scrollBarHorizontal.interactive && scrollBarHorizontal.hovered ? scrollBarHorizontal.Material.scrollBarHoveredColor : scrollBarHorizontal.Material.scrollBarColor
                opacity: 0.0
            }

            background: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                color: "#0e000000"
                opacity: 0.0
            }
        }

        ScrollBar.vertical: ScrollBar {
            id: scrollBarVertical

            padding: 2
            contentItem: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                radius: width/2

                color: scrollBarVertical.pressed ? scrollBarVertical.Material.scrollBarPressedColor :
                       scrollBarVertical.interactive && scrollBarVertical.hovered ? scrollBarVertical.Material.scrollBarHoveredColor : scrollBarVertical.Material.scrollBarColor
                opacity: 0.0
            }

            background: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                color: "#0e000000"
                opacity: 0.0
            }
        }
    } // TableView
}
