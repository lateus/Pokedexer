#include "ability.h"

#ifndef LITE_VERSION
Ability::Ability(int abilityId, int generationId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString> > > &localizedFlavorTextByVersionGroup, const QVector<QString> &localizedDetailedDescriptions)
    : id(abilityId), generation(generationId), names(localizedNames), flavorTextsByVersionGroup(localizedFlavorTextByVersionGroup), detailedDescriptions(localizedDetailedDescriptions)
{

}
#else
Ability::Ability(int abilityId, int generationId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char *> &localizedDetailedDescriptions)
    : id(abilityId), generation(generationId), names(localizedNames), flavorTexts(localizedFlavorTexts), detailedDescriptions(localizedDetailedDescriptions)
{

}
#endif

int Ability::getId() const
{
    return id;
}

int Ability::getGeneration() const
{
    return generation;
}

QVector<QString> Ability::getNames() const
{
    return names;
}

#ifndef LITE_VERSION
QVector<QPair<int, QVector<QString> > > Ability::getFlavorTextsByVersionGroup() const
{
    return flavorTextsByVersionGroup;
}
#else
QVector<QString> Ability::getFlavorTexts() const
{
    return flavorTexts;
}
#endif

QVector<const char*> Ability::getDetailedDescriptions() const
{
    return detailedDescriptions;
}
