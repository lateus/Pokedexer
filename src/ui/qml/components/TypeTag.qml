import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    id: typeTag

    property int type: 1
    readonly property var typeNames: [ qsTr("None"), qsTr("Normal"), qsTr("Fight"), qsTr("Flying"), qsTr("Poison"), qsTr("Earth"), qsTr("Rock"), qsTr("Bug"), qsTr("Ghost"), qsTr("Steel"), qsTr("Fire"), qsTr("Water"), qsTr("Grass"), qsTr("Electric"), qsTr("Psychic"), qsTr("Ice"), qsTr("Dragon"), qsTr("Dark"), qsTr("Fairy") ]

    source: "qrc:/images/types/types/tags/" + type + ".svg"
    fillMode: Image.PreserveAspectFit
    
    Label {
        x: typeTag.height/2
        y: (parent.height - height)/2
        width: parent.width - x

        horizontalAlignment: Text.AlignHCenter
        text: typeTag.typeNames[typeTag.type].toUpperCase()
        color: "white"
        font.bold: true
        font.pixelSize: Math.floor(typeTag.height/3)
        elide: Text.ElideRight
        textFormat: Text.PlainText
    }
}
