import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Dialog {
    id: textEditDialog

    property alias text: textField.text
    property alias placeholderText: textField.placeholderText
    property bool allowOK: true
    property string errorMessage // related to `allowOK`

    onAboutToShow: {
        textField.forceActiveFocus()
    }

    contentWidth: textField.width > 300 ? 300 : textField.width
    contentHeight: textField.height + labelErrorMessage.height

    title: qsTr("Message")
    standardButtons: Dialog.Ok | Dialog.Cancel
    Binding { target: { textEditDialog.visible; return textEditDialog.standardButton(Dialog.Ok) } property: "enabled"; value: allowOK }

    TextField {
        id: textField

        selectByMouse: true
        inputMethodHints: Qt.ImhLatinOnly
    }

    Label {
        id: labelErrorMessage
        y: textField.y + textField.height
        width: textField.width

        Material.accent: Material.Red
        Material.foreground: Material.accent
        wrapMode: Text.Wrap
        text: errorMessage
        font.italic: true
    }
}
