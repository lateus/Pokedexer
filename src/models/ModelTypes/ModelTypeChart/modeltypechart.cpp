#include "modeltypechart.h"

ModelTypeChart::ModelTypeChart(QObject *parent) : QAbstractTableModel(parent)
{

}

QString ModelTypeChart::getTypeName(int type) const
{
    return typeNames[type];
}

QHash<int, QByteArray> ModelTypeChart::roleNames() const
{
    return {
        { IdRole, "effectivenessId" },
        { ValueRole, "value" },
        { LightColorRole, "lightColor" },
        { DarkColorRole, "darkColor" }
    };
}

const TypeEffectivenessEnum (&ModelTypeChart::getTypeChart() const) [18][18]
{
    return typeChart;
}

int ModelTypeChart::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return 18;
}

int ModelTypeChart::columnCount(const QModelIndex &parent) const
{
    (void)parent;
    return 18;
}

QVariant ModelTypeChart::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    switch (role) {
    case IdRole:
        return typeChart[index.row()][index.column()];
    case ValueRole:
        return typeEffectivenessMultiplier[typeChart[index.row()][index.column()]];
    case LightColorRole:
        return lightColors.at(typeChart[index.row()][index.column()]);
    case DarkColorRole:
        return darkColors.at(typeChart[index.row()][index.column()]);
    default:
        return QVariant();
    }
}

QVariant ModelTypeChart::headerData(int section, Qt::Orientation orientation, int role) const
{
    (void)orientation;
    (void)role;
    return section;
}
