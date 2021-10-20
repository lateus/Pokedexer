#ifndef MODELTYPECHART_H
#define MODELTYPECHART_H

#include <QAbstractTableModel>
#include <QtQml>
#include <QColor>
#include "../../../database/common/db_common.h"

class ModelTypeChart : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("To internal use of ModelTypes.")

public:
    enum Roles { IdRole = Qt::UserRole + 1, ValueRole, LightColorRole, DarkColorRole };
    const TypeEffectivenessEnum typeChart[18][18] = {
                        /*   Normal            Fighting          Flying            Poison            Ground            Rock              Bug               Ghost             Steel             Fire              Water             Grass             Electric          Psychic           Ice               Dragon            Dark              Fairy            */
        /* Normal   */  {    Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, Neutral,          Inmune,           NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral          },
        /* Fighting */  {    SuperEffective,   Neutral,          NotVeryEffective, NotVeryEffective, Neutral,          SuperEffective,   NotVeryEffective, Inmune,           SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, SuperEffective,   Neutral,          SuperEffective,   NotVeryEffective },
        /* Flying   */  {    Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral,          NotVeryEffective, SuperEffective,   Neutral,          NotVeryEffective, Neutral,          Neutral,          SuperEffective,   NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          Neutral          },
        /* Poison   */  {    Neutral,          Neutral,          Neutral,          NotVeryEffective, NotVeryEffective, NotVeryEffective, Neutral,          NotVeryEffective, Inmune,           Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective   },
        /* Ground   */  {    Neutral,          Neutral,          Inmune,           SuperEffective,   Neutral,          SuperEffective,   NotVeryEffective, Neutral,          SuperEffective,   SuperEffective,   Neutral,          NotVeryEffective, SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          Neutral          },
        /* Rock     */  {    Neutral,          NotVeryEffective, SuperEffective,   Neutral,          NotVeryEffective, Neutral,          SuperEffective,   Neutral,          NotVeryEffective, SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral          },
        /* Bug      */  {    Neutral,          NotVeryEffective, NotVeryEffective, NotVeryEffective, Neutral,          Neutral,          Neutral,          NotVeryEffective, NotVeryEffective, NotVeryEffective, Neutral,          SuperEffective,   Neutral,          SuperEffective,   Neutral,          Neutral,          SuperEffective,   NotVeryEffective },
        /* Ghost    */  {    Inmune,           Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          NotVeryEffective, Neutral          },
        /* Steel    */  {    Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          NotVeryEffective, NotVeryEffective, NotVeryEffective, Neutral,          NotVeryEffective, Neutral,          SuperEffective,   Neutral,          Neutral,          SuperEffective   },
        /* Fire     */  {    Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, SuperEffective,   Neutral,          SuperEffective,   NotVeryEffective, NotVeryEffective, SuperEffective,   Neutral,          Neutral,          SuperEffective,   NotVeryEffective, Neutral,          Neutral          },
        /* Water    */  {    Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   SuperEffective,   Neutral,          Neutral,          Neutral,          SuperEffective,   NotVeryEffective, NotVeryEffective, Neutral,          Neutral,          Neutral,          NotVeryEffective, Neutral,          Neutral          },
        /* Grass    */  {    Neutral,          Neutral,          NotVeryEffective, NotVeryEffective, SuperEffective,   SuperEffective,   NotVeryEffective, Neutral,          NotVeryEffective, NotVeryEffective, SuperEffective,   NotVeryEffective, Neutral,          Neutral,          Neutral,          NotVeryEffective, Neutral,          Neutral          },
        /* Electric */  {    Neutral,          Neutral,          SuperEffective,   Neutral,          Inmune,           Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   NotVeryEffective, NotVeryEffective, Neutral,          Neutral,          NotVeryEffective, Neutral,          Neutral          },
        /* Psychic  */  {    Neutral,          SuperEffective,   Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, Neutral,          Neutral,          Inmune,           Neutral          },
        /* Ice      */  {    Neutral,          Neutral,          SuperEffective,   Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral,          NotVeryEffective, NotVeryEffective, NotVeryEffective, SuperEffective,   Neutral,          Neutral,          NotVeryEffective, SuperEffective,   Neutral,          Neutral          },
        /* Dragon   */  {    Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Inmune           },
        /* Dark     */  {    Neutral,          NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   Neutral,          Neutral,          NotVeryEffective, NotVeryEffective },
        /* Fairy    */  {    Neutral,          SuperEffective,   Neutral,          NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          NotVeryEffective, NotVeryEffective, Neutral,          Neutral,          Neutral,          Neutral,          Neutral,          SuperEffective,   SuperEffective,   Neutral          }
    };
    const QVector<QColor> lightColors = { QColor(0x79, 0x55, 0x48, 0xFF), QColor(0x9C, 0x27, 0xB0, 0xFF), QColor(0x00, 0x00, 0x00, 0x00), QColor(0xF4, 0x43, 0x36, 0xFF) };
    const QVector<QColor> darkColors  = { QColor(0xBC, 0xAA, 0xA4, 0xFF), QColor(0xCE, 0x93, 0xD8, 0xFF), QColor(0x00, 0x00, 0x00, 0x00), QColor(0xEF, 0x9A, 0x9A, 0xFF) };

    explicit ModelTypeChart(QObject *parent = nullptr);
    const TypeEffectivenessEnum (&getTypeChart() const) [18][18];

public slots:
    QString getTypeName(int type) const;

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
};

#endif // MODELTYPECHART_H
