#ifndef MOVE_H
#define MOVE_H

#include <QString>
#include <QVector>
#include <QPair>

class Move
{
public:
#ifndef LITE_VERSION
    Move(int moveId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString>>> &localizedFlavorTextByVersionGroup, const QVector<QString> &localizedDetailedDescriptions, int movePower, int movePP, int moveAccuracy, int movePriority, int moveEffectChance, int moveDamageClass, int moveTarget, int moveType, int moveContestType, int moveContestEffect, int moveSuperContestEffect, int moveGeneration);
#else
    Move(int moveId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char*> &localizedDetailedDescriptions, int movePower, int movePP, int moveAccuracy, int movePriority, int moveEffectChance, int moveDamageClass, int moveTarget, int moveType, int moveContestType, int moveContestEffect, int moveSuperContestEffect, int moveGeneration);
#endif

    int getId() const;
    QVector<QString> getNames() const;
#ifndef LITE_VERSION
    QVector<QPair<int, QVector<QString> > > getFlavorTextsByVersionGroup() const;
#else
    QVector<QString> getFlavorTexts() const;
#endif
    QVector<const char *> getDetailedDescriptions() const;
    int getPower() const;
    int getPp() const;
    int getAccuracy() const;
    int getPriority() const;
    int getEffectChance() const;
    int getDamageClass() const;
    int getTarget() const;
    int getType() const;
    int getContestType() const;
    int getContestEffect() const;
    int getSuperContestEffect() const;
    int getGeneration() const;

private:
    const int id;
    const QVector<QString> names;
#ifndef LITE_VERSION
    const QVector<QPair<int, QVector<QString>>> flavorTextsByVersionGroup;
#else
    const QVector<QString> flavorTexts;
#endif
    const QVector<const char*> detailedDescriptions;
    const int power;
    const int pp;
    const int accuracy;
    const int priority;
    const int effectChance;
    const int damageClass;
    const int target;
    const int type;
    const int contestType;
    const int contestEffect;
    const int superContestEffect;
    const int generation;
};

#endif // MOVE_H
