#ifndef STATCALCULATOR_H
#define STATCALCULATOR_H

#include <QObject>
#include <QtQml>
#include <QVector>
#include "../../database/common/db_common.h"
#include "../../database/natures/db_natures.h"

class StatCalculator : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit StatCalculator(QObject *parent = nullptr);

public slots:
    int calculateStat(int generation, int stat, int base, int iv, int ev, int level, int natureSigness = 0);
};

#endif // STATCALCULATOR_H
