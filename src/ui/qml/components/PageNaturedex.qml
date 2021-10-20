import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Page {
    id: pageNaturedex

    property alias searchFilter: modelNatures.filter
    property alias modelNatures: modelNatures

    Backend.ModelNatures {
        id: modelNatures
        currentLanguage: applicationWindow.applicationLanguageId
    }
    
    ListView {
        id: listViewNatures

        width: parent.width
        height: parent.height
        topMargin: 10
        bottomMargin: 10

        displayMarginBeginning: 70
        displayMarginEnd: 70
        spacing: 10
        model: modelNatures
        delegate: Rectangle {
            id: rectangleDelegate
            x: 10
            width: listViewNatures.contentItem.width - 2*x
            height: 70
            radius: 12
            color: Material.dialogColor
            border.color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080"
            border.width: 1

            Label {
                id: labelNature

                y: 4
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: name
                font.bold: true
                elide: Text.ElideRight
                textFormat: Text.PlainText
            }

            Rectangle {
                id: rectangleUp
                width: parent.width/2
                height: parent.height - labelNature.height - 10
                y: parent.height - height
                radius: parent.radius

                Material.accent: Material.Red
                color: Material.accentColor

                Rectangle {
                    width: parent.width
                    height: parent.radius
                    color: parent.color
                }

                Rectangle {
                    width: parent.radius
                    height: parent.radius
                    x: parent.width - width
                    y: parent.height - height
                    color: parent.color
                }

                ToolButton {
                    id: toolButtonUpIcon
                    x: 2
                    y: (parent.height - height)/2
                    icon.source: "qrc:/images/icons/arrows/double_chevron_up.svg"
                    Material.foreground: rectangleDelegate.color
                    background: null
                }

                Label {
                    id: labelStatUp
                    x: toolButtonUpIcon.x + toolButtonUpIcon.width - 4
                    y: statUp === qsTr("None") ? (parent.height - height)/2 : 2
                    width: parent.width - x
                    horizontalAlignment: Text.AlignHCenter
                    text: statUp === qsTr("None") ? "-" : statUp
                    color: rectangleDelegate.color
                }

                Label {
                    id: labelFlavorUp
                    x: labelStatUp.x
                    y: labelStatUp.y + labelStatUp.height + 2
                    width: labelStatUp.width
                    horizontalAlignment: Text.AlignHCenter
                    visible: flavorUp !== qsTr("None")
                    text: "(" + qsTr("Likes:") + " " + flavorUp + ")"
                    font.italic: true
                    font.pointSize: labelStatUp.font.pointSize * 0.75
                    color: rectangleDelegate.color
                }
            } // Rectangle (up)

            Rectangle {
                id: rectangleDown
                x: rectangleUp.x + rectangleUp.width
                width: parent.width - rectangleUp.width
                height: rectangleUp.height
                y: rectangleUp.y
                radius: parent.radius

                Material.accent: Material.Blue
                color: Material.accentColor

                Rectangle {
                    width: parent.width
                    height: parent.radius
                    color: parent.color
                }

                Rectangle {
                    width: parent.radius
                    height: parent.radius
                    y: parent.height - height
                    color: parent.color
                }

                ToolButton {
                    id: toolButtonDownIcon
                    x: parent.width - width - 2
                    y: (parent.height - height)/2
                    icon.source: "qrc:/images/icons/arrows/double_chevron_down.svg"
                    Material.foreground: rectangleDelegate.color
                    background: null
                }

                Label {
                    id: labelStatDown
                    x: 4
                    y: statDown === qsTr("None") ? (parent.height - height)/2 : 2
                    width: parent.width - toolButtonDownIcon.width - x
                    horizontalAlignment: Text.AlignHCenter
                    text: statDown === qsTr("None") ? "-" : statDown
                    color: rectangleDelegate.color
                    textFormat: Text.PlainText
                }

                Label {
                    id: labelFlavorDown
                    x: labelStatDown.x
                    y: labelStatDown.y + labelStatDown.height + 2
                    width: labelStatDown.width
                    horizontalAlignment: Text.AlignHCenter
                    visible: flavorUp !== qsTr("None")
                    text: "(" + qsTr("Likes:") + " " + flavorDown + ")"
                    font.italic: true
                    font.pointSize: labelStatDown.font.pointSize * 0.75
                    color: rectangleDelegate.color
                    textFormat: Text.PlainText
                }
            } // Rectangle (up)
        } // Rectangle (delegate)

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
