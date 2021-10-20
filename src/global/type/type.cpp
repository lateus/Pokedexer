#include "type.h"

Type::Type(int typeId, int generationId, const QVector<int> &superEffectiveToList, const QVector<int> &notVeryEffectiveToList, const QVector<int> &nullToList, const QVector<int> &superEffectiveFromList, const QVector<int> &notVeryEffectiveFromList, const QVector<int> &nullFromList)
    : id(typeId), generation(generationId), superEffectiveTo(superEffectiveToList), notVeryEffectiveTo(notVeryEffectiveToList), nullTo(nullToList), superEffectiveFrom(superEffectiveFromList), notVeryEffectiveFrom(notVeryEffectiveFromList), nullFrom(nullFromList)
{

}

int Type::getId() const
{
    return id;
}

int Type::getGeneration() const
{
    return generation;
}

QVector<int> Type::getSuperEffectiveTo() const
{
    return superEffectiveTo;
}

QVector<int> Type::getNotVeryEffectiveTo() const
{
    return notVeryEffectiveTo;
}

QVector<int> Type::getNullTo() const
{
    return nullTo;
}

QVector<int> Type::getSuperEffectiveFrom() const
{
    return superEffectiveFrom;
}

QVector<int> Type::getNotVeryEffectiveFrom() const
{
    return notVeryEffectiveFrom;
}

QVector<int> Type::getNullFrom() const
{
    return nullFrom;
}
