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

    ListView {
        id: listViewSimpleMoveSelection
        width: parent.width
        height: parent.height

        // the model is set with an alias
        delegate: ItemDelegate {
            readonly property int typeId: modelMoves.getMoveData(moveId, Backend.ModelMoves.TypeRole)

            width: listViewSimpleMoveSelection.width
            icon.source: "qrc:/images/types/types/icons/" + (typeId >= 0 && typeId <= 18 ? typeId : 0) + ".svg"
            icon.color: "transparent"
            text: modelMoves.getMoveData(moveId, Backend.ModelMoves.NameRole)
            highlighted: pageSimpleMoveSelection.currentlySelectedMoveId === moveId
            Material.foreground: highlighted ? Material.accent : pageSimpleMoveSelection.Material.foreground

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
