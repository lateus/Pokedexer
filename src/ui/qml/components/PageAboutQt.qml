import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: pageAboutQt

    readonly property string qtVersionString: "5.14.2"
    
    Flickable {
        id: flickable

        width: parent.width
        height: parent.height

        contentWidth: width - leftMargin - rightMargin
        contentHeight: column.height
        topMargin: 12
        bottomMargin: 12
        leftMargin: 12
        rightMargin: 12
        clip: true
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: column
            spacing: 20
            width: parent.width

            Image {
                id: imageQtIcon
                x: (parent.width - width)/2
                source: "qrc:/images/icons/qt/qt_logo_green.svg"
                sourceSize: Qt.size(148, 148)

                opacity: 0.0

                NumberAnimation {
                    running: imageQtIcon.visible
                    target: imageQtIcon
                    property: "opacity"
                    duration: 2000
                    alwaysRunToEnd: true
                    to: 1.0
                    easing.type: Easing.OutQuint
                }
            } // Image (Qt's icon)

            Label {
                id: labelAboutQt
                width: parent.width
                text: "<b>" + qsTr("This program uses Qt %1").arg(qtVersionString) + "</b><br>"
                    + qsTr("<p>Qt is a <i>C++ toolkit for cross-platform application " +
                           "development</i>.</p>" +
                           "<p>Qt provides single-source portability across all major desktop and mobile " +
                           "operating systems. It is also available for embedded Linux and other " +
                           "embedded operating systems.</p><br>" +
                           "<p>Qt offers both <i>commercial</i> and <i>opensource</i> licences. Please see <a href=\"http://%2/\">%2</a> " +
                           "for an overview of Qt licensing.</p><br>" +
                           "<p><i>Copyright © %1 The Qt Company Ltd</i> and other " +
                           "contributors. See <a href=\"http://%3/\">%3</a> for more information.</p>").arg("2020").arg("qt.io/licensing").arg("qt.io")
                wrapMode: Label.Wrap
                onHoveredLinkChanged: {
                    mouseAreaLinkHovered.cursorShape = hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
                onLinkActivated: {
                    if (link === qsTr("License")) {
                        licenseRequested()
                    } else {
                        Qt.openUrlExternally(link)
                    }
                }

                MouseArea {
                    id: mouseAreaLinkHovered
                    width: parent.width
                    height: parent.height
                    acceptedButtons: Qt.NoButton
                }
            } // Label
        } // Column

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // Flickable
}
