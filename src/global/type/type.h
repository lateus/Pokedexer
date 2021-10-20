#ifndef TYPE_H
#define TYPE_H

#include <QVector>

class Type
{
public:
    Type(int typeId, int generationId, const QVector<int> &superEffectiveToList, const QVector<int> &notVeryEffectiveToList, const QVector<int> &nullToList, const QVector<int> &superEffectiveFromList, const QVector<int> &notVeryEffectiveFromList, const QVector<int> &nullFromList);

    int getId() const;
    int getGeneration() const;

    QVector<int> getSuperEffectiveTo() const;
    QVector<int> getNotVeryEffectiveTo() const;
    QVector<int> getNullTo() const;

    QVector<int> getSuperEffectiveFrom() const;
    QVector<int> getNotVeryEffectiveFrom() const;
    QVector<int> getNullFrom() const;

private:
    const int id;
    const int generation;

    const QVector<int> superEffectiveTo;
    const QVector<int> notVeryEffectiveTo;
    const QVector<int> nullTo;

    const QVector<int> superEffectiveFrom;
    const QVector<int> notVeryEffectiveFrom;
    const QVector<int> nullFrom;
};

#endif // TYPE_H
