#include "modelabilities.h"
#include "../../database/abilities/db_abilities.h"

ModelAbilities::ModelAbilities(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelAbilities::roleNames() const
{
    return {
        { IdRole, "abilityId" },
        { NameRole, "name" },
        { GenerationRole, "generation" },
        { FlavorTextRole, "flavorText" },
        { DetailedEffectRole, "detailedEffect" }
    };
}

int ModelAbilities::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredAbilities.contains(NoneAbility) && !showAbilityNone ? filteredAbilities.size() - 1 : filteredAbilities.size(); // ignore the "none" ability
}

QVariant ModelAbilities::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int abilityId = filteredAbilities[index.row()];

    return getAbilityData(abilityId, role);
}

QVariant ModelAbilities::getAbilityData(int abilityId, int role) const
{
    const Ability ability = abilities[abilityId];
    // avoid some warnings
#ifndef LITE_VERSION
    auto flavorTextsByVersionGroup = ability.getFlavorTextsByVersionGroup();
#endif

    switch (role) {
    case IdRole:
        return ability.getId();
    case GenerationRole:
        return ability.getGeneration();
    case NameRole:
        return ability.getNames().at(currentLanguage - 1).isEmpty() ? ability.getNames().at(8) : ability.getNames().at(currentLanguage - 1);
    case FlavorTextRole:
#ifndef LITE_VERSION
        for (auto flavorTextByVersionGroup : flavorTextsByVersionGroup) {
            if (flavorTextByVersionGroup.first == currentVersionGroup) {
                return flavorTextByVersionGroup.second.at(currentLanguage - 1).isEmpty() ? flavorTextByVersionGroup.second.at(8) : flavorTextByVersionGroup.second.at(currentLanguage - 1);
            }
        }
        return QString();
#else
        return ability.getFlavorTexts().at(currentLanguage - 1).isEmpty() ? ability.getFlavorTexts().at(8) : ability.getFlavorTexts().at(currentLanguage - 1);
#endif
    case DetailedEffectRole:
        return strlen(ability.getDetailedDescriptions().at(currentLanguage - 1)) == 0 ? ability.getDetailedDescriptions().at(8) : ability.getDetailedDescriptions().at(currentLanguage - 1);
    default:
        return QVariant();
    }
}

void ModelAbilities::updateModelByFilter()
{
    beginResetModel();
    filteredAbilities.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &ability : abilities) {
            bool match = (ability.getNames().at(currentLanguage - 1).isEmpty() ? ability.getNames().at(8) : ability.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredAbilities.append(ability.getId());
            }
        }
        setFilterMatchs(filteredAbilities.count() > 0);
        if (filteredAbilities.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelAbilities::disableFiltering()
{
    filteredAbilities.clear();
    for (const auto &ability : abilities) {
        if (ability.getId() == NoneAbility && !showAbilityNone) {
            continue;
        }
        filteredAbilities.append(ability.getId());
    }
}

bool ModelAbilities::getShowAbilityNone() const
{
    return showAbilityNone;
}

void ModelAbilities::setShowAbilityNone(bool value)
{
    if (showAbilityNone != value) {
        showAbilityNone = value;
        emit showAbilityNoneChanged(value);
        updateModelByFilter();
    }
}

int ModelAbilities::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelAbilities::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelAbilities::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelAbilities::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

QString ModelAbilities::getFilter() const
{
    return filter;
}

void ModelAbilities::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelAbilities::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelAbilities::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}
