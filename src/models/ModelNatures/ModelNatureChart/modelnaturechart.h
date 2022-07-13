#ifndef MODELNATURECHART_H
#define MODELNATURECHART_H

#include <QAbstractTableModel>
#include <QtQml>
#include <QColor>
#include "../../../database/natures/db_natures.h"
#include "../../../database/common/db_common.h"

class ModelNatureChart : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("To internal use of ModelNatures.")

public:
    enum Roles { IdRole = Qt::UserRole + 1 };
    const NatureEnum natureChart[5][5] = {
        /* Neutral                  -Attack  -Defense -SpAtk   -SpDef   -Speed */
        /* +Attack         */  {    Hardy,   Lonely,  Adamant, Naughty, Brave   },
        /* +Defense        */  {    Bold,    Docile,  Impish,  Lax,     Relaxed },
        /* +SpecialAttack  */  {    Modest,  Mild,    Bashful, Rash,    Quiet   },
        /* +SpecialDefense */  {    Calm,    Gentle,  Careful, Quirky,  Sassy   },
        /* +Speed          */  {    Timid,   Hasty,   Jolly,   Naive,   Serious }
    };

    explicit ModelNatureChart(QObject *parent = nullptr);
    const NatureEnum (&getNatureChart() const) [5][5];

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
};

#endif // MODELNATURECHART_H
