import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Page {
    id: pageTypeDetails

    property int typeId: 1
    property string name
    property int generation: 1
    property var superEffectiveTo
    property var notVeryEffectiveTo
    property var nullTo
    property var superEffectiveFrom
    property var notVeryEffectiveFrom
    property var nullFrom
    property string additionalInfo

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height
        contentHeight: labelName.height + rectangleSeparator.height + imageTypeIcon.height + rectangleSuperEffectiveTo.height + rectangleNotVeryEffectiveTo.height + rectangleNullTo.height + rectangleSuperEffectiveFrom.height + rectangleNotVeryEffectiveFrom.height + rectangleNullFrom.height + _labelTechnicalDetails.height + rectangleAdditionalInformation.height + 160

        Label {
            id: labelName

            y: 12
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: Qt.application.font.pointSize * 1.2
            font.bold: true
            elide: Text.ElideRight
            text: pageTypeDetails.name
            textFormat: Text.PlainText
        }

        RectangleSeparator {
            id: rectangleSeparator
            y: labelName.y + labelName.height + 12
        }

        // Icon
        Image {
            id: imageTypeIcon

            x: (parent.width - width)/2
            y: rectangleSeparator.y + rectangleSeparator.height + 12

            source: "qrc:/images/types/types/" + pageTypeDetails.typeId + ".svg"
            sourceSize: "128x128"
        }

        /// DAMAGE TO

        // Super effective to
        Rectangle {
            id: rectangleSuperEffectiveTo

            x: 12
            y: imageTypeIcon.y + imageTypeIcon.height + 12
            width: parent.width - 2*x
            height: __labelx2.height + flowSuperEffectiveTo.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelx2

                x: (parent.width - width - _labelx2.width)/2
                y: 6

                padding: 6
                text: "x2"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Red
                textFormat: Text.PlainText

                background: Rectangle {
                    width: __labelx2.width
                    height: __labelx2.height

                    color: __labelx2.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelx2

                x: __labelx2.x + __labelx2.width + 5
                y: __labelx2.y + (__labelx2.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Super effective to")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowSuperEffectiveTo

                x: (parent.width - width)/2
                y: __labelx2.y + __labelx2.height + 5
                width: repeaterSuperEffectiveTo.count <= 1 ? 100 : (rectangleSuperEffectiveTo.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterSuperEffectiveTo
                    model: pageTypeDetails.superEffectiveTo
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (super effective to)

        // Not very effective to
        Rectangle {
            id: rectangleNotVeryEffectiveTo

            x: 12
            y: rectangleSuperEffectiveTo.y + rectangleSuperEffectiveTo.height + 12
            width: parent.width - 2*x
            height: __labelxHalf.height + flowNotVeryEffectiveTo.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelxHalf

                x: (parent.width - width - _labelxHalf.width)/2
                y: 6

                padding: 6
                text: "x0.5"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Blue
                textFormat: Text.PlainText

                background: Rectangle {
                    width: __labelxHalf.width
                    height: __labelxHalf.height

                    color: __labelxHalf.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelxHalf

                x: __labelxHalf.x + __labelxHalf.width + 5
                y: __labelxHalf.y + (__labelxHalf.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Not very effective to")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowNotVeryEffectiveTo

                x: (parent.width - width)/2
                y: __labelxHalf.y + __labelxHalf.height + 5
                width: repeaterNotVeryEffectiveTo.count <= 1 ? 100 : (rectangleNotVeryEffectiveTo.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterNotVeryEffectiveTo
                    model: pageTypeDetails.notVeryEffectiveTo
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (not very effective to)

        // Null to
        Rectangle {
            id: rectangleNullTo

            x: 12
            y: rectangleNotVeryEffectiveTo.y + rectangleNotVeryEffectiveTo.height + 12
            width: parent.width - 2*x
            height: __labelx0.height + flowNullTo.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelx0

                x: (parent.width - width - _labelx0.width)/2
                y: 6

                padding: 6
                text: "x0"
                font.bold: true
                color: Material.dialogColor
                Material.accent: Material.Brown
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelx0.width
                    height: __labelx0.height

                    color:  __labelx0.Material.accent
                    radius: 6
                }
            }

            Label {
                id: _labelx0

                x: __labelx0.x +  __labelx0.width + 5
                y: __labelx0.y + (__labelx0.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Null to")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowNullTo

                x: (parent.width - width)/2
                y: __labelx0.y + __labelx0.height + 5
                width: repeaterNullTo.count <= 1 ? 100 : (rectangleNullTo.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterNullTo
                    model: pageTypeDetails.nullTo
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (null to)

        /// DAMAGE FROM

        // Super effective from
        Rectangle {
            id: rectangleSuperEffectiveFrom

            x: 12
            y: rectangleNullTo.y + rectangleNullTo.height + 12
            width: parent.width - 2*x
            height: __labelTakesx2.height + flowSuperEffectiveFrom.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelTakesx2

                x: (parent.width - width - _labelTakesx2.width)/2
                y: 6

                padding: 6
                text: "x2"
                font.bold: true
                Material.accent: Material.Red
                textFormat: Text.PlainText

                background: Rectangle {
                    width: __labelTakesx2.width
                    height: __labelTakesx2.height

                    border.width: 3
                    border.color: __labelTakesx2.Material.accent
                    color: "transparent"
                    radius: 6
                }
            }

            Label {
                id: _labelTakesx2

                x: __labelTakesx2.x +  __labelTakesx2.width + 5
                y: __labelTakesx2.y + (__labelTakesx2.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Takes super effective from")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowSuperEffectiveFrom

                x: (parent.width - width)/2
                y: __labelTakesx2.y + __labelTakesx2.height + 5
                width: repeaterSuperEffectiveFrom.count <= 1 ? 100 : (rectangleSuperEffectiveFrom.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterSuperEffectiveFrom
                    model: pageTypeDetails.superEffectiveFrom
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (super effective from)

        // Not very effective from
        Rectangle {
            id: rectangleNotVeryEffectiveFrom

            x: 12
            y: rectangleSuperEffectiveFrom.y + rectangleSuperEffectiveFrom.height + 12
            width: parent.width - 2*x
            height: __labelTakesxHalf.height + flowNotVeryEffectiveFrom.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelTakesxHalf

                x: (parent.width - width - _labelTakesxHalf.width)/2
                y: 6

                padding: 6
                text: "x0.5"
                font.bold: true
                Material.accent: Material.Blue
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelTakesxHalf.width
                    height: __labelTakesxHalf.height

                    border.width: 3
                    border.color: __labelTakesxHalf.Material.accent
                    color: "transparent"
                    radius: 6
                }
            }

            Label {
                id: _labelTakesxHalf

                x: __labelTakesxHalf.x +  __labelTakesxHalf.width + 5
                y: __labelTakesxHalf.y + (__labelTakesxHalf.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Takes not very effective from")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowNotVeryEffectiveFrom

                x: (parent.width - width)/2
                y: __labelTakesxHalf.y + __labelTakesxHalf.height + 5
                width: repeaterNotVeryEffectiveFrom.count <= 1 ? 100 : (rectangleNotVeryEffectiveFrom.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterNotVeryEffectiveFrom
                    model: pageTypeDetails.notVeryEffectiveFrom
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (not very effective from)

        // Null from
        Rectangle {
            id: rectangleNullFrom

            x: 12
            y: rectangleNotVeryEffectiveFrom.y + rectangleNotVeryEffectiveFrom.height + 12
            width: parent.width - 2*x
            height: __labelTakesx0.height + flowNullFrom.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: __labelTakesx0

                x: (parent.width - width - _labelTakesx0.width)/2
                y: 6

                padding: 6
                text: "x0"
                font.bold: true
                Material.accent: Material.Brown
                textFormat: Text.PlainText

                background: Rectangle {
                    width:  __labelTakesx0.width
                    height: __labelTakesx0.height

                    border.width: 3
                    border.color: __labelTakesx0.Material.accent
                    color: "transparent"
                    radius: 6
                }
            }

            Label {
                id: _labelTakesx0

                x: __labelTakesx0.x +  __labelTakesx0.width + 5
                y: __labelTakesx0.y + (__labelTakesx0.height - height)/2

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Takes null from")
                font.bold: true
                textFormat: Text.PlainText
            }

            Flow {
                id: flowNullFrom

                x: (parent.width - width)/2
                y: __labelTakesx0.y + __labelTakesx0.height + 5
                width: repeaterNullFrom.count <= 1 ? 100 : (rectangleNullFrom.width > 212 ? 200 : 100)

                Repeater {
                    id: repeaterNullFrom
                    model: pageTypeDetails.nullFrom
                    delegate: TypeTag {
                        type: ~~modelData
                        sourceSize.height: 36
                    }
                }
            }
        } // Rectangle (null from)

        Rectangle {
            y: _labelTechnicalDetails.y + _labelTechnicalDetails.height/2
            width: (parent.width - _labelTechnicalDetails.width)/2 - 6
            height: 1

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0;
                    color: "transparent";
                }
                GradientStop {
                    position: 1.0;
                    color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080";
                }
            } // Gradient
        } // Rectangle

        Label {
            id: _labelTechnicalDetails

            x: (parent.width - width)/2
            y: rectangleNullFrom.y + rectangleNullFrom.height + 12

            text: qsTr("Technical details")
            font.bold: true
            textFormat: Text.PlainText
        }

        Rectangle {
            x: (parent.width + _labelTechnicalDetails.width)/2 + 6
            y: _labelTechnicalDetails.y + _labelTechnicalDetails.height/2
            width: (parent.width - _labelTechnicalDetails.width)/2 - 6
            height: 1

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 1.0;
                    color: "transparent";
                }
                GradientStop {
                    position: 0.0;
                    color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080";
                }
            } // Gradient
        } // Rectangle

        // Additional information
        Rectangle {
            id: rectangleAdditionalInformation

            x: 12
            y: _labelTechnicalDetails.y + _labelTechnicalDetails.height + 12
            width: parent.width - 2*x
            height: _labelAdditionalInformation.height + labelAdditionalInformation.height + 20

            color: pageTypeDetails.Material.dialogColor
            radius: 12
            clip: true

            Label {
                id: _labelAdditionalInformation

                y: 6
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Additional information")
                font.bold: true
                textFormat: Text.PlainText
            }

            Label {
                id: labelAdditionalInformation

                x: 6
                y: _labelAdditionalInformation.y + _labelAdditionalInformation.height + 5
                width: parent.width - 2*x

                horizontalAlignment: Text.AlignHCenter
                text: pageTypeDetails.additionalInfo ? pageTypeDetails.additionalInfo : qsTr("Not available")
                enabled: pageTypeDetails.additionalInfo
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
            }
        } // Rectangle (additional info)

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    } // Flickable
}
