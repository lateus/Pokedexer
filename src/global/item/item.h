#ifndef ITEM_H
#define ITEM_H

#include <QString>
#include <QVector>
#include <QPair>

class Item
{
public:
#ifndef LITE_VERSION
    Item(int itemId, const QVector<QString> &localizedNames, const QVector<QPair<int, QVector<QString>>> &localizedFlavorTextByVersionGroup, const QVector<QString> &localizedDetailedDescriptions, int flingMovePower);
#else
    Item(int itemId, const QVector<QString> &localizedNames, const QVector<QString> &localizedFlavorTexts, const QVector<const char*> &localizedDetailedDescriptions, int flingMovePower);
#endif
    int getId() const;
    QVector<QString> getNames() const;
#ifndef LITE_VERSION
    QVector<QPair<int, QVector<QString> > > getFlavorTextsByVersionGroup() const;
#else
    QVector<QString> getFlavorTexts() const;
#endif
    QVector<const char *> getDetailedDescriptions() const;
    int getFlingPower() const;

private:
    const int id;
    const QVector<QString> names;
#ifndef LITE_VERSION
    const QVector<QPair<int, QVector<QString>>> flavorTextsByVersionGroup;
#else
    const QVector<QString> flavorTexts;
#endif
    const QVector<const char*> detailedDescriptions;
    const int flingPower;
};

#endif // ITEM_H
