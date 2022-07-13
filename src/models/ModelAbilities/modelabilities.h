#ifndef MODELABILITIES_H
#define MODELABILITIES_H

#include <QAbstractListModel>
#include <QtQml>

class ModelAbilities : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(bool showAbilityNone READ getShowAbilityNone WRITE setShowAbilityNone NOTIFY showAbilityNoneChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, GenerationRole, NameRole, FlavorTextRole, DetailedEffectRole };
    Q_ENUM(Roles)
    explicit ModelAbilities(QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

    bool getShowAbilityNone() const;
    void setShowAbilityNone(bool value);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    QVariant getAbilityData(int abilityId, int role) const;

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void showAbilityNoneChanged(bool value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);

private:
    int currentLanguage = 9; // EN english
    int currentVersionGroup = 18; // ultra sun - ultra moon
    bool showAbilityNone = false;

    QVector<int> filteredAbilities;
    QString filter;
    bool filterMatchs = true;

    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELABILITIES_H
