#include "modelmoves.h"
#include "../../database/moves/db_moves.h"

ModelMoves::ModelMoves(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelMoves::roleNames() const
{
    return {
        { IdRole, "moveId" },
        { NameRole, "name" },
        { FlavorTextRole, "flavorText" },
        { ShortEffectRole, "shortEffect" },
        { DetailedEffectRole, "detailedEffect" },
        { PowerRole, "power" },
        { PpRole, "pp" },
        { AccuracyRole, "accuracy" },
        { PriorityRole, "priority" },
        { EffectChanceRole, "effectChance" },
        { DamageClassRole, "damageClass" },
        { TargetRole, "target" },
        { TypeRole, "type" },
        { ContestTypeRole, "contestType" },
        { ContestEffectRole, "contestEffect" },
        { SuperContestEffectRole, "superContestEffect" },
        { GenerationRole, "generation" }
    };
}

int ModelMoves::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredMoves.contains(NoneMove) && !showMoveNone ? filteredMoves.size() - 1 : filteredMoves.size();  // ignore the "none" item;
}

QVariant ModelMoves::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int moveId = filteredMoves[index.row()];
    return getMoveData(moveId, role);
}

QVariant ModelMoves::getMoveData(int moveId, int role) const
{
#ifndef LITE_VERSION
    int moveVectorIndex = (moveId - 1)/150;
    const Move move = (moveVectorIndex == 0 ? moves1 : moveVectorIndex == 1 ? moves2 : moveVectorIndex == 2 ? moves3 : moveVectorIndex == 3 ? moves4 : moves5)[(moveId - 1) % 150];
#else
    int moveVectorIndex = moveId/400;
    const Move move = (moveVectorIndex == 0 ? moves1 : moves2)[moveId % 400];
#endif
    // avoid some warnings
#ifndef LITE_VERSION
    auto flavorTextsByVersionGroup = move.getFlavorTextsByVersionGroup();
#endif

    switch (role) {
    case IdRole:
        return move.getId();
    case NameRole:
        return move.getNames().at(currentLanguage - 1).isEmpty() ? move.getNames().at(8) : move.getNames().at(currentLanguage - 1);
    case FlavorTextRole:
#ifndef LITE_VERSION
        for (auto flavorTextByVersionGroup : flavorTextsByVersionGroup) {
            if (flavorTextByVersionGroup.first == currentVersionGroup) {
                return flavorTextByVersionGroup.second.at(currentLanguage - 1).isEmpty() ? flavorTextByVersionGroup.second.at(8) : flavorTextByVersionGroup.second.at(currentLanguage - 1);
            }
        }
        return QString();
#else
        return QString(move.getFlavorTexts().at(currentLanguage - 1).isEmpty() ? move.getFlavorTexts().at(8) : move.getFlavorTexts().at(currentLanguage - 1)).replace("$effect_chance%", QString::number(move.getEffectChance()) + '%');
#endif
    case DetailedEffectRole:
        return QString(strlen(move.getDetailedDescriptions().at(currentLanguage - 1)) == 0 ? move.getDetailedDescriptions().at(8) : move.getDetailedDescriptions().at(currentLanguage - 1)).replace("$effect_chance%", QString::number(move.getEffectChance()) + '%');
    case PowerRole:
        return move.getPower();
    case PpRole:
        return move.getPp();
    case AccuracyRole:
        return move.getAccuracy();
    case PriorityRole:
        return move.getPriority();
    case EffectChanceRole:
        return move.getEffectChance();
    case DamageClassRole:
        return move.getDamageClass();
    case TargetRole:
        return move.getTarget();
    case TypeRole:
        return move.getType();
    case ContestTypeRole:
        return move.getContestType();
    case ContestEffectRole:
        return move.getContestEffect();
    case SuperContestEffectRole:
        return move.getSuperContestEffect();
    case GenerationRole:
        return move.getGeneration();
    default:
        return QVariant();
    }
}

void ModelMoves::updateModelByFilter()
{
    beginResetModel();
    filteredMoves.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &move : moves1) {
            bool match = (move.getNames().at(currentLanguage - 1).isEmpty() ? move.getNames().at(8) : move.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == 0 || filterType == move.getType();
            if (match && matchType) {
                filteredMoves.append(move.getId());
            }
        }
        for (const auto &move : moves2) {
            bool match = (move.getNames().at(currentLanguage - 1).isEmpty() ? move.getNames().at(8) : move.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == 0 || filterType == move.getType();
            if (match && matchType) {
                filteredMoves.append(move.getId());
            }
        }
#ifndef LITE_VERSION
        for (const auto &move : moves3) {
            bool match = (move.getNames().at(currentLanguage - 1).isEmpty() ? move.getNames().at(8) : move.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == 0 || filterType == move.getType();
            if (match && matchType) {
                filteredMoves.append(move.getId());
            }
        }
        for (const auto &move : moves4) {
            bool match = (move.getNames().at(currentLanguage - 1).isEmpty() ? move.getNames().at(8) : move.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == 0 || filterType == move.getType();
            if (match && matchType) {
                filteredMoves.append(move.getId());
            }
        }
        for (const auto &move : moves5) {
            bool match = (move.getNames().at(currentLanguage - 1).isEmpty() ? move.getNames().at(8) : move.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == 0 || filterType == move.getType();
            if (match && matchType) {
                filteredMoves.append(move.getId());
            }
        }
#endif
        setFilterMatchs(filteredMoves.count() > 0);
        if (filteredMoves.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelMoves::disableFiltering()
{
    filteredMoves.clear();
    for (const auto &move : qAsConst(moves1)) {
        if (move.getId() == NoneMove && !showMoveNone) {
            continue;
        }
        bool matchType = filterType == 0 || filterType == move.getType();
        if (matchType) {
            filteredMoves.append(move.getId());
        }
    }
    for (const auto &move : qAsConst(moves2)) {
        bool matchType = filterType == 0 || filterType == move.getType();
        if (matchType) {
            filteredMoves.append(move.getId());
        }
    }
#ifndef LITE_VERSION
    for (const auto &move : qAsConst(moves3)) {
        bool matchType = filterType == 0 || filterType == move.getType();
        if (matchType) {
            filteredMoves.append(move.getId());
        }
    }
    for (const auto &move : qAsConst(moves4)) {
        bool matchType = filterType == 0 || filterType == move.getType();
        if (matchType) {
            filteredMoves.append(move.getId());
        }
    }
    for (const auto &move : qAsConst(moves5)) {
        bool matchType = filterType == 0 || filterType == move.getType();
        if (matchType) {
            filteredMoves.append(move.getId());
        }
    }
#endif
}

int ModelMoves::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelMoves::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

bool ModelMoves::getShowMoveNone() const
{
    return showMoveNone;
}

void ModelMoves::setShowMoveNone(bool value)
{
    if (showMoveNone != value) {
        showMoveNone = value;
        emit showMoveNoneChanged(value);
    }
}

int ModelMoves::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelMoves::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

QString ModelMoves::getFilter() const
{
    return filter;
}

void ModelMoves::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelMoves::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelMoves::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}

int ModelMoves::getFilterType() const
{
    return filterType;
}

void ModelMoves::setFilterType(int value)
{
    if (filterType != value) {
        filterType = value;
        emit filterTypeChanged(value);
        updateModelByFilter();
    }
}
