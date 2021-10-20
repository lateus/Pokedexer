#include "db_natures.h"
#include "../common/db_common.h"
#include "../berries/db_berries.h"

#include <QObject>

const QVector<Nature> natures = {
    { Hardy,   QObject::tr("Hardy"),    NoneStat,       NoneStat,       NoneFlavor, NoneFlavor, true },
    { Bold,    QObject::tr("Bold"),     Defense,        Attack,         Sour,       Spicy,      false },
    { Modest,  QObject::tr("Modest"),   SpecialAttack,  Attack,         Dry,        Spicy,      false },
    { Calm,    QObject::tr("Calm"),     SpecialDefense, Attack,         Bitter,     Spicy,      false },
    { Timid,   QObject::tr("Timid"),    Speed,          Attack,         Sweet,      Spicy,      false },
    { Lonely,  QObject::tr("Lonely"),   Attack,         Defense,        Spicy,      Sour,       false },
    { Docile,  QObject::tr("Docile"),   NoneStat,       NoneStat,       NoneFlavor, NoneFlavor, true },
    { Mild,    QObject::tr("Mild"),     SpecialAttack,  Defense,        Dry,        Sour,       false },
    { Gentle,  QObject::tr("Gentle"),   SpecialDefense, Defense,        Bitter,     Sour,       false },
    { Hasty,   QObject::tr("Hasty"),    Speed,          Defense,        Sweet,      Sour,       false },
    { Adamant, QObject::tr("Adamant"),  Attack,         SpecialAttack,  Spicy,      Dry,        false },
    { Impish,  QObject::tr("Impish"),   Defense,        SpecialAttack,  Sour,       Dry,        false },
    { Bashful, QObject::tr("Bashful"),  NoneStat,       NoneStat,       NoneFlavor, NoneFlavor, true },
    { Careful, QObject::tr("Careful"),  SpecialDefense, SpecialAttack,  Bitter,     Dry,        false },
    { Rash,    QObject::tr("Rash"),     SpecialAttack,  SpecialDefense, Dry,        Bitter,     false },
    { Jolly,   QObject::tr("Jolly"),    Speed,          SpecialAttack,  Sweet,      Dry,        false },
    { Naughty, QObject::tr("Naughty"),  Attack,         SpecialDefense, Spicy,      Bitter,     false },
    { Lax,     QObject::tr("Lax"),      Defense,        SpecialDefense, Sour,       Bitter,     false },
    { Quirky,  QObject::tr("Quirky"),   NoneStat,       NoneStat,       NoneFlavor, NoneFlavor, true },
    { Naive,   QObject::tr("Naive"),    Speed,          SpecialDefense, Sweet,      Bitter,     false },
    { Brave,   QObject::tr("Brave"),    Attack,         Speed,          Spicy,      Sweet,      false },
    { Relaxed, QObject::tr("Relaxed"),  Defense,        Speed,          Sour,       Sweet,      false },
    { Quiet,   QObject::tr("Quiet"),    SpecialAttack,  Speed,          Dry,        Sweet,      false },
    { Sassy,   QObject::tr("Sassy"),    SpecialDefense, Speed,          Bitter,     Sweet,      false },
    { Serious, QObject::tr("Serious"),  NoneStat,       NoneStat,       NoneFlavor, NoneFlavor, true }
};
