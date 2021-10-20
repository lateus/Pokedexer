import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: textFieldSearch

    leftPadding: toolButtonSearch.width - 12
    rightPadding: toolButtonClearSearch.width - 12
    
    placeholderText: qsTr("Search")
    selectByMouse: true
    
    ToolButton {
        id: toolButtonSearch
        x: -6
        y: (parent.height - height)/2 - 3
        enabled: textFieldSearch.text
        background: null
        icon.source: "qrc:/images/icons/actions/search.svg"
    }
    
    ToolButton {
        id: toolButtonClearSearch
        x: parent.width - width + 6
        y: (parent.height - height)/2 - 3
        
        focusPolicy: Qt.NoFocus
        icon.source: "qrc:/images/icons/actions/clear.svg"
        opacity: scale
        rotation: 90 * scale
        scale: textFieldSearch.text ? 1 : 0
        Behavior on scale { NumberAnimation {} }
        
        onClicked: {
            textFieldSearch.clear()
        }
    }
}
