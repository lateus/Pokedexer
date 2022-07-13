#ifndef MODELBERRIES_H
#define MODELBERRIES_H

#include <QAbstractListModel>
#include <QtQml>

class ModelBerries : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, NameRole, FlavorTextRole, DetailedEffectRole, NaturalGiftPowerRole, NaturalGiftTypeRole, SizeRole, MaxHarvestRole, GrowthTimeRole, SoilDrynessRole, SmoothnessRole, FirmnessRole, ItemIdRole, PotencyByFlavorRole };
    explicit ModelBerries(QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

    Q_INVOKABLE QStringList getFlavorNames() const;

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);

private:
    int currentLanguage = 9; // EN english
    int currentVersionGroup = 18; // ultra sun - ultra moon

    QVector<int> filteredBerries;
    QString filter;
    bool filterMatchs = true;

    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELBERRIES_H
