import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle {
    id: rectangleSeparator

    property real stayInterval: 0.1
    property real leaveInterval: 0
    property bool horizontalOrientation: true
    property int alignment: Qt.AlignHCenter
    readonly property bool centered: alignment === Qt.AlignHCenter || alignment === Qt.AlignVCenter
    readonly property bool startsTransparent: alignment === Qt.AlignHCenter || alignment === Qt.AlignVCenter || alignment === Qt.AlignRight || alignment === Qt.AlignBottom

    implicitWidth: parent.width
    implicitHeight: 1

    gradient: Gradient {
        orientation: horizontalOrientation ? Gradient.Horizontal : Gradient.Vertical

        GradientStop {
            position: startsTransparent ? 0.0 + leaveInterval : 0.0
            color: startsTransparent ? "transparent" : (applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080")
        }
        GradientStop {
            position: centered ? 0.5 - stayInterval : alignment === Qt.AlignLeft || alignment === Qt.AlignTop ? stayInterval : 1 - stayInterval
            color: startsTransparent || !centered ? (applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080") : "transparent"
        }
        GradientStop {
            position: centered ? 0.5 + stayInterval : alignment === Qt.AlignLeft || alignment === Qt.AlignTop ? stayInterval : 1 - stayInterval
            color: startsTransparent || !centered ? (applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080") : "transparent"
        }
        GradientStop {
            position: centered || !startsTransparent ? 1.0 - leaveInterval : 1.0
            color: centered || !startsTransparent ? "transparent" : (applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080")
        }
    } // Gradient
}
