#include "move.h"

#ifndef LITE_VERSION
Move::Move(int moveId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString> > > &localizedFlavorTextByVersionGroup, const QVector<QString> &localizedDetailedDescriptions, int movePower, int movePP, int moveAccuracy, int movePriority, int moveEffectChance, int moveDamageClass, int moveTarget, int moveType, int moveContestType, int moveContestEffect, int moveSuperContestEffect, int moveGeneration)
    : id(moveId), names(localizedNames), flavorTextsByVersionGroup(localizedFlavorTextByVersionGroup), detailedDescriptions(localizedDetailedDescriptions), power(movePower), pp(movePP), accuracy(moveAccuracy), priority(movePriority), effectChance(moveEffectChance), damageClass(moveDamageClass), target(moveTarget), type(moveType), contestType(moveContestType), contestEffect(moveContestEffect), superContestEffect(moveSuperContestEffect), generation(moveGeneration)
{

}
#else
Move::Move(int moveId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char *> &localizedDetailedDescriptions, int movePower, int movePP, int moveAccuracy, int movePriority, int moveEffectChance, int moveDamageClass, int moveTarget, int moveType, int moveContestType, int moveContestEffect, int moveSuperContestEffect, int moveGeneration)
    : id(moveId), names(localizedNames), flavorTexts(localizedFlavorTexts), detailedDescriptions(localizedDetailedDescriptions), power(movePower), pp(movePP), accuracy(moveAccuracy), priority(movePriority), effectChance(moveEffectChance), damageClass(moveDamageClass), target(moveTarget), type(moveType), contestType(moveContestType), contestEffect(moveContestEffect), superContestEffect(moveSuperContestEffect), generation(moveGeneration)
{

}
#endif


int Move::getId() const
{
    return id;
}

QVector<QString> Move::getNames() const
{
    return names;
}

#ifndef LITE_VERSION
QVector<QPair<int, QVector<QString> > > Move::getFlavorTextsByVersionGroup() const
{
    return flavorTextsByVersionGroup;
}
#else
QVector<QString> Move::getFlavorTexts() const
{
    return flavorTexts;
}
#endif

QVector<const char*> Move::getDetailedDescriptions() const
{
    return detailedDescriptions;
}

int Move::getPower() const
{
    return power;
}

int Move::getPp() const
{
    return pp;
}

int Move::getAccuracy() const
{
    return accuracy;
}

int Move::getPriority() const
{
    return priority;
}

int Move::getEffectChance() const
{
    return effectChance;
}

int Move::getDamageClass() const
{
    return damageClass;
}

int Move::getTarget() const
{
    return target;
}

int Move::getType() const
{
    return type;
}

int Move::getContestType() const
{
    return contestType;
}

int Move::getContestEffect() const
{
    return contestEffect;
}

int Move::getSuperContestEffect() const
{
    return superContestEffect;
}

int Move::getGeneration() const
{
    return generation;
}
