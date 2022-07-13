#ifndef DB_NATURES_H
#define DB_NATURES_H

#include <QVector>
#include <QString>
#include "../../global/nature/nature.h"

enum NatureEnum {
    NoneNature,
    Hardy,
    Lonely,
    Adamant,
    Naughty,
    Brave,
    Bold,
    Docile,
    Impish,
    Lax,
    Relaxed,
    Modest,
    Mild,
    Bashful,
    Rash,
    Quiet,
    Calm,
    Gentle,
    Careful,
    Quirky,
    Sassy,
    Timid,
    Hasty,
    Jolly,
    Naive,
    Serious
};

extern const QVector<Nature> natures;

#endif // DB_TYPES_H
