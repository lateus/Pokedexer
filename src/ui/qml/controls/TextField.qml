import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

T.TextField {
    id: control

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4

    color: control.palette.text
    selectionColor: control.palette.highlight
    selectedTextColor: control.palette.highlightedText
    placeholderTextColor: control.palette.placeholderText
    verticalAlignment: TextInput.AlignVCenter

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        border.width: control.activeFocus ? 2 : 1
        color: control.palette.base
        border.color: control.activeFocus ? control.palette.highlight : control.palette.mid
    }

    Menu {
        id: contextMenu

        focus: false

        ItemDelegate  { text: qsTr("Cut");        icon.source: "qrc:/images/icons/actions/content_cut.svg";           onClicked: { control.cut(); contextMenu.close() }       enabled: control.selectedText && control.echoMode === TextField.Normal }
        ItemDelegate  { text: qsTr("Copy");       icon.source: "qrc:/images/icons/actions/content_copy.svg";          onClicked: { control.copy(); contextMenu.close() }      enabled: control.selectedText && control.echoMode === TextField.Normal }
        ItemDelegate  { text: qsTr("Paste");      icon.source: "qrc:/images/icons/actions/content_paste.svg";         onClicked: { control.paste(); contextMenu.close() }     enabled: control.canPaste }
        MenuSeparator { }
        ItemDelegate  { text: qsTr("Select all"); icon.source: "qrc:/images/icons/actions/content_all_selection.svg"; onClicked: { control.selectAll(); contextMenu.close() } enabled: control.selectedText !== control.text }
        MenuSeparator { }
        ItemDelegate  { text: qsTr("Undo");       icon.source: "qrc:/images/icons/actions/content_undo.svg";          onClicked: { control.undo(); contextMenu.close() }      enabled: control.canUndo }
        ItemDelegate  { text: qsTr("Redo");       icon.source: "qrc:/images/icons/actions/content_redo.svg";          onClicked: { control.redo(); contextMenu.close() }      enabled: control.canRedo }
    }

    onReleased: function(event) {
        if (event.button === Qt.RightButton) {
            control.focus = true
            contextMenu.popup()
        }
        if (!control.activeFocus) {
            itemAccentBackground.centerX = event.x
        }
    }
}
