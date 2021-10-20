#include "item.h"

#ifndef LITE_VERSION
Item::Item(int itemId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString> > > &localizedFlavorTextByVersionGroup, const QVector<QString> &localizedDetailedDescriptions, int flingMovePower)
    : id(itemId), names(localizedNames), flavorTextsByVersionGroup(localizedFlavorTextByVersionGroup), detailedDescriptions(localizedDetailedDescriptions), flingPower(flingMovePower)
{

}
#else
Item::Item(int itemId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char *> &localizedDetailedDescriptions, int flingMovePower)
    : id(itemId), names(localizedNames), flavorTexts(localizedFlavorTexts), detailedDescriptions(localizedDetailedDescriptions), flingPower(flingMovePower)
{

}
#endif

int Item::getId() const
{
    return id;
}

QVector<QString> Item::getNames() const
{
    return names;
}

#ifndef LITE_VERSION
QVector<QPair<int, QVector<QString> > > Item::getFlavorTextsByVersionGroup() const
{
    return flavorTextsByVersionGroup;
}
#else
QVector<QString> Item::getFlavorTexts() const
{
    return flavorTexts;
}
#endif

QVector<const char*> Item::getDetailedDescriptions() const
{
    return detailedDescriptions;
}

int Item::getFlingPower() const
{
    return flingPower;
}
