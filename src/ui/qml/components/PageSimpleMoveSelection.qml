import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageSimpleMoveSelection

    property bool allowShowDetails: true
    property alias modelPokemonMovesForSimpleMoveSelection: listViewSimpleMoveSelection.model
    readonly property alias movesCount: listViewSimpleMoveSelection.count
    property string searchFilter
    onSearchFilterChanged: {
        modelPokemonMovesForSimpleMoveSelection.filter = searchFilter
    }
    property alias currentIndex: listViewSimpleMoveSelection.currentIndex
    onCurrentIndexChanged: {
        listViewSimpleMoveSelection.positionViewAtIndex(currentIndex < 0 ? 0 : currentIndex, ListView.Beginning)
    }
    property int currentlySelectedMoveId: -1
    property int moveOrder: 0 // [1, 2, 3, 4] are the possible values

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (modelPokemonMovesForSimpleMoveSelection) {
                modelPokemonMovesForSimpleMoveSelection.currentLanguage = applicationLanguageId
            }
        }
    }

    ListView {
        id: listViewSimpleMoveSelection
        width: parent.width
        height: parent.height

        headerPositioning: ListView.PullBackHeader
        header: Pane {
            id: paneHeader

            property int orderIndex: 1
            property bool ascendingOrder: true

            Binding { target: listViewSimpleMoveSelection.model ? listViewSimpleMoveSelection.model : null; property: "columnToSort"; value: paneHeader.orderIndex }
            Binding { target: listViewSimpleMoveSelection.model ? listViewSimpleMoveSelection.model : null; property: "sortOrder"; value: paneHeader.ascendingOrder ? Qt.AscendingOrder : Qt.DescendingOrder }

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

                width: 36
                height: paneHeader.height

                font.bold: orderActive
                text: (orderActive ? ascendingOrder ? "⏶ " : "⏷ " : "") + qsTr("Type")
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
                property bool ascendingOrder: true

                x: itemDelegateOrderByType.x + itemDelegateOrderByType.width
                width: itemDelegateOrderByPower.x - x // name width
                height: paneHeader.height

                font.bold: orderActive
                text: (orderActive ? ascendingOrder ? "⏶ " : "⏷ " : "") + qsTr("Name")
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
                property bool ascendingOrder: orderActive ? ascendingOrder : true

                x: itemDelegateOrderByAccuracy.x - width
                width: 36 // power width
                height: paneHeader.height

                font.bold: orderActive
                text: (orderActive ? ascendingOrder ? "⏶ " : "⏷ " : "") + qsTr("Power")
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
                property bool ascendingOrder: orderActive ? ascendingOrder : true

                x: itemDelegateOrderByDamageClass.x - width
                width: 46 // accuracy width
                height: paneHeader.height

                font.bold: orderActive
                text: (orderActive ? ascendingOrder ? "⏶ " : "⏷ " : "") + qsTr("Accuracy")
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
                property bool ascendingOrder: orderActive ? ascendingOrder : true

                x: paneHeader.width - width
                width: 88 // damage class width + tool button width
                height: paneHeader.height

                font.bold: orderActive
                text: (orderActive ? ascendingOrder ? "⏶ " : "⏷ " : "") + qsTr("Class")
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

        // the model is set with an alias
        delegate: ItemDelegate {
            readonly property int typeId: modelMoves.getMoveData(moveId, Backend.ModelMoves.TypeRole)

            width: listViewSimpleMoveSelection.width
            leftPadding: 6
            icon.source: "qrc:/images/types/types/icons/" + (typeId >= 0 && typeId <= 18 ? typeId : 0) + ".svg"
            icon.color: "transparent"
            highlighted: pageSimpleMoveSelection.currentlySelectedMoveId === moveId
            Material.foreground: highlighted ? Material.accent : pageSimpleMoveSelection.Material.foreground

            Label {
                id: labelMoveName
                x: parent.leftPadding + parent.icon.width + parent.leftPadding
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

                x: toolButtonShowMoveDetails.x - width
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
                pageSimpleMoveSelection.currentIndex = index
                pageSimpleMoveSelection.currentlySelectedMoveId = moveId
                if (moveOrder >= 1 && moveOrder <= 4) {
                    switch (moveOrder) {
                    case 1:
                        pageTeamPokemonDetails.move1Id = moveId
                        break
                    case 2:
                        pageTeamPokemonDetails.move2Id = moveId
                        break
                    case 3:
                        pageTeamPokemonDetails.move3Id = moveId
                        break
                    case 4:
                        pageTeamPokemonDetails.move4Id = moveId
                        break
                    }
                }

                applicationWindowContent.pop()
            }

            ToolButton {
                id: toolButtonShowMoveDetails

                x: parent.width - width
                y: (parent.height - height)/2
                padding: 0
                icon.source: "qrc:/images/icons/actions/visibility_on.svg"
                opacity: 0.5
                visible: allowShowDetails && moveId > 0
                highlighted: parent.highlighted

                onClicked: {
                    var regexp = /\n/gi // Remove all new lines
                    pageMoveDetails.moveId = modelMoves.getMoveData(moveId, Backend.ModelMoves.IdRole)
                    pageMoveDetails.learnMethodName = learnMethodName
                    pageMoveDetails.learnMethodDescription = learnMethodDescription
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
