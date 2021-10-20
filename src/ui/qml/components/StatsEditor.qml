import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Item {
    id: statsEditor

    implicitWidth: 120
    implicitHeight: singleStatEditorHp.height + singleStatEditorAttack.height + singleStatEditorDefense.height + singleStatEditorSpecialAttack.height + singleStatEditorSpecialDefense.height + singleStatEditorSpeed.height + spinBoxLevel.height + labelNotes.height + 40

    enum Stat { None, Hp, Attack, Defense, SpecialAttack, SpecialDefense, Speed }

    required property int baseHp
    required property int baseAttack
    required property int baseDefense
    required property int baseSpecialAttack
    required property int baseSpecialDefense
    required property int baseSpeed

    readonly property alias level: spinBoxLevel.value

    readonly property alias statHpEvValue: singleStatEditorHp.evValue
    readonly property alias statHpIvValue: singleStatEditorHp.ivValue

    readonly property alias statAttackEvValue: singleStatEditorAttack.evValue
    readonly property alias statAttackIvValue: singleStatEditorAttack.ivValue

    readonly property alias statDefenseEvValue: singleStatEditorDefense.evValue
    readonly property alias statDefenseIvValue: singleStatEditorDefense.ivValue

    readonly property alias statSpecialAttackEvValue: singleStatEditorSpecialAttack.evValue
    readonly property alias statSpecialAttackIvValue: singleStatEditorSpecialAttack.ivValue

    readonly property alias statSpecialDefenseEvValue: singleStatEditorSpecialDefense.evValue
    readonly property alias statSpecialDefenseIvValue: singleStatEditorSpecialDefense.ivValue

    readonly property alias statSpeedEvValue: singleStatEditorSpeed.evValue
    readonly property alias statSpeedIvValue: singleStatEditorSpeed.ivValue

    readonly property int statsSum: singleStatEditorHp.evValue + singleStatEditorAttack.evValue + singleStatEditorDefense.evValue + singleStatEditorSpecialAttack.evValue + singleStatEditorSpecialDefense.evValue + singleStatEditorSpeed.evValue

    readonly property bool isNeutralNature: singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus

    function resetNatureBonus() {
        singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorDefense.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorSpecialDefense.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorSpeed.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
    }

    SingleStatEditor {
        id: singleStatEditorHp
        
        width: parent.width
        
        statName: qsTr("HP")
        statNameWidth: 80
        maxAllowedEvValue: (510 - statsSum + evValue) < 0 ? 0 : (510 - statsSum + evValue)
        statValue: Backend.StatCalculator.calculateStat(7, StatsEditor.Stat.Hp, baseHp, ivValue, evValue, level, natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? 1 : natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? -1 : 0)
    }

    SingleStatEditor {
        id: singleStatEditorAttack

        y: singleStatEditorHp.y + singleStatEditorHp.height + 5
        width: parent.width

        statName: qsTr("Attack")
        statNameWidth: 80
        maxAllowedEvValue: (510 - statsSum + evValue) < 0 ? 0 : (510 - statsSum + evValue)
        statValue: Backend.StatCalculator.calculateStat(7, StatsEditor.Stat.Attack, baseAttack, ivValue, evValue, level, natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? 1 : natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? -1 : 0)

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                if (singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                    singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorDefense.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                }
                natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
            } else {
                if (isNeutralNature) {
                    singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                    singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                    singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                    singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
                }

                natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
        }
    }

    SingleStatEditor {
        id: singleStatEditorDefense

        y: singleStatEditorAttack.y + singleStatEditorAttack.height + 5
        width: parent.width

        statName: qsTr("Defense")
        statNameWidth: 80
        maxAllowedEvValue: (510 - statsSum + evValue) < 0 ? 0 : (510 - statsSum + evValue)
        statValue: Backend.StatCalculator.calculateStat(7, StatsEditor.Stat.Defense, baseDefense, ivValue, evValue, level, natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? 1 : natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? -1 : 0)

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                if (singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                    singleStatEditorSpecialDefense.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                }
                natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
            } else {
                if (isNeutralNature) {
                    singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                    singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                    singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                    singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
                }
                natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
        }
    }

    SingleStatEditor {
        id: singleStatEditorSpecialAttack

        y: singleStatEditorDefense.y + singleStatEditorDefense.height + 5
        width: parent.width

        statName: qsTr("Sp. Attack")
        statNameWidth: 80
        maxAllowedEvValue: (510 - statsSum + evValue) < 0 ? 0 : (510 - statsSum + evValue)
        statValue: Backend.StatCalculator.calculateStat(7, StatsEditor.Stat.SpecialAttack, baseSpecialAttack, ivValue, evValue, level, natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? 1 : natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? -1 : 0)

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                if (singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                    singleStatEditorSpeed.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorSpecialDefense.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                }
                natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
            } else {
                if (isNeutralNature) {
                    singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                    singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                    singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                    singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
                }
                natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
        }
    }

    SingleStatEditor {
        id: singleStatEditorSpecialDefense

        y: singleStatEditorSpecialAttack.y + singleStatEditorSpecialAttack.height + 5
        width: parent.width

        statName: qsTr("Sp. Defense")
        statNameWidth: 80
        maxAllowedEvValue: (510 - statsSum + evValue) < 0 ? 0 : (510 - statsSum + evValue)
        statValue: Backend.StatCalculator.calculateStat(7, StatsEditor.Stat.SpecialDefense, baseSpecialDefense, ivValue, evValue, level, natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? 1 : natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? -1 : 0)

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                if (singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                    singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorSpeed.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                }
                natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
            } else {
                if (isNeutralNature) {
                    singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                    singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                    singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                    singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
                }
                natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
        }
    }

    SingleStatEditor {
        id: singleStatEditorSpeed

        y: singleStatEditorSpecialDefense.y + singleStatEditorSpecialDefense.height + 5
        width: parent.width

        statName: qsTr("Speed")
        statNameWidth: 80
        maxAllowedEvValue: (510 - statsSum + evValue) < 0 ? 0 : (510 - statsSum + evValue)
        statValue: Backend.StatCalculator.calculateStat(7, StatsEditor.Stat.Speed, baseSpeed, ivValue, evValue, level, natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? 1 : natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? -1 : 0)

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                if (singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                    singleStatEditorDefense.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                }
                natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
            } else {
                if (isNeutralNature) {
                    singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                    singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                    singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                    singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                }
                natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
        }
    }

    SpinBox {
        id: spinBoxLevel

        y: singleStatEditorSpeed.y + singleStatEditorSpeed.height + 5
        width: parent.width

        from: 10
        to: 100
        stepSize: 10
        value: 50
        textFromValue: function(value) {
            return qsTr("Level") + " " + value
        }
    }

    Label {
        id: labelNotes
        y: spinBoxLevel.y + spinBoxLevel.height + 5
        width: parent.width

        horizontalAlignment: Text.AlignHCenter
        text: qsTr("All IVs are set to 31") + "\n" +
              qsTr("Click the stat's names to set nature")
        wrapMode: Text.Wrap
        textFormat: Text.PlainText
    }
}
