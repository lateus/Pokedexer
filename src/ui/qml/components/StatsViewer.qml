import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    id: statsViewer

    implicitWidth: 120
    implicitHeight: statAttributeBaseHp.height + statAttributeBaseAttack.height + statAttributeBaseDefense.height + statAttributeBaseSpAtk.height + statAttributeBaseSpDef.height + statAttributeBaseSpd.height + labelTotalStats.height + 45

    required property int maxHpValue
    required property int maxAttackValue
    required property int maxDefenseValue
    required property int maxSpecialAttackValue
    required property int maxSpecialDefenseValue
    required property int maxSpeedValue

    required property int hpValue
    required property int attackValue
    required property int defenseValue
    required property int specialAttackValue
    required property int specialDefenseValue
    required property int speedValue

    property bool contentVisible: true

    StatAttribute {
        id: statAttributeBaseHp

        width: parent.width

        visible: statsViewer.contentVisible
        maxValue: maxHpValue
        value: hpValue

        attributeName: qsTr("HP")
        attributeNameWidth: 80
        attributeValueColor: Material.dialogColor
    }

    StatAttribute {
        id: statAttributeBaseAttack

        y: statAttributeBaseHp.y + statAttributeBaseHp.height + 5
        width: parent.width

        visible: statsViewer.contentVisible
        maxValue: maxAttackValue
        value: attackValue

        attributeName: qsTr("Attack")
        attributeNameWidth: 80
        attributeValueColor: Material.dialogColor
    }

    StatAttribute {
        id: statAttributeBaseDefense

        y: statAttributeBaseAttack.y + statAttributeBaseAttack.height + 5
        width: parent.width

        visible: statsViewer.contentVisible
        maxValue: maxDefenseValue
        value: defenseValue

        attributeName: qsTr("Defense")
        attributeNameWidth: 80
        attributeValueColor: Material.dialogColor
    }

    StatAttribute {
        id: statAttributeBaseSpAtk

        y: statAttributeBaseDefense.y + statAttributeBaseDefense.height + 5
        width: parent.width

        visible: statsViewer.contentVisible
        maxValue: maxSpecialAttackValue
        value: specialAttackValue

        attributeName: qsTr("Sp. Attack")
        attributeNameWidth: 80
        attributeValueColor: Material.dialogColor
    }

    StatAttribute {
        id: statAttributeBaseSpDef

        y: statAttributeBaseSpAtk.y + statAttributeBaseSpAtk.height + 5
        width: parent.width

        visible: statsViewer.contentVisible
        maxValue: maxSpecialDefenseValue
        value: specialDefenseValue

        attributeName: qsTr("Sp. Defense")
        attributeNameWidth: 80
        attributeValueColor: Material.dialogColor
    }

    StatAttribute {
        id: statAttributeBaseSpd

        y: statAttributeBaseSpDef.y + statAttributeBaseSpDef.height + 5
        width: parent.width

        visible: statsViewer.contentVisible
        maxValue: maxSpeedValue
        value: speedValue

        attributeName: qsTr("Speed")
        attributeNameWidth: 80
        attributeValueColor: Material.dialogColor
    }

    Label {
        id: labelTotalStats

        y: statAttributeBaseSpd.y + statAttributeBaseSpd.height + 20
        width: parent.width

        visible: statsViewer.contentVisible
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Total") + ": " + (hpValue + attackValue + defenseValue + specialAttackValue + specialDefenseValue + speedValue)
        font.bold: true
        textFormat: Text.PlainText
    }
}
