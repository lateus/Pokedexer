import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Dialog {
    id: messageDialog

    enum MessageType { Information, Warning, Error, Question, Custom }

    property int messageType: MessageDialog.MessageType.Information
    property alias text: labelMessage.text
    property url customImageSource // will be used when the `messageType` is set to `Custom`
    property alias imageSize: imageMessageType.sourceSize

    contentWidth: imageMessageType.width + labelMessage.implicitWidth + rowContent.spacing > 300 ? 300 : imageMessageType.width + labelMessage.implicitWidth + rowContent.spacing
    contentHeight: flickable.contentHeight

    title: qsTr("Message")
    standardButtons: messageType === MessageDialog.MessageType.Question ? Dialog.Yes | Dialog.No : Dialog.Ok

    Flickable {
        id: flickable
        
        width: parent.width
        height: parent.height
        contentWidth: width
        contentHeight: Math.max(imageMessageType.height, labelMessage.implicitHeight)
        clip: true

        Row {
            id: rowContent
            width: parent.width
            spacing: 10

            Image {
                id: imageMessageType

                readonly property var imageTypesSources: ["info", "warn", "error", "help"]

                source: messageType >= MessageDialog.MessageType.Custom ? customImageSource : ("qrc:/images/icons/status/status_" + imageTypesSources[messageType] + (Material.theme === Material.Light ? "_light" : "_dark") + ".svg")
                sourceSize: Qt.size(64, 64)
            }
            Label {
                id: labelMessage
                width: parent.width - imageMessageType.width - parent.spacing
                text: qsTr("This is a message.")
                wrapMode: Text.Wrap
            }
        }

        ScrollIndicator.vertical: ScrollIndicator {
            parent: messageDialog.contentItem
            anchors.top: flickable.top
            anchors.bottom: flickable.bottom
            anchors.right: parent.right
            anchors.rightMargin: -messageDialog.rightPadding + 1
        }
    } // Flickable
}
