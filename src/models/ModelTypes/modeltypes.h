#ifndef MODELTYPES_H
#define MODELTYPES_H

#include <QAbstractListModel>
#include <QtQml>
#include "ModelTypeChart/modeltypechart.h"

class ModelTypes : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)
    Q_PROPERTY(bool showTypeNone READ getShowTypeNone WRITE setShowTypeNone NOTIFY showTypeNoneChanged)
    Q_PROPERTY(ModelTypeChart* modelTypeChart READ getModelTypeChart CONSTANT)

public:
    enum Roles { IdRole = Qt::UserRole + 1, NameRole, GenerationRole, SuperEffectiveToRole, NotVeryEffectiveToRole, NullToRole, SuperEffectiveFromRole, NotVeryEffectiveFromRole, NullFromRole, AdditionalInfoRole };
    explicit ModelTypes(QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

    Q_INVOKABLE QStringList getTypeNames() const;

    bool getShowTypeNone() const;
    void setShowTypeNone(bool value);

    ModelTypeChart *getModelTypeChart() const;

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    QStringList getWeakness_x4(int type1, int type2 = 0);
    QStringList getResistence_x4(int type1, int type2 = 0);
    QStringList getWeakness_x2(int type1, int type2 = 0);
    QStringList getResistence_x2(int type1, int type2 = 0);
    QStringList getInmunity_x0(int type1, int type2 = 0);
    QStringList getNeutrality_x1(int type1, int type2 = 0);

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void showTypeNoneChanged(bool value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);

private:
    int currentLanguage = 9; // EN english
    int currentVersionGroup = 18; // ultra sun - ultra moon
    bool showTypeNone = false;

    const QStringList typeNames = { tr("None"), tr("Normal"), tr("Fighting"), tr("Flying"), tr("Poison"), tr("Ground"), tr("Rock"), tr("Bug"), tr("Ghost"), tr("Steel"), tr("Fire"), tr("Water"), tr("Grass"), tr("Electric"), tr("Psychic"), tr("Ice"), tr("Dragon"), tr("Dark"), tr("Fairy") };
    const QVector<QString> additionalInfo = {
        "",
        "",
        "",
        "",
        tr("From generation 2 onwards cannot be poisoned (except by pokémon with the ability Corrosive)"),
        "",
        "",
        "",
        "",
        tr("Introduced in generation 2. Cannot be poisoned (except by pokémon with the ability Corrosive)"),
        tr("From generation 4 onwards cannot be burned."),
        "",
        tr("From generation 4 onwards cannot been affected by powders like Spore, Poison Powder, etc."),
        tr("From generation 4 onwards cannot be paralized."),
        "",
        tr("From generation 4 onwards cannot be frozen."),
        "",
        tr("Introduced in generation 2. From generation 7 onwards cannot be affected by Prankster."),
        tr("Introduced in generation 6.")
    };

    ModelTypeChart *modelTypeChart = new ModelTypeChart;

    QVector<int> filteredTypes;
    QString filter;
    bool filterMatchs = true;

    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELTYPES_H
