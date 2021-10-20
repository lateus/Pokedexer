#include "modeltypes.h"
#include "../../database/types/db_types.h"

ModelTypes::ModelTypes(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelTypes::roleNames() const
{
    return {
        { IdRole, "typeId" },
        { NameRole, "name" },
        { GenerationRole, "generation" },
        { SuperEffectiveToRole, "superEffectiveTo" },
        { NotVeryEffectiveToRole, "notVeryEffectiveTo" },
        { NullToRole, "nullTo" },
        { SuperEffectiveFromRole, "superEffectiveFrom" },
        { NotVeryEffectiveFromRole, "notVeryEffectiveFrom" },
        { NullFromRole, "nullFrom" },
        { AdditionalInfoRole, "additionalInfo" }
    };
}

int ModelTypes::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredTypes.contains(NoneType) && !showTypeNone ? filteredTypes.size() - 1 : filteredTypes.size(); // ignore the "none" type
}

QVariant ModelTypes::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int typeId = filteredTypes[index.row()];
    const Type type = types[typeId];

    // avoid some warnings
    QStringList temp;

    switch (role) {
    case IdRole:
        return type.getId();
    case GenerationRole:
        return type.getGeneration();
    case NameRole:
        return typeNames[typeId];
    case SuperEffectiveToRole:
        for (auto n : type.getSuperEffectiveTo()) {
            temp.append(QString::number(n));
        }
        return temp;
    case NotVeryEffectiveToRole:
        for (auto n : type.getNotVeryEffectiveTo()) {
            temp.append(QString::number(n));
        }
        return temp;
    case NullToRole:
        for (auto n : type.getNullTo()) {
            temp.append(QString::number(n));
        }
        return temp;
    case SuperEffectiveFromRole:
        for (auto n : type.getSuperEffectiveFrom()) {
            temp.append(QString::number(n));
        }
        return temp;
    case NotVeryEffectiveFromRole:
        for (auto n : type.getNotVeryEffectiveFrom()) {
            temp.append(QString::number(n));
        }
        return temp;
    case NullFromRole:
        for (auto n : type.getNullFrom()) {
            temp.append(QString::number(n));
        }
        return temp;
    case AdditionalInfoRole:
        return additionalInfo[type.getId()];
    default:
        return QVariant();
    }
}

void ModelTypes::updateModelByFilter()
{
    beginResetModel();
    filteredTypes.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &type : types) {
            if (type.getId() == NoneType && !showTypeNone) {
                continue;
            }
            bool match = (typeNames[type.getId()].toLower().contains(filter.toLower()));
            if (match) {
                filteredTypes.append(type.getId());
            }
        }
        setFilterMatchs(filteredTypes.count() > 0);
        if (filteredTypes.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelTypes::disableFiltering()
{
    filteredTypes.clear();
    for (const auto &type : types) {
        if (type.getId() == NoneType && !showTypeNone) {
            continue;
        }
        filteredTypes.append(type.getId());
    }
}

QStringList ModelTypes::getWeakness_x4(int type1, int type2)
{
    if (type1 == NoneType || type2 == NoneType || type1 < 0 || type1 >= types.count() || type2 < 0 || type2 >= types.count()) {
        return {};
    } else if (type1 == type2) {
        type2 = NoneType;
    }

    QStringList typesWeak_x4;
    for (int i = Normal; i <= Fairy; ++i) {
        double type1DamageMultiplier = typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type1 - 1]];
        double type2DamageMultiplier = type2 == NoneType ? 1.0 : typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type2 - 1]];
        if (type1DamageMultiplier * type2DamageMultiplier == 4.0) {
            typesWeak_x4.append(QString::number(i));
        }
    }

    return typesWeak_x4;
}

QStringList ModelTypes::getResistence_x4(int type1, int type2)
{
    if (type1 == NoneType || type2 == NoneType || type1 < 0 || type1 >= types.count() || type2 < 0 || type2 >= types.count()) {
        return {};
    } else if (type1 == type2) {
        type2 = NoneType;
    }

    QStringList typesRes_x4;
    for (int i = Normal; i <= Fairy; ++i) {
        double type1DamageMultiplier = typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type1 - 1]];
        double type2DamageMultiplier = type2 == NoneType ? 1.0 : typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type2 - 1]];
        if (type1DamageMultiplier * type2DamageMultiplier == 0.25) {
            typesRes_x4.append(QString::number(i));
        }
    }

    return typesRes_x4;
}

QStringList ModelTypes::getWeakness_x2(int type1, int type2)
{
    if (type1 == NoneType || type1 < 0 || type1 >= types.count() || type2 < 0 || type2 >= types.count()) {
        return {};
    } else if (type1 == type2) {
        type2 = NoneType;
    }

    QStringList typesWeak_x2;
    for (int i = Normal; i <= Fairy; ++i) {
        double type1DamageMultiplier = typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type1 - 1]];
        double type2DamageMultiplier = type2 == NoneType ? 1.0 : typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type2 - 1]];
        if (type1DamageMultiplier * type2DamageMultiplier == 2.0) {
            typesWeak_x2.append(QString::number(i));
        }
    }

    return typesWeak_x2;
}

QStringList ModelTypes::getResistence_x2(int type1, int type2)
{
    if (type1 == NoneType || type1 < 0 || type1 >= types.count() || type2 < 0 || type2 >= types.count()) {
        return {};
    } else if (type1 == type2) {
        type2 = NoneType;
    }

    QStringList typesRes_x2;
    for (int i = Normal; i <= Fairy; ++i) {
        double type1DamageMultiplier = typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type1 - 1]];
        double type2DamageMultiplier = type2 == NoneType ? 1.0 : typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type2 - 1]];
        if (type1DamageMultiplier * type2DamageMultiplier == 0.5) {
            typesRes_x2.append(QString::number(i));
        }
    }

    return typesRes_x2;
}

QStringList ModelTypes::getInmunity_x0(int type1, int type2)
{
    if (type1 == NoneType || type1 < 0 || type1 >= types.count() || type2 < 0 || type2 >= types.count()) {
        return {};
    } else if (type1 == type2) {
        type2 = NoneType;
    }

    QStringList typesInm_x0;
    for (int i = Normal; i <= Fairy; ++i) {
        int effectiveness = modelTypeChart->getTypeChart()[i - 1][type1 - 1];
        double type1DamageMultiplier = typeEffectivenessMultiplier[effectiveness];
        double type2DamageMultiplier = type2 == NoneType ? 1.0 : typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type2 - 1]];
        if (type1DamageMultiplier * type2DamageMultiplier == 0.0) {
            typesInm_x0.append(QString::number(i));
        }
    }

    return typesInm_x0;
}

QStringList ModelTypes::getNeutrality_x1(int type1, int type2)
{
    if (type1 == NoneType || type1 < 0 || type1 >= types.count() || type2 < 0 || type2 >= types.count()) {
        return {};
    } else if (type1 == type2) {
        type2 = NoneType;
    }

    QStringList typesNeutral_x1;
    for (int i = Normal; i <= Fairy; ++i) {
        double type1DamageMultiplier = typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type1 - 1]];
        double type2DamageMultiplier = type2 == NoneType ? 1.0 : typeEffectivenessMultiplier[modelTypeChart->getTypeChart()[i - 1][type2 - 1]];
        if (type1DamageMultiplier * type2DamageMultiplier == 1.0) {
            typesNeutral_x1.append(QString::number(i));
        }
    }

    return typesNeutral_x1;
}

ModelTypeChart* ModelTypes::getModelTypeChart() const
{
    return modelTypeChart;
}

int ModelTypes::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelTypes::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelTypes::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelTypes::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

QString ModelTypes::getFilter() const
{
    return filter;
}

void ModelTypes::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelTypes::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelTypes::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}

bool ModelTypes::getShowTypeNone() const
{
    return showTypeNone;
}

void ModelTypes::setShowTypeNone(bool value)
{
    if (showTypeNone != value) {
        showTypeNone = value;
        emit showTypeNoneChanged(value);
        updateModelByFilter();
    }
}

QStringList ModelTypes::getTypeNames() const
{
    return typeNames;
}
