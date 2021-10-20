#ifndef BERRY_H
#define BERRY_H

#include <QString>
#include <QVector>
#include <QPair>

class Berry
{
public:
#ifndef LITE_VERSION
    Berry(int berryId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString>>> &localizedFlavorTextsByVersionGroup, const QVector<QString> &localizedDetailedDescriptions, int berryNaturalGiftPower, int berryNaturalGiftType, int berrySize, int berryMaximumHarvest, int berryGrowthTime, int berrySoilDryness, int berrySmoothness, int berryFirmnessId, int berryItemId, const QVector<int> &berryPotencyByFlavor);
#else
    Berry(int berryId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char*> &localizedDetailedDescriptions, int berryNaturalGiftPower, int berryNaturalGiftType, int berrySize, int berryMaximumHarvest, int berryGrowthTime, int berrySoilDryness, int berrySmoothness, int berryFirmnessId, int berryItemId, const QVector<int> &berryPotencyByFlavor);
#endif

    int getId() const;    
    QVector<QString> getNames() const;
#ifndef LITE_VERSION
    QVector<QPair<int, QVector<QString> > > getFlavorTextsByVersionGroup() const;
#else
    QVector<QString> getFlavorTexts() const;
#endif
    QVector<const char *> getDetailedDescriptions() const;
    int getNaturalGiftPower() const;
    int getNaturalGiftType() const;
    int getSize() const;
    int getMaxHarvest() const;
    int getGrowthTime() const;
    int getSoilDryness() const;
    int getSmoothness() const;
    int getFirmnessId() const;
    int getItemId() const;
    QVector<int> getPotencyByFlavor() const;

private:
    const int id;
    const QVector<QString> names;
#ifndef LITE_VERSION
    const QVector<QPair<int, QVector<QString>>> flavorTextsByVersionGroup;
#else
    const QVector<QString> flavorTexts;
#endif
    const QVector<const char*> detailedDescriptions;
    const int naturalGiftPower;
    const int naturalGiftType;
    const int size;
    const int maxHarvest;
    const int growthTime;
    const int soilDryness;
    const int smoothness;
    const int firmnessId;
    const int itemId;
    const QVector<int> potencyByFlavor;
};

#endif // BERRY_H
