import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageBerrydex

    property alias searchFilter: modelBerries.filter
    property alias modelBerries: modelBerries

    Backend.ModelBerries {
        id: modelBerries
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewBerries

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10
        
        displayMarginBeginning: 50
        displayMarginEnd: 50
        spacing: 10
        model: modelBerries
        delegate: Pane {
            width: listViewBerries.contentItem.width
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
                    pageBerryDetails.berryId = berryId
                    pageBerryDetails.name = name
                    pageBerryDetails.gameDescription = labelBerryGameDescription.text
                    pageBerryDetails.detailedDescription = detailedEffect
                    pageBerryDetails.naturalGiftPower = naturalGiftPower
                    pageBerryDetails.naturalGiftType = naturalGiftType
                    pageBerryDetails.size = size
                    pageBerryDetails.maxHarvest = maxHarvest
                    pageBerryDetails.growthTime = growthTime
                    pageBerryDetails.soilDryness = soilDryness
                    pageBerryDetails.smoothness = smoothness
                    pageBerryDetails.firmness = firmness
                    pageBerryDetails.potencyByFlavor = potencyByFlavor

                    stackView.push(pageBerryDetails)
                }

                Image {
                    id: imageBerry
                    x: (parent.width - width - labelBerry.width)/2 - 3
                    y: 6
                    source: "qrc:/images/sprites/berries/" + berryId + ".png"
                    sourceSize: Qt.size(24, 24)
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: labelBerry

                    x: imageBerry.x + imageBerry.width + 3
                    y: imageBerry.y

                    horizontalAlignment: Text.AlignHCenter
                    text: name
                    font.bold: true
                    elide: Text.ElideRight
                }
                
                Label {
                    id: labelBerryGameDescription
                    
                    readonly property var regexp: /\n/gi // Remove all new lines
                    
                    y: itemDelegateBackground.height - height - 4
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    leftPadding: 6
                    rightPadding: 6
                    
                    text: flavorText.replace(regexp, ' ')
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
