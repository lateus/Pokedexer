#ifndef MODELITEMS_H
#define MODELITEMS_H

#include <QAbstractListModel>
#include <QtQml>

class ModelItems : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(bool showItemNone READ getShowItemNone WRITE setShowItemNone NOTIFY showItemNoneChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, NameRole, FlavorTextRole, DetailedEffectRole, FlingPowerRole, HasBigIconRole };
    Q_ENUM(Roles)
    explicit ModelItems(QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    bool getShowItemNone() const;
    void setShowItemNone(bool value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    QVariant getItemData(int itemId, int role = Qt::DisplayRole) const;

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void showItemNoneChanged(bool value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);

private:
    int currentLanguage = 7; // ES spanish
    int currentVersionGroup = 18; // ultra sun - ultra moon
    bool showItemNone = false;

    QVector<int> filteredItems;
    QString filter;
    bool filterMatchs = true;

    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELITEMS_H
