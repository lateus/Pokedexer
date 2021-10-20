#include "modelberries.h"
#include "../../database/berries/db_berries.h"
#include "../../database/common/db_common.h"

#include <QTextDocument>
#include <QTextCursor>
#include <QTextTable>

ModelBerries::ModelBerries(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelBerries::roleNames() const
{
    return {
        { IdRole, "berryId" },
        { NameRole, "name" },
        { FlavorTextRole, "flavorText" },
        { DetailedEffectRole, "detailedEffect" },
        { NaturalGiftPowerRole, "naturalGiftPower" },
        { NaturalGiftTypeRole, "naturalGiftType" },
        { SizeRole, "size" },
        { MaxHarvestRole, "maxHarvest" },
        { GrowthTimeRole, "growthTime" },
        { SoilDrynessRole, "soilDryness" },
        { SmoothnessRole, "smoothness" },
        { FirmnessRole, "firmness" },
        { ItemIdRole, "itemId" },
        { PotencyByFlavorRole, "potencyByFlavor" }
    };
}

int ModelBerries::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredBerries.size();
}

QVariant ModelBerries::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int berryId = filteredBerries[index.row()];
    const Berry berry = berries[berryId - 1];

    // avoid some warnings
    QStringList potencyByFlavor;
#ifndef LITE_VERSION
    auto flavorTextsByVersionGroup = berry.getFlavorTextsByVersionGroup();
#endif

    switch (role) {
    case IdRole:
        return berry.getId();
    case NameRole:
        return berry.getNames().at(currentLanguage - 1).isEmpty() ? berry.getNames().at(8) : berry.getNames().at(currentLanguage - 1);
    case FlavorTextRole:
#ifndef LITE_VERSION
        for (auto flavorTextByVersionGroup : flavorTextsByVersionGroup) {
            if (flavorTextByVersionGroup.first == currentVersionGroup) {
                return flavorTextByVersionGroup.second.at(currentLanguage - 1).isEmpty() ? flavorTextByVersionGroup.second.at(8) : flavorTextByVersionGroup.second.at(currentLanguage - 1);
            }
        }
        return QVariant();
#else
        return berry.getFlavorTexts().at(currentLanguage - 1).isEmpty() ? berry.getFlavorTexts().at(8) : berry.getFlavorTexts().at(currentLanguage - 1);
#endif
    case DetailedEffectRole:
        return strlen(berry.getDetailedDescriptions().at(currentLanguage - 1)) == 0 ? berry.getDetailedDescriptions().at(8) : berry.getDetailedDescriptions().at(currentLanguage - 1);
    case NaturalGiftPowerRole:
        return berry.getNaturalGiftPower();
    case NaturalGiftTypeRole:
        return berry.getNaturalGiftType();
    case SizeRole:
        return berry.getSize();
    case MaxHarvestRole:
        return berry.getMaxHarvest();
    case GrowthTimeRole:
        return berry.getGrowthTime();
    case SoilDrynessRole:
        return berry.getSoilDryness();
    case SmoothnessRole:
        return berry.getSmoothness();
    case FirmnessRole:
        return berry.getFirmnessId() < 0 ? tr("Unknown") : firmnessNames.at(berry.getFirmnessId()).at(currentLanguage - 1).isEmpty() ? firmnessNames.at(berry.getFirmnessId()).at(8) : firmnessNames.at(berry.getFirmnessId()).at(currentLanguage - 1);
    case ItemIdRole:
        return berry.getItemId();
    case PotencyByFlavorRole:
        for (int potency : berry.getPotencyByFlavor()) {
            potencyByFlavor << QString::number(potency);
        }
        return potencyByFlavor;
    default:
        return QVariant();
    }
}

void ModelBerries::updateModelByFilter()
{
    beginResetModel();
    filteredBerries.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &berry : berries) {
            bool match = (berry.getNames().at(currentLanguage - 1).isEmpty() ? berry.getNames().at(8) : berry.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredBerries.append(berry.getId());
            }
        }
        setFilterMatchs(filteredBerries.count() > 0);
        if (filteredBerries.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelBerries::disableFiltering()
{
    filteredBerries.clear();
    for (const auto &berry : berries) {
        filteredBerries.append(berry.getId());
    }
}

int ModelBerries::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelBerries::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        currentVersionGroupChanged(value);
    }
}

int ModelBerries::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelBerries::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

QString ModelBerries::getFilter() const
{
    return filter;
}

void ModelBerries::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelBerries::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelBerries::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}

QStringList ModelBerries::getFlavorNames() const
{
    return flavorNames;
}
