import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Page {
    id: pageTypeChart

    Rectangle {
        id: rectangleCorner

        z: horizontalHeaderView.z + 1
        width: horizontalHeaderView.x
        height: verticalHeaderView.y

        color: Material.backgroundColor

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
            text: qsTr("TYPE")
            textFormat: Text.PlainText
        }

        Rectangle {
            x: parent.width - 2
            y: parent.height - 2
            width: 2
            height: 2

            color: Material.accent
        }
    }

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

        x: tableViewTypeChart.x
        z: 5

        syncView: tableViewTypeChart
        delegate: Item {
            id: itemHorizontalHeaderDelegate

            implicitWidth: 40 // same as the view's delegate
            implicitHeight: imageTypeIconHorizontalHeader.height + labelTypeNameHorizontalHeader.height + 12

            Image {
                id: imageTypeIconHorizontalHeader

                x: 4
                y: 3
                width: parent.width - 2*x
                height: width

                source: "qrc:/images/types/types/icons/" + (index + 1) + ".svg"
                sourceSize: Qt.size(width, height)
            }

            Label {
                id: labelTypeNameHorizontalHeader

                y: imageTypeIconHorizontalHeader.y + imageTypeIconHorizontalHeader.height + 4
                width: parent.width
                height: 10

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.pixelSize: 8
                text: horizontalHeaderView.model.getTypeName(index + 1)
                textFormat: Text.PlainText
            }
        }
    }

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

        y: tableViewTypeChart.y
        z: 5

        syncView: tableViewTypeChart
        delegate: Item {
            id: itemVerticalHeaderDelegate

            implicitHeight: 40 // same as the view's delegate
            implicitWidth: typeTagVerticalHeader.width + rectangleRightLineVerticalHeader.width + 6

            TypeTag {
                id: typeTagVerticalHeader

                x: 2
                y: 2
                sourceSize.height: 36

                type: index + 1
            }
        }

        Rectangle {
            id: rectangleRightLineVerticalHeader

            x: parent.width - 2
            width: 2
            height: parent.height

            color: Material.accent
        }
    }

    TableView {
        id: tableViewTypeChart

        x: verticalHeaderView.width
        y: horizontalHeaderView.height
        width: parent.width - x
        height: parent.height - y

        clip: true
        model: modelTypes.modelTypeChart
        delegate: Rectangle {
            implicitWidth: 40
            implicitHeight: width

            clip: true
            color: applicationWindow.Material.theme === Material.Light ? lightColor : darkColor
            border.width: 3
            border.color: Material.background
            radius: 8

            Label {
                id: labelEffectivenessMultiplier

                width: parent.width
                height: parent.height

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "x" + value
                textFormat: Text.PlainText
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
