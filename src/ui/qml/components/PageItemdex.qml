import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageItemdex

    property alias searchFilter: modelItems.filter
    property alias modelItems: modelItems

    Backend.ModelItems {
        id: modelItems
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewItems

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10
        
        displayMarginBeginning: 60
        displayMarginEnd: 60
        spacing: 10
        model: modelItems
        delegate: Pane {
            width: listViewItems.contentItem.width
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
                    pageItemDetails.hasBigIcon = hasBigIcon
                    pageItemDetails.itemId = itemId
                    pageItemDetails.name = name
                    pageItemDetails.gameDescription = labelItemGameDescription.text
                    pageItemDetails.detailedDescription = detailedEffect
                    pageItemDetails.flingPower = flingPower

                    stackView.push(pageItemDetails)
                }

                Image {
                    id: imageItem
                    x: (parent.width - width - labelItem.width)/2 - 3
                    y: 6
                    source: "qrc:/images/items/items-icons/" + itemId + ".png"
                    sourceSize: Qt.size(32, 32)
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: labelItem

                    x: imageItem.x + imageItem.width + 3
                    y: imageItem.y + (imageItem.height - height)/2

                    horizontalAlignment: Text.AlignHCenter
                    text: name
                    font.bold: true
                    elide: Text.ElideRight
                }
                
                Label {
                    id: labelItemGameDescription
                    
                    readonly property var regexp: /\n/gi // Remove all new lines

                    y: itemDelegateBackground.height - height - 4
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: 6
                    rightPadding: 6
                    
                    enabled: flavorText
                    text: flavorText ? flavorText.replace(regexp, ' ') : qsTr("(Description not available)")
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
