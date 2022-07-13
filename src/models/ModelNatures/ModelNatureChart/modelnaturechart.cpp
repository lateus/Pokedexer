#include "modelnaturechart.h"

ModelNatureChart::ModelNatureChart(QObject *parent) : QAbstractTableModel(parent)
{

}

QHash<int, QByteArray> ModelNatureChart::roleNames() const
{
    return {
        { IdRole, "natureId" }
    };
}

const NatureEnum (&ModelNatureChart::getNatureChart() const) [5][5]
{
    return natureChart;
}

int ModelNatureChart::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return 5;
}

int ModelNatureChart::columnCount(const QModelIndex &parent) const
{
    (void)parent;
    return 5;
}

QVariant ModelNatureChart::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    switch (role) {
    case IdRole:
        return natureChart[index.row()][index.column()];
    default:
        return QVariant();
    }
}

QVariant ModelNatureChart::headerData(int section, Qt::Orientation orientation, int role) const
{
    (void)orientation;
    (void)role;
    return section;
}
