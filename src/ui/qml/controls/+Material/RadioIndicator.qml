import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

Rectangle {
    id: indicator
    implicitWidth: 20
    implicitHeight: 20
    radius: width / 2
    border.width: 2
    border.color: !control.enabled ? control.Material.hintTextColor
        : control.checked || control.down ? control.Material.accentColor : control.Material.secondaryTextColor
    Behavior on border.color { ColorAnimation { } }
    color: "transparent"

    property T.AbstractButton control

    Rectangle {
        id: rectangleInnerCircle
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: indicator.control.checked ? 10 : 0
        Behavior on width { NumberAnimation { easing.type: Easing.OutBack } }
        height: width
        radius: width / 2
        color: parent.border.color
    }
}
