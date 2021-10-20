#ifndef DB_TYPES_H
#define DB_TYPES_H

#include <QVector>
#include <QString>
#include "../../global/type/type.h"

enum TypeEnum {
    NoneType,
    Normal,
    Fighting,
    Flying,
    Poison,
    Ground,
    Rock,
    Bug,
    Ghost,
    Steel,
    Fire,
    Water,
    Grass,
    Electric,
    Psychic,
    Ice,
    Dragon,
    Dark,
    Fairy
};

extern const QVector<Type> types;

#endif // DB_TYPES_H
