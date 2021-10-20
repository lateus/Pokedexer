import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Page {
    id: pageTypePerformance

    readonly property var typeNames: [ qsTr("None"), qsTr("Normal"), qsTr("Fighting"), qsTr("Flying"), qsTr("Poison"), qsTr("Ground"), qsTr("Rock"), qsTr("Bug"), qsTr("Ghost"), qsTr("Steel"), qsTr("Fire"), qsTr("Water"), qsTr("Grass"), qsTr("Electric"), qsTr("Psychic"), qsTr("Ice"), qsTr("Dragon"), qsTr("Dark"), qsTr("Fairy") ]
    property alias type1: comboBoxType1.currentIndex
    property alias type2: comboBoxType2.currentIndex
    property bool readonly: false

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height
        contentHeight: comboBoxType1.height + rectangleWeakx4.height + rectangleWeakx2.height + rectangleNeutral.height + rectangleResistantx2.height + rectangleResistantx4.height + rectangleInmune.height + 100

        ComboBox {
            id: comboBoxType1

            onCurrentIndexChanged: {
                if (currentIndex === comboBoxType2.currentIndex - 1) {
                    comboBoxType2.currentIndex = 0
                }
            }

            x: 6
            y: 12
            width: parent.width/2 - 2*x

            enabled: !pageTypePerformance.readonly
            opacity: enabled ? 1.0 : 0.6
            model: pageTypePerformance.typeNames.slice(-18)

            delegate: MenuItem {
                width: parent.width
                text: comboBoxType1.textRole ? (Array.isArray(comboBoxType1.model) ? modelData[comboBoxType1.textRole] : model[comboBoxType1.textRole]) : modelData
                Material.foreground: comboBoxType1.currentIndex === index ? parent.Material.accent : parent.Material.foreground
                highlighted: comboBoxType1.highlightedIndex === index
                hoverEnabled: comboBoxType1.hoverEnabled
                icon.source: "qrc:/images/types/types/icons/" + (index + 1) + ".svg"
                icon.color: "transparent"
            }
        }

        ComboBox {
            id: comboBoxType2

            onCurrentIndexChanged: {
                if (currentIndex === comboBoxType1.currentIndex + 1) {
                    currentIndex = currentIndex === count - 1 ? 0 : currentIndex + 1
                }
            }

            x: parent.width/2 + 6
            y: comboBoxType1.y
            width: comboBoxType1.width

            enabled: !pageTypePerformance.readonly
            opacity: enabled ? 1.0 : 0.6
            model: pageTypePerformance.typeNames

            delegate: MenuItem {
                width: parent.width
                height: index === comboBoxType1.currentIndex + 1 ? 0 : implicitHeight
                text: comboBoxType2.textRole ? (Array.isArray(comboBoxType2.model) ? modelData[comboBoxType2.textRole] : model[comboBoxType2.textRole]) : modelData
                Material.foreground: comboBoxType2.currentIndex === index ? parent.Material.accent : parent.Material.foreground
                highlighted: comboBoxType2.highlightedIndex === index
                hoverEnabled: comboBoxType2.hoverEnabled
                icon.source: "qrc:/images/types/types/icons/" + index + ".svg"
                icon.color: "transparent"
            }
        }

        // Icon
        Image {
            id: imageType1Icon

            x: comboBoxType1.x - (parent.width - width)/3
            y: comboBoxType1.y + (comboBoxType1.height - height)/2
            z: -1

            source: comboBoxType1.currentIndex >= 0 ? ("qrc:/images/types/types/" + (comboBoxType1.currentIndex + 1) + ".svg") : ""
            sourceSize: Qt.size(comboBoxType1.width + 20, comboBoxType1.width + 20)
            opacity: 0.25
        }

        // Icon
        Image {
            id: imageType2Icon

            x: comboBoxType2.x + (parent.width - width)/3 - 20 // + 20 in the source size of imageType1
            y: imageType1Icon.y
            z: -1

            source: comboBoxType2.currentIndex >= 0 ? ("qrc:/images/types/types/" + comboBoxType2.currentIndex + ".svg") : ""
            sourceSize: imageType1Icon.sourceSize
            opacity: 0.25
        }

        /// WEAK TO

        // Weak (x4)
        Rectangle {
            id: rectangleWeakx4

            x: 12
            y: comboBoxType1.y + comboBoxType1.height + 12
            width: parent.width - 2*x
            height: __labelWeakx4.height + flowWeakx4.height + 20

            color: pageTypePerformance.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelWeakx4

                x: (parent.width - width - _labelWeakx4.width)/2
                y: 6

                padding: 6
                text: "x4"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Red
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelWeakx4.width
                    height: __labelWeakx4.height

                    color: __labelWeakx4.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelWeakx4

                x: __labelWeakx4.x +  __labelWeakx4.width + 5
                y: __labelWeakx4.y + (__labelWeakx4.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Super effective")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowWeakx4

                x: (parent.width - width)/2
                y: __labelWeakx4.y + __labelWeakx4.height + 5
                width: repeaterWeakx4.count <= 1 ? 100 : (rectangleWeakx4.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterWeakx4
                    model: modelTypes.getWeakness_x4(comboBoxType1.currentIndex + 1, comboBoxType2.currentIndex)
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (weak x4)

        // Weak to (x2)
        Rectangle {
            id: rectangleWeakx2

            x: 12
            y: rectangleWeakx4.y + rectangleWeakx4.height + 12
            width: parent.width - 2*x
            height: __labelWeakx2.height + flowWeakx2.height + 20

            color: pageTypePerformance.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelWeakx2

                x: (parent.width - width - _labelWeakx2.width)/2
                y: 6

                padding: 6
                text: "x2"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Amber
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelWeakx2.width
                    height: __labelWeakx2.height

                    color: __labelWeakx2.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelWeakx2

                x: __labelWeakx2.x +  __labelWeakx2.width + 5
                y: __labelWeakx2.y + (__labelWeakx2.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Super effective")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowWeakx2

                x: (parent.width - width)/2
                y: __labelWeakx2.y + __labelWeakx2.height + 5
                width: repeaterWeakx2.count <= 1 ? 100 : (rectangleWeakx2.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterWeakx2
                    model: modelTypes.getWeakness_x2(comboBoxType1.currentIndex + 1, comboBoxType2.currentIndex)
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (weak x2)

        /// NEUTRAL

        // Neutral (x1)
        Rectangle {
            id: rectangleNeutral

            x: 12
            y: rectangleWeakx2.y + rectangleWeakx2.height + 12
            width: parent.width - 2*x
            height: __labelNeutral.height + flowNeutral.height + 20

            color: pageTypePerformance.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelNeutral

                x: (parent.width - width - _labelNeutral.width)/2
                y: 6

                padding: 6
                text: "x1"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Green
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelNeutral.width
                    height: __labelNeutral.height

                    color: __labelNeutral.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelNeutral

                x: __labelNeutral.x +  __labelNeutral.width + 5
                y: __labelNeutral.y + (__labelNeutral.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Neutral")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowNeutral

                x: (parent.width - width)/2
                y: __labelNeutral.y + __labelNeutral.height + 5
                width: repeaterNeutral.count <= 1 ? 100 : (rectangleNeutral.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterNeutral
                    model: modelTypes.getNeutrality_x1(comboBoxType1.currentIndex + 1, comboBoxType2.currentIndex)
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (neutral x1)

        /// RESISTANT

        // Resistant (x2)
        Rectangle {
            id: rectangleResistantx2

            x: 12
            y: rectangleNeutral.y + rectangleNeutral.height + 12
            width: parent.width - 2*x
            height: __labelResistantx2.height + flowResistantx2.height + 20

            color: pageTypePerformance.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelResistantx2

                x: (parent.width - width - _labelResistantx2.width)/2
                y: 6

                padding: 6
                text: "x0.5"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Blue
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelResistantx2.width
                    height: __labelResistantx2.height

                    color: __labelResistantx2.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelResistantx2

                x: __labelResistantx2.x +  __labelResistantx2.width + 5
                y: __labelResistantx2.y + (__labelResistantx2.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Not very effective")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowResistantx2

                x: (parent.width - width)/2
                y: __labelResistantx2.y + __labelResistantx2.height + 5
                width: repeaterResistantx2.count <= 1 ? 100 : (rectangleResistantx2.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterResistantx2
                    model: modelTypes.getResistence_x2(comboBoxType1.currentIndex + 1, comboBoxType2.currentIndex)
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (resistant x2)

        // Resistant (x4)
        Rectangle {
            id: rectangleResistantx4

            x: 12
            y: rectangleResistantx2.y + rectangleResistantx2.height + 12
            width: parent.width - 2*x
            height: __labelResistantx4.height + flowResistantx4.height + 20

            color: pageTypePerformance.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelResistantx4

                x: (parent.width - width - _labelResistantx4.width)/2
                y: 6

                padding: 6
                text: "x0.25"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.DeepPurple
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelResistantx4.width
                    height: __labelResistantx4.height

                    color:  __labelResistantx4.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelResistantx4

                x: __labelResistantx4.x +  __labelResistantx4.width + 5
                y: __labelResistantx4.y + (__labelResistantx4.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Not very effective")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowResistantx4

                x: (parent.width - width)/2
                y: __labelResistantx4.y + __labelResistantx4.height + 5
                width: repeaterResistantx4.count <= 1 ? 100 : (rectangleResistantx4.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterResistantx4
                    model: modelTypes.getResistence_x4(comboBoxType1.currentIndex + 1, comboBoxType2.currentIndex)
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (resistant x4)

        // Inmune (x0)
        Rectangle {
            id: rectangleInmune

            x: 12
            y: rectangleResistantx4.y + rectangleResistantx4.height + 12
            width: parent.width - 2*x
            height: __labelInmune.height + flowInmune.height + 20

            color: pageTypePerformance.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelInmune

                x: (parent.width - width - _labelInmune.width)/2
                y: 6

                padding: 6
                text: "x0"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Brown
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelInmune.width
                    height: __labelInmune.height

                    color:  __labelInmune.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelInmune

                x: __labelInmune.x +  __labelInmune.width + 5
                y: __labelInmune.y + (__labelInmune.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Inmune")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowInmune

                x: (parent.width - width)/2
                y: __labelInmune.y + __labelInmune.height + 5
                width: repeaterInmune.count <= 1 ? 100 : (rectangleInmune.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterInmune
                    model: modelTypes.getInmunity_x0(comboBoxType1.currentIndex + 1, comboBoxType2.currentIndex)
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (inmune x0)

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // Flickable
}
