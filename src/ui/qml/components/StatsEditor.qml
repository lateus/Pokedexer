import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Pokedexer 1.0 as Backend

Item {
    id: statsEditor

    implicitWidth: 120
    implicitHeight: itemLevelIvs.y + itemLevelIvs.height + 10

    enum Stat { None, Hp, Attack, Defense, SpecialAttack, SpecialDefense, Speed }
    enum Nature { NoneNature, Hardy, Bold, Modest, Calm, Timid, Lonely, Docile, Mild, Gentle, Hasty, Adamant, Impish, Bashful, Careful, Rash, Jolly, Naughty, Lax, Quirky, Naive, Brave, Relaxed, Quiet, Sassy, Serious }

    property bool simpleMode: true

    required property int baseHp
    required property int baseAttack
    required property int baseDefense
    required property int baseSpecialAttack
    required property int baseSpecialDefense
    required property int baseSpeed

    property alias level: sliderLevel.value

    property int natureId: StatsEditor.Nature.Hardy
    onNatureIdChanged: {
        var statUp   = modelNatures.getNatureData(natureId, Backend.ModelNatures.StatUpIdRole)
        var statDown = modelNatures.getNatureData(natureId, Backend.ModelNatures.StatDownIdRole)
        var singleStatEditors = [ singleStatEditorAttack, singleStatEditorDefense, singleStatEditorSpecialAttack, singleStatEditorSpecialDefense, singleStatEditorSpeed ]
        if (statUp === StatsEditor.Stat.None || statDown === StatsEditor.Stat.None) {
            resetNatureBonus(statUp === statDown)
        } else if (statUp === statDown || statUp === StatsEditor.Stat.Hp || statDown === StatsEditor.Stat.Hp || statUp > StatsEditor.Stat.Speed || statDown > StatsEditor.Stat.Speed || statsEditor[statUp - 2] === SingleStatEditor.NatureBonus.NatureBonusUp || statsEditor[statDown - 2] === SingleStatEditor.NatureBonus.NatureBonusDown) {
            return
        } else {
            for (var i = 0; i < singleStatEditors.length; ++i) {
                if (i === statUp - 2) {
                    singleStatEditors[i].natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
                } else if (i === statDown - 2) {
                    singleStatEditors[i].natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
                } else {
                    singleStatEditors[i].natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
                }
            }
        }
    }

    property alias statHpEvValue: singleStatEditorHp.evValue
    property alias statHpIvValue: singleStatEditorHp.ivValue

    property alias statAttackEvValue: singleStatEditorAttack.evValue
    property alias statAttackIvValue: singleStatEditorAttack.ivValue

    property alias statDefenseEvValue: singleStatEditorDefense.evValue
    property alias statDefenseIvValue: singleStatEditorDefense.ivValue

    property alias statSpecialAttackEvValue: singleStatEditorSpecialAttack.evValue
    property alias statSpecialAttackIvValue: singleStatEditorSpecialAttack.ivValue

    property alias statSpecialDefenseEvValue: singleStatEditorSpecialDefense.evValue
    property alias statSpecialDefenseIvValue: singleStatEditorSpecialDefense.ivValue

    property alias statSpeedEvValue: singleStatEditorSpeed.evValue
    property alias statSpeedIvValue: singleStatEditorSpeed.ivValue

    readonly property int statsSum: singleStatEditorHp.evValue + singleStatEditorAttack.evValue + singleStatEditorDefense.evValue + singleStatEditorSpecialAttack.evValue + singleStatEditorSpecialDefense.evValue + singleStatEditorSpeed.evValue

    readonly property bool isNeutralNature: singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus && singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NoNatureBonus

    function resetNatureBonus(updateNatureAfterwards = true) {
        singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorDefense.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorSpecialDefense.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        singleStatEditorSpeed.natureBonus = SingleStatEditor.NatureBonus.NoNatureBonus
        if (updateNatureAfterwards) {
            updateNature()
        }
    }

    function updateNature() { // BUG!
        console.log("updateNature()")
        var natureBonuses = [ singleStatEditorAttack.natureBonus, singleStatEditorDefense.natureBonus, singleStatEditorSpecialAttack.natureBonus, singleStatEditorSpecialDefense.natureBonus, singleStatEditorSpeed.natureBonus ]
        var statUp   = StatsEditor.Stat.None
        var statDown = StatsEditor.Stat.None
        for (var i = 0; i < natureBonuses.length; ++i) {
            if (natureBonuses[i] === SingleStatEditor.NatureBonus.NatureBonusUp) {
                statUp = i + 2
                console.log("1|", statUp, statDown, natureId, modelNatures.getNatureData(statsEditor.natureId, Backend.ModelNatures.NameRole))
            } else if (natureBonuses[i] === SingleStatEditor.NatureBonus.NatureBonusDown) {
                statDown = i + 2
                console.log("2|", statUp, statDown, natureId, modelNatures.getNatureData(statsEditor.natureId, Backend.ModelNatures.NameRole))
            }
        }
        statsEditor.natureId = modelNatures.getNatureIdFromStatBonus(statUp, statDown)
        console.log("3|", statUp, statDown, natureId, modelNatures.getNatureData(statsEditor.natureId, Backend.ModelNatures.NameRole))
    }

    Connections {
        id: connectionNatureChart
        target: pageNatureChart
        enabled: false

        function onNatureSelected(selectedNatureId) {
            statsEditor.natureId = selectedNatureId
            connectionNatureChart.enabled = false
        }
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

        onStatNamePressAndHold: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            updateNature()
        }

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorSpecialAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            updateNature()
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

        onStatNamePressAndHold: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorAttack.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            updateNature()
        }

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorAttack.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            updateNature()
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

        onStatNamePressAndHold: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            updateNature()
        }

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            updateNature()
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

        onStatNamePressAndHold: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            updateNature()
        }

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpeed.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpeed.natureBonus = singleStatEditorSpeed.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpeed.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            updateNature()
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

        onStatNamePressAndHold: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NatureBonusUp : singleStatEditorSpecialDefense.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            updateNature()
        }

        onStatNameClicked: {
            if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp) {
                resetNatureBonus()
                return
            } else if (natureBonus === SingleStatEditor.NatureBonus.NatureBonusDown) {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NatureBonusDown : singleStatEditorSpecialDefense.natureBonus
            } else {
                singleStatEditorAttack.natureBonus = singleStatEditorAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorAttack.natureBonus
                singleStatEditorDefense.natureBonus = singleStatEditorDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorDefense.natureBonus
                singleStatEditorSpecialAttack.natureBonus = singleStatEditorSpecialAttack.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialAttack.natureBonus
                singleStatEditorSpecialDefense.natureBonus = singleStatEditorSpecialDefense.natureBonus === SingleStatEditor.NatureBonus.NatureBonusUp ? SingleStatEditor.NatureBonus.NoNatureBonus : singleStatEditorSpecialDefense.natureBonus
            }
            if (isNeutralNature) {
                singleStatEditorAttack.natureBonus = SingleStatEditor.NatureBonus.NatureBonusDown
            }
            natureBonus = SingleStatEditor.NatureBonus.NatureBonusUp
            updateNature()
        }
    }

    Button {
        id: buttonNature

        x: 6
        y: singleStatEditorSpeed.y + singleStatEditorSpeed.height + 5
        width: parent.width - 2*x

        text: qsTr("Nature: ") + "<b>" + modelNatures.getNatureData(statsEditor.natureId, Backend.ModelNatures.NameRole) + "</b>"
        flat: true

        onClicked: {
            pageNatureChart.rowToHighlight = -1
            pageNatureChart.columnToHighlight = -1
            connectionNatureChart.enabled = true
            stackView.push(pageNatureChart)
        }
    }

    Label {
        id: labelNotes
        y: buttonNature.y + buttonNature.height + 5
        width: parent.width

        horizontalAlignment: Text.AlignHCenter
        text: (labelLevelIvsMsg.visible ? "" : (qsTr("All IVs are set to 31") + "\n"))
              + qsTr("Tap or hold") + " " + qsTr("on the stat's names to set nature")
        wrapMode: Text.Wrap
        textFormat: Text.PlainText
    }

    Item {
        id: itemLevelIvs
        y: labelNotes.y + labelNotes.height + 5
        width: parent.width
        height: statsEditor.simpleMode ? spinBoxLevel.height : sliderLevel.y + sliderLevel.height

        SpinBox {
            id: spinBoxLevel
            width: parent.width

            visible: statsEditor.simpleMode
            from: 10
            to: 100
            stepSize: 10
            value: sliderLevel.value
            textFromValue: function(value) {
                return qsTr("Level") + " " + value
            }

            onValueChanged: if (visible) sliderLevel.value = value
            onVisibleChanged: if (visible) sliderLevel.value = 50
        }

        Label {
            id: labelLevelIvsMsg
            y: 4
            width: parent.width

            visible: !spinBoxLevel.visible
            text: qsTr("Level and IVs")
            font.bold: true
            horizontalAlignment: Label.AlignHCenter
            textFormat: Text.PlainText
        }

        Item {
            id: itemLevelIvsSelector

            x: (parent.width - width)/2
            y: labelLevelIvsMsg.y + labelLevelIvsMsg.height + 4
            z: sliderLevel.z + 1
            implicitWidth: labelLevel.width * 7
            implicitHeight: buttonLevel.y + buttonLevel.height

            visible: labelLevelIvsMsg.visible
            enabled: visible

            MouseArea { // to avoid receiving mouse events from the sliders
                y: buttonLevel.y + buttonLevel.width/2
                width: parent.width
            }

            ButtonGroup {
                buttons: [buttonLevel, buttonIvHp, buttonIvAttack, buttonIvDefense, buttonIvSpecialAttack, buttonIvSpecialDefense, buttonIvSpeed]
            }

            // Level
            Label {
                id: labelLevel
                width: 40

                text: qsTr("Level")
                font.pointSize: Qt.application.font.pointSize * 0.8
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonLevel.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonLevel

                x: (labelLevel.width - width)/2
                y: labelLevel.height + 2
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                checked: true
                highlighted: checked
                flat: true
                text: statsEditor.level
            }

            // HP
            Label {
                id: labelIvHp
                x: labelLevel.x + labelLevel.width
                width: labelLevel.width

                text: qsTr("HP")
                font.pointSize: labelLevel.font.pointSize
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonIvHp.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonIvHp

                x: labelIvHp.x + (labelIvHp.width - width)/2
                y: buttonLevel.y
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                highlighted: checked
                flat: true
                text: statsEditor.statHpIvValue
            }

            // Attack
            Label {
                id: labelIvAttack
                x: labelIvHp.x + labelLevel.width
                width: labelLevel.width

                text: qsTr("Attack")
                font.pointSize: labelLevel.font.pointSize
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonIvAttack.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonIvAttack

                x: labelIvAttack.x + (labelIvAttack.width - width)/2
                y: buttonLevel.y
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                highlighted: checked
                flat: true
                text: statsEditor.statAttackIvValue
            }

            // Defense
            Label {
                id: labelIvDefense
                x: labelIvAttack.x + labelLevel.width
                width: labelLevel.width

                text: qsTr("Defense")
                font.pointSize: labelLevel.font.pointSize
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonIvDefense.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonIvDefense

                x: labelIvDefense.x + (labelIvDefense.width - width)/2
                y: buttonLevel.y
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                highlighted: checked
                flat: true
                text: statsEditor.statDefenseIvValue
            }

            // Special attack
            Label {
                id: labelIvSpecialAttack
                x: labelIvDefense.x + labelLevel.width
                width: labelLevel.width

                text: qsTr("Sp. Atk")
                font.pointSize: labelLevel.font.pointSize
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonIvSpecialAttack.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonIvSpecialAttack

                x: labelIvSpecialAttack.x + (labelIvSpecialAttack.width - width)/2
                y: buttonLevel.y
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                highlighted: checked
                flat: true
                text: statsEditor.statSpecialAttackIvValue
            }

            // Special defense
            Label {
                id: labelIvSpecialDefense
                x: labelIvSpecialAttack.x + labelLevel.width
                width: labelLevel.width

                text: qsTr("Sp. Def")
                font.pointSize: labelLevel.font.pointSize
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonIvSpecialDefense.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonIvSpecialDefense

                x: labelIvSpecialDefense.x +(labelIvSpecialDefense.width - width)/2
                y: buttonLevel.y
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                highlighted: checked
                flat: true
                text: statsEditor.statSpecialDefenseIvValue
            }

            // Speed
            Label {
                id: labelIvSpeed
                x: labelIvSpecialDefense.x + labelLevel.width
                width: labelLevel.width

                text: qsTr("Speed")
                font.pointSize: labelLevel.font.pointSize
                horizontalAlignment: Label.AlignHCenter
                Material.foreground: buttonIvSpeed.checked ? Material.accent : labelLevelIvsMsg.Material.foreground
            }

            Button {
                id: buttonIvSpeed

                x: labelIvSpeed.x + (labelIvSpeed.width - width)/2
                y: buttonLevel.y
                width: 30
                padding: 0
                topInset: 0
                bottomInset: 0
                leftInset: 0
                rightInset: 0

                checkable: true
                highlighted: checked
                flat: true
                text: statsEditor.statSpeedIvValue
            }
        } // Item (level and ivs selector)

        Slider {
            id: sliderLevel
            y: itemLevelIvsSelector.y + itemLevelIvsSelector.height - 8
            width: parent.width

            visible: labelLevelIvsMsg.visible && buttonLevel.checked
            enabled: visible
            from: 1
            to: 100
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: 50


            ToolTip {
                parent: sliderLevel.handle
                visible: sliderLevel.pressed
                text: sliderLevel.value
            }
        }

        Slider {
            id: sliderIvHp
            y: sliderLevel.y
            width: sliderLevel.width

            visible: labelLevelIvsMsg.visible && buttonIvHp.checked
            enabled: visible
            from: 0
            to: 31
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: statsEditor.statHpIvValue
            onValueChanged: statsEditor.statHpIvValue = value

            ToolTip {
                parent: sliderIvHp.handle
                visible: sliderIvHp.pressed
                text: sliderIvHp.value
            }
        }

        Slider {
            id: sliderIvAttack
            y: sliderLevel.y
            width: sliderLevel.width

            visible: labelLevelIvsMsg.visible && buttonIvAttack.checked
            enabled: visible
            from: 0
            to: 31
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: statsEditor.statAttackIvValue
            onValueChanged: statsEditor.statAttackIvValue = value

            ToolTip {
                parent: sliderIvAttack.handle
                visible: sliderIvAttack.pressed
                text: sliderIvAttack.value
            }
        }

        Slider {
            id: sliderIvDefense
            y: sliderLevel.y
            width: sliderLevel.width

            visible: labelLevelIvsMsg.visible && buttonIvDefense.checked
            enabled: visible
            from: 0
            to: 31
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: statsEditor.statDefenseIvValue
            onValueChanged: statsEditor.statDefenseIvValue = value

            ToolTip {
                parent: sliderIvDefense.handle
                visible: sliderIvDefense.pressed
                text: sliderIvDefense.value
            }
        }

        Slider {
            id: sliderIvSpecialAttack
            y: sliderLevel.y
            width: sliderLevel.width

            visible: labelLevelIvsMsg.visible && buttonIvSpecialAttack.checked
            enabled: visible
            from: 0
            to: 31
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: statsEditor.statSpecialAttackIvValue
            onValueChanged: statsEditor.statSpecialAttackIvValue = value

            ToolTip {
                parent: sliderIvSpecialAttack.handle
                visible: sliderIvSpecialAttack.pressed
                text: sliderIvSpecialAttack.value
            }
        }

        Slider {
            id: sliderIvSpecialDefense
            y: sliderLevel.y
            width: sliderLevel.width

            visible: labelLevelIvsMsg.visible && buttonIvSpecialDefense.checked
            enabled: visible
            from: 0
            to: 31
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: statsEditor.statSpecialDefenseIvValue
            onValueChanged: statsEditor.statSpecialDefenseIvValue = value

            ToolTip {
                parent: sliderIvSpecialDefense.handle
                visible: sliderIvSpecialDefense.pressed
                text: sliderIvSpecialDefense.value
            }
        }

        Slider {
            id: sliderIvSpeed
            y: sliderLevel.y
            width: sliderLevel.width

            visible: labelLevelIvsMsg.visible && buttonIvSpeed.checked
            enabled: visible
            from: 0
            to: 31
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: statsEditor.statSpeedIvValue
            onValueChanged: statsEditor.statSpeedIvValue = value

            ToolTip {
                parent: sliderIvSpeed.handle
                visible: sliderIvSpeed.pressed
                text: sliderIvSpeed.value
            }
        }
    } // Item (level and ivs)
}
