import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    id: singleStatEditor

    enum NatureBonus { NoNatureBonus, NatureBonusUp, NatureBonusDown }
    property int natureBonus: SingleStatEditor.NatureBonus.NoNatureBonus

    readonly property int maxIvValue: 31
    readonly property int maxEvValue: 255

    property alias evValue: sliderEv.value
    property int maxAllowedEvValue: maxEvValue
    property int ivValue: maxIvValue

    property int statValue: 0

    property alias borderColor: rectangleRoot.border.color

    property alias statName: labelStatName.text
    property alias statNameColor: labelStatName.color
    property alias statNameWidth: labelStatName.width

    signal statNameClicked()

    implicitHeight: 20

    Rectangle {
        id: rectangleRoot

        width: parent.width - buttonFinalStatValue.width - 2
        height: parent.height
        radius: height/2
        border.width: 0
        border.color: Material.theme === Material.Light ? "#333333" : "#FFFFFF"
        color: "transparent"

        Label {
            id: labelStatName
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            leftPadding: 8
            rightPadding: 8
            elide: Text.ElideRight

            font.bold: true
            font.pixelSize: height/2
            color: buttonFinalStatValue.Material.foreground
            textFormat: Text.PlainText

            Button {
                id: buttonNatureBonusIcon
                x: -width + parent.leftPadding + 2*padding - 2
                height: parent.height
                width: height

                padding: 3
                bottomInset: 0
                topInset: 0
                flat: true
                visible: icon.source
                icon.source: natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus ? "" : "qrc:/images/icons/actions/" + (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? "add" : "remove") + ".svg"
                icon.color: labelStatName.color
                background: null
            }

            MouseArea {
                x: buttonNatureBonusIcon.x
                y: -parent.height/8
                width: parent.width + x + (statNameWidth - parent.width)
                height: parent.height + 2*(-y)

                onClicked: statNameClicked()
            }
        }

        Slider {
            id: sliderEv
            x: statNameWidth
            y: (parent.height - height)/2
            width: parent.width - x
            implicitHeight: singleStatEditor.implicitHeight

            Material.accent: natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus ? rectangleRoot.border.color : buttonFinalStatValue.Material.foreground
            to: 252
            stepSize: 4
            snapMode: Slider.SnapAlways
            onValueChanged: {
                if (value > maxAllowedEvValue) {
                    value = maxAllowedEvValue
                }
            }

            ToolTip {
                parent: sliderEv.handle
                visible: sliderEv.pressed
                text: sliderEv.value
            }
        }
    } // Rectangle (root)

    Button {
        id: buttonFinalStatValue
        x: parent.width - width + 2
        height: parent.height
        width: 30

        Material.accent: natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus ? applicationWindow.Material.foreground : natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? Material.Red : Material.Blue
        Material.foreground: Material.accent

        text: statValue
        flat: true
        padding: 0
        topInset: 0
        bottomInset: 0
        leftInset: 0
        rightInset: 0
    }
}
