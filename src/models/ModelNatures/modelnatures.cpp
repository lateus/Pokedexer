#include "modelnatures.h"
#include "../../database/natures/db_natures.h"
#include "../../database/common/db_common.h"

ModelNatures::ModelNatures(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelNatures::roleNames() const
{
    return {
        { IdRole, "natureId" },
        { NameRole, "name" },
        { StatUpRole, "statUp" },
        { StatDownRole, "statDown" },
        { FlavorUpRole, "flavorUp" },
        { FlavorDownRole, "flavorDown" },
        { IsNeutralRole, "isNeutral" }
    };
}

int ModelNatures::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredNatures.size();
}

QVariant ModelNatures::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int natureId = filteredNatures[index.row()];

    return getNatureData(natureId, role);
}

QVariant ModelNatures::getNatureData(int natureId, int role) const
{
    const Nature nature = natures[natureId - 1];

    switch (role) {
    case IdRole:
        return nature.getId();
    case NameRole:
        return nature.getName();
    case StatUpRole:
        return statNames[nature.getStatUp()];
    case StatDownRole:
        return statNames[nature.getStatDown()];
    case FlavorUpRole:
        return flavorNames[nature.getFlavorUp()];
    case FlavorDownRole:
        return flavorNames[nature.getFlavorDown()];
    case IsNeutralRole:
        return nature.getIsNeutral();
    default:
        return QVariant();
    }
}

void ModelNatures::updateModelByFilter()
{
    beginResetModel();
    filteredNatures.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &nature : natures) {
            bool match = nature.getName().toLower().contains(filter.toLower());
            if (match) {
                filteredNatures.append(nature.getId());
            }
        }
        setFilterMatchs(filteredNatures.count() > 0);
        if (filteredNatures.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelNatures::disableFiltering()
{
    filteredNatures.clear();
    for (const auto &nature : natures) {
        filteredNatures.append(nature.getId());
    }
}

int ModelNatures::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelNatures::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelNatures::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelNatures::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

QString ModelNatures::getFilter() const
{
    return filter;
}

void ModelNatures::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelNatures::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelNatures::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}
