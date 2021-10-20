import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageMovedex

    property alias searchFilter: modelMoves.filter
    property alias modelMoves: modelMoves

    Backend.ModelMoves {
        id: modelMoves
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewMoves

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10
        
        displayMarginBeginning: 60
        displayMarginEnd: 60
        spacing: 10
        model: modelMoves
        delegate: Pane {
            width: listViewMoves.contentItem.width
            height: 60
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
                    pageMoveDetails.moveId = moveId
                    pageMoveDetails.learnMethodName = ""
                    pageMoveDetails.learnMethodDescription = ""
                    pageMoveDetails.name = name
                    pageMoveDetails.gameDescription = labelMoveGameDescription.text
                    pageMoveDetails.detailedDescription = detailedEffect
                    pageMoveDetails.power = power
                    pageMoveDetails.pp = pp
                    pageMoveDetails.accuracy = accuracy
                    pageMoveDetails.priority = priority
                    pageMoveDetails.effectChance = effectChance
                    pageMoveDetails.damageClass = damageClass
                    pageMoveDetails.target = target
                    pageMoveDetails.type = type
                    pageMoveDetails.contestType = contestType
                    pageMoveDetails.contestEffect = contestEffect
                    pageMoveDetails.superContestEffect = superContestEffect
                    pageMoveDetails.generation = generation

                    stackView.push(pageMoveDetails)
                }

                Label {
                    id: labelMove
                    x: parent.width/2 - width/2
                    y: 6
                    leftPadding: labelMoveGameDescription.leftPadding

                    text: name
                    font.bold: true
                    elide: Text.ElideRight
                    textFormat: Text.PlainText
                }

                Item {
                    implicitWidth: itemDelegateBackground.height + 2
                    implicitHeight: itemDelegateBackground.height
                    clip: true

                    Rectangle {
                        id: rectangleMoveTypeFill

                        readonly property var topColor:    [ "#9298a4", "#ce4265", "#90a7da", "#a864c7", "#dc7545", "#c5b489", "#92bc2c", "#516aac", "#52869d", "#fb9b51", "#4a90dd", "#5fbc51", "#edd53e", "#f66f71", "#70ccbd", "#0c69c8", "#595761", "#ec8ce5" ]
                        readonly property var bottomColor: [ "#a3a49e", "#e74347", "#a6c2f2", "#c261d4", "#d29463", "#d7cd90", "#afc836", "#7773d4", "#58a6aa", "#fbae46", "#6cbde4", "#5ac178", "#fbe273", "#fe9f92", "#8cddd4", "#0180c7", "#6e7587", "#f3a7e7" ]

                        implicitWidth: itemDelegateBackground.height/2
                        implicitHeight: itemDelegateBackground.height

                        gradient: Gradient {
                            GradientStop {
                                position: 0.00;
                                color: rectangleMoveTypeFill.topColor[type - 1];
                            }
                            GradientStop {
                                position: 1.00;
                                color: rectangleMoveTypeFill.bottomColor[type - 1];
                            }
                        }

                        Image {
                            id: imageMoveType
                            y: -1
                            source: "qrc:/images/types/types/" + type + ".svg"
                            sourceSize: Qt.size(itemDelegateBackground.height + 2, itemDelegateBackground.height + 2)
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                } // Item
                
                Label {
                    id: labelMoveGameDescription
                    
                    y: labelMove.y + (lineCount <= 1 ? 24 : 18)
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: 2*rectangleMoveTypeFill.width + 6
                    rightPadding: 6
                    
                    text: flavorText
                    maximumLineCount: 2
                    font.italic: true
                    font.pointSize: Qt.application.font.pointSize * 0.9
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    textFormat: Text.PlainText
                }
            } // ItemDelegate
        } // Pane (delegate)

        ScrollBar.vertical: ScrollBar {
            id: scrollBarMovedex

            padding: 2
            contentItem: Rectangle {
                implicitWidth: 6
                implicitHeight: 6
                radius: width/2

                color: scrollBarMovedex.pressed ? scrollBarMovedex.Material.scrollBarPressedColor :
                       scrollBarMovedex.interactive && scrollBarMovedex.hovered ? scrollBarMovedex.Material.scrollBarHoveredColor : scrollBarMovedex.Material.scrollBarColor
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

    RoundButton {
        id: roundButtonFilterByColor

        x: roundButtonFilter.x
        y: roundButtonFilterByType.y - height

        icon.source: "qrc:/images/icons/others/rgb.svg"
        icon.color: "transparent"
        scale: roundButtonFilterByType.scale
        visible: false

        onClicked: {
//            drawerFilter.model = modelTypes.getTypeNames()
//            drawerFilter.delegate = componentTypeDelegate
//            drawerFilter.open()
        }
    }

    RoundButton {
        id: roundButtonFilterByType

        x: roundButtonFilter.x
        y: roundButtonFilter.y - height

        icon.source: "qrc:/images/icons/others/types.svg"
        icon.color: "transparent"
        scale: roundButtonFilter.checked ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 250; easing.type: roundButtonFilterByType.scale === 0 ? Easing.OutBack : Easing.InBack } }

        onClicked: {
            drawerFilter.model = modelTypes.getTypeNames()
            drawerFilter.delegate = componentTypeDelegate
            drawerFilter.open()
        }
    }

    RoundButton {
        id: roundButtonFilter

        x: parent.width - width
        y: parent.height - height

        checkable: true
        icon.source: checked ? "qrc:/images/icons/actions/clear.svg" : "qrc:/images/icons/actions/filter.svg"
    }

    Drawer {
        id: drawerFilter

        property alias model: listViewFilter.model
        property alias delegate: listViewFilter.delegate

        width: 140
        height: parent.height

        enabled: visible
        edge: Qt.RightEdge
        dragMargin: 0

        onClosed: roundButtonFilter.scale = 1

        ListView {
            id: listViewFilter

            height: parent.height
            width: parent.width

            ScrollBar.vertical: ScrollBar {
                id: scrollBarFilter

                padding: 2
                contentItem: Rectangle {
                    implicitWidth: 6
                    implicitHeight: 6
                    radius: width/2

                    color: scrollBarFilter.pressed ? scrollBarFilter.Material.scrollBarPressedColor :
                           scrollBarFilter.interactive && scrollBarFilter.hovered ? scrollBarFilter.Material.scrollBarHoveredColor : scrollBarFilter.Material.scrollBarColor
                    opacity: 0.0
                }

                background: Rectangle {
                    implicitWidth: 6
                    implicitHeight: 6
                    color: "#0e000000"
                    opacity: 0.0
                }
            }
        }
    } // Drawer (filter)

    Component {
        id: componentTypeDelegate

        ItemDelegate {
            width: parent ? parent.width : width

            text: index === 0 ? qsTr("No filter") : ""
            icon.source: index === 0 ? "qrc:/images/icons/actions/clear.svg" : ""
            Material.accent: Material.Red
            Material.foreground: Material.accent
            font.bold: true

            TypeTag {
                x: (parent.width - width)/2
                y: (parent.height - height)/2

                visible: index > 0
                sourceSize.height: 42
                type: index
            }

            onClicked: {
                modelMoves.filterType = index
                roundButtonFilter.checked = false
                drawerFilter.close()
            }
        }
    } // Component (type delegate)
}
