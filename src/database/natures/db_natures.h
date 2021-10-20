#ifndef DB_NATURES_H
#define DB_NATURES_H

#include <QVector>
#include <QString>
#include "../../global/nature/nature.h"

enum NatureEnum {
    NoneNature,
    Hardy,
    Bold,
    Modest,
    Calm,
    Timid,
    Lonely,
    Docile,
    Mild,
    Gentle,
    Hasty,
    Adamant,
    Impish,
    Bashful,
    Careful,
    Rash,
    Jolly,
    Naughty,
    Lax,
    Quirky,
    Naive,
    Brave,
    Relaxed,
    Quiet,
    Sassy,
    Serious
};

extern const QVector<Nature> natures;

#endif // DB_TYPES_H
