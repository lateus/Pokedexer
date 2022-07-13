import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls.Material 2.15

T.ScrollBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 2
    visible: control.policy !== T.ScrollBar.AlwaysOff
    minimumSize: orientation === Qt.Horizontal ? height / width : width / height

    contentItem: Rectangle {
        implicitWidth: 6
        implicitHeight: 6
        radius: width/2

        color: control.pressed ? control.Material.scrollBarPressedColor :
               control.interactive && control.hovered ? control.Material.scrollBarHoveredColor : control.Material.scrollBarColor
        opacity: 0.0
    }

    background: Rectangle {
        implicitWidth: 6
        implicitHeight: 6
        radius: width/2
        color: "#0e000000"
        opacity: 0.0
    }

    states: State {
        name: "active"
        when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
    }

    transitions: [
        Transition {
            to: "active"
            NumberAnimation { targets: [control.contentItem, control.background]; property: "opacity"; to: 1.0 }
        },
        Transition {
            from: "active"
            SequentialAnimation {
                PropertyAction{ targets: [control.contentItem, control.background]; property: "opacity"; value: 1.0 }
                PauseAnimation { duration: 2450 }
                NumberAnimation { targets: [control.contentItem, control.background]; property: "opacity"; to: 0.0 }
            }
        }
    ]
}
