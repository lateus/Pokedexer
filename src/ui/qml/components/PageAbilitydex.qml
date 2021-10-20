import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageAbilitydex

    property alias searchFilter: modelAbilities.filter
    property alias modelAbilities: modelAbilities

    Backend.ModelAbilities {
        id: modelAbilities
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewAbilities

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10
        
        displayMarginBeginning: 50
        displayMarginEnd: 50
        spacing: 10
        model: modelAbilities
        delegate: Pane {
            width: listViewAbilities.contentItem.width
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
                    listViewAbilities.currentIndex = index
                    pageAbilityDetails.abilityId = abilityId
                    pageAbilityDetails.name = name
                    pageAbilityDetails.gameDescription = flavorText
                    pageAbilityDetails.detailedDescription = detailedEffect
                    pageAbilityDetails.nativeGeneration = generation
                    stackView.push(pageAbilityDetails)
                }
                
                Label {
                    id: labelAbility
                    y: 6
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: 6
                    rightPadding: 6
                    
                    text: name
                    font.bold: true
                    elide: Text.ElideRight
                }
                
                Label {
                    id: labelAbilityGameDescription
                    
                    y: labelAbility.y + labelAbility.height + 6
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: 6
                    rightPadding: 6
                    
                    text: flavorText
                    font.italic: true
                    font.pointSize: Qt.application.font.pointSize * 0.9
                    elide: Text.ElideRight
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
