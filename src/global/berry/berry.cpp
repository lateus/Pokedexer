#include "berry.h"

#ifndef LITE_VERSION
Berry::Berry(int berryId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString> > > &localizedFlavorTextsByVersionGroup, const QVector<QString> &localizedDetailedDescriptions, int berryNaturalGiftPower, int berryNaturalGiftType, int berrySize, int berryMaximumHarvest, int berryGrowthTime, int berrySoilDryness, int berrySmoothness, int berryFirmnessId, int berryItemId, const QVector<int> &berryPotencyByFlavor)
    : id(berryId), names(localizedNames), flavorTextsByVersionGroup(localizedFlavorTextsByVersionGroup), detailedDescriptions(localizedDetailedDescriptions), naturalGiftPower(berryNaturalGiftPower), naturalGiftType(berryNaturalGiftType), size(berrySize), maxHarvest(berryMaximumHarvest), growthTime(berryGrowthTime), soilDryness(berrySoilDryness), smoothness(berrySmoothness), firmnessId(berryFirmnessId), itemId(berryItemId), potencyByFlavor(berryPotencyByFlavor)
{

}
#else
Berry::Berry(int berryId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char *> &localizedDetailedDescriptions, int berryNaturalGiftPower, int berryNaturalGiftType, int berrySize, int berryMaximumHarvest, int berryGrowthTime, int berrySoilDryness, int berrySmoothness, int berryFirmnessId, int berryItemId, const QVector<int> &berryPotencyByFlavor)
    : id(berryId), names(localizedNames), flavorTexts(localizedFlavorTexts), detailedDescriptions(localizedDetailedDescriptions), naturalGiftPower(berryNaturalGiftPower), naturalGiftType(berryNaturalGiftType), size(berrySize), maxHarvest(berryMaximumHarvest), growthTime(berryGrowthTime), soilDryness(berrySoilDryness), smoothness(berrySmoothness), firmnessId(berryFirmnessId), itemId(berryItemId), potencyByFlavor(berryPotencyByFlavor)
{

}
#endif

int Berry::getId() const
{
    return id;
}

QVector<int> Berry::getPotencyByFlavor() const
{
    return potencyByFlavor;
}

QVector<QString> Berry::getNames() const
{
    return names;
}

#ifndef LITE_VERSION
QVector<QPair<int, QVector<QString> > > Berry::getFlavorTextsByVersionGroup() const
{
    return flavorTextsByVersionGroup;
}
#else
QVector<QString> Berry::getFlavorTexts() const
{
    return flavorTexts;
}
#endif

QVector<const char*> Berry::getDetailedDescriptions() const
{
    return detailedDescriptions;
}

int Berry::getNaturalGiftPower() const
{
    return naturalGiftPower;
}

int Berry::getNaturalGiftType() const
{
    return naturalGiftType;
}

int Berry::getSize() const
{
    return size;
}

int Berry::getMaxHarvest() const
{
    return maxHarvest;
}

int Berry::getGrowthTime() const
{
    return growthTime;
}

int Berry::getSoilDryness() const
{
    return soilDryness;
}

int Berry::getSmoothness() const
{
    return smoothness;
}

int Berry::getFirmnessId() const
{
    return firmnessId;
}

int Berry::getItemId() const
{
    return itemId;
}
