#ifndef ABILITY_H
#define ABILITY_H

#include <QString>
#include <QVector>
#include <QPair>

class Ability
{
public:
#ifndef LITE_VERSION
    Ability(int abilityId, int generationId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString>>> &localizedFlavorTextByVersionGroup, const QVector<QString> &localizedDetailedDescriptions);
#else
    Ability(int abilityId, int generationId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char*> &localizedDetailedDescriptions);
#endif
    int getId() const;
    int getGeneration() const;
    QVector<QString> getNames() const;
#ifndef LITE_VERSION
    QVector<QPair<int, QVector<QString> > > getFlavorTextsByVersionGroup() const;
#else
    QVector<QString> getFlavorTexts() const;
#endif
    QVector<const char *> getDetailedDescriptions() const;

private:
    const int id;
    const int generation;
    const QVector<QString> names;
#ifndef LITE_VERSION
    const QVector<QPair<int, QVector<QString>>> flavorTextsByVersionGroup;
#else
    const QVector<QString> flavorTexts;
#endif
    const QVector<const char*> detailedDescriptions;
};

#endif // ABILITY_H
