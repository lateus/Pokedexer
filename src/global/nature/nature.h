#ifndef NATURE_H
#define NATURE_H

#include <QString>
#include <QVector>
#include <QPair>

class Nature
{
public:
    Nature(int natureId, const QString &natureName, int natureStatUp, int natureStatDown, int natureFlavorUp, int natureFlavorDown, bool natureIsNeutral);

    int getId() const;
    QString getName() const;
    int getStatUp() const;
    int getStatDown() const;
    int getFlavorUp() const;
    int getFlavorDown() const;
    bool getIsNeutral() const;

private:
    const int id;
    const QString name;
    const int statUp;
    const int statDown;
    const int flavorUp;
    const int flavorDown;
    const bool isNeutral;
};

#endif // NATURE_H
