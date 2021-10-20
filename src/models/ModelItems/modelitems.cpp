#include "modelitems.h"
#include "../../database/items/db_items.h"

ModelItems::ModelItems(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelItems::roleNames() const
{
    return {
        { IdRole, "itemId" },
        { NameRole, "name" },
        { FlavorTextRole, "flavorText" },
        { DetailedEffectRole, "detailedEffect" },
        { FlingPowerRole, "flingPower" },
        { HasBigIconRole, "hasBigIcon" }
    };
}

int ModelItems::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredItems.contains(NoneItem) && !showItemNone ? filteredItems.size() - 1 : filteredItems.size();  // ignore the "none" item
}

QVariant ModelItems::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int itemId = filteredItems[index.row()];
    return getItemData(itemId, role);
}

QVariant ModelItems::getItemData(int itemId, int role) const
{
#ifndef LITE_VERSION
    int itemVectorIndex = itemId/200;
    if (itemId <= 0 || itemVectorIndex > 4 || (itemVectorIndex == 4 && itemId % 200 >= items5.count())) {
        return QVariant();
    }
    const Item item = (itemVectorIndex == 0 ? items1 : itemVectorIndex == 1 ? items2 : itemVectorIndex == 2 ? items3 : itemVectorIndex == 3 ? items4 : items5)[(itemId - 1) % 200];
#else
    int itemVectorIndex = itemId/500;
    if (itemId < 0 || (!showItemNone && itemId == 0) || itemVectorIndex > 1 || (itemVectorIndex == 1 && itemId % 500 >= items2.count())) {
        qDebug() << itemId << (itemId < 0) << (!showItemNone && itemId == 0) << (itemVectorIndex > 1) << (itemVectorIndex == 1 && itemId % 500 >= items2.count());
        return QVariant();
    }
    const Item item = (itemVectorIndex == 0 ? items1 : items2)[itemId % 500];
#endif

    // avoid some warnings
#ifndef LITE_VERSION
    auto flavorTextsByVersionGroup = item.getFlavorTextsByVersionGroup();
#endif

    switch (role) {
    case IdRole:
        return item.getId();
    case NameRole:
        return item.getNames().at(currentLanguage - 1).isEmpty() ? item.getNames().at(8) : item.getNames().at(currentLanguage - 1);
    case FlavorTextRole:
#ifndef LITE_VERSION
        for (auto flavorTextByVersionGroup : flavorTextsByVersionGroup) {
            if (flavorTextByVersionGroup.first == currentVersionGroup) {
                return flavorTextByVersionGroup.second.at(currentLanguage - 1).isEmpty() ? flavorTextByVersionGroup.second.at(8) : flavorTextByVersionGroup.second.at(currentLanguage - 1);
            }
        }
        return QString();
#else
        return item.getFlavorTexts().at(currentLanguage - 1).isEmpty() ? item.getFlavorTexts().at(8) : item.getFlavorTexts().at(currentLanguage - 1);
#endif
    case DetailedEffectRole:
        return strlen(item.getDetailedDescriptions().at(currentLanguage - 1)) == 0 ? item.getDetailedDescriptions().at(8) : item.getDetailedDescriptions().at(currentLanguage - 1);
    case FlingPowerRole:
        return item.getFlingPower();
    case HasBigIconRole:
        return QFile::exists(QStringLiteral(":/images/items/items-icons-big/") + QString::number(item.getId()) + ".png");
    default:
        return QVariant();
    }
}

void ModelItems::updateModelByFilter()
{
    beginResetModel();
    filteredItems.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &item : items1) {
            bool match = (item.getNames().at(currentLanguage - 1).isEmpty() ? item.getNames().at(8) : item.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredItems.append(item.getId());
            }
        }
        for (const auto &item : items2) {
            bool match = (item.getNames().at(currentLanguage - 1).isEmpty() ? item.getNames().at(8) : item.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredItems.append(item.getId());
            }
        }
#ifndef LITE_VERSION
        for (auto item : items3) {
            bool match = (item.getNames().at(currentLanguage - 1).isEmpty() ? item.getNames().at(8) : item.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredItems.append(item.getId());
            }
        }
        for (auto item : items4) {
            bool match = (item.getNames().at(currentLanguage - 1).isEmpty() ? item.getNames().at(8) : item.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredItems.append(item.getId());
            }
        }
        for (auto item : items5) {
            bool match = (item.getNames().at(currentLanguage - 1).isEmpty() ? item.getNames().at(8) : item.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredItems.append(item.getId());
            }
        }
#endif
        setFilterMatchs(filteredItems.count() > 0);
        if (filteredItems.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelItems::disableFiltering()
{
    filteredItems.clear();
    for (const auto &item : items1) {
        if (item.getId() == NoneItem && !showItemNone) {
            continue;
        }
        filteredItems.append(item.getId());
    }
    for (const auto &item : items2) {
        filteredItems.append(item.getId());
    }
#ifndef LITE_VERSION
    for (auto item : items3) {
        filteredItems.append(item.getId());
    }
    for (auto item : items4) {
        filteredItems.append(item.getId());
    }
    for (auto item : items5) {
        filteredItems.append(item.getId());
    }
#endif
}

int ModelItems::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelItems::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelItems::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelItems::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

bool ModelItems::getShowItemNone() const
{
    return showItemNone;
}

void ModelItems::setShowItemNone(bool value)
{
    if (showItemNone != value) {
        showItemNone = value;
        emit showItemNoneChanged(value);
    }
}

QString ModelItems::getFilter() const
{
    return filter;
}

void ModelItems::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelItems::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelItems::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}
