#ifndef MODELMOVES_H
#define MODELMOVES_H

#include <QAbstractListModel>
#include <QtQml>

class ModelMoves : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(bool showMoveNone READ getShowMoveNone WRITE setShowMoveNone NOTIFY showMoveNoneChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)
    Q_PROPERTY(int filterType READ getFilterType WRITE setFilterType NOTIFY filterTypeChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, NameRole, FlavorTextRole, ShortEffectRole, DetailedEffectRole, PowerRole, PpRole, AccuracyRole, PriorityRole, EffectChanceRole, DamageClassRole, TargetRole, TypeRole, ContestTypeRole, ContestEffectRole, SuperContestEffectRole, GenerationRole };
    Q_ENUM(Roles)
    explicit ModelMoves(QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    bool getShowMoveNone() const;
    void setShowMoveNone(bool value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

    int getFilterType() const;
    void setFilterType(int value);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    QVariant getMoveData(int moveId, int role) const;

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void showMoveNoneChanged(bool value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);
    void filterTypeChanged(int value);

private:
    int currentLanguage = 9; // EN english
    int currentVersionGroup = 18; // ultra sun - ultra moon
    bool showMoveNone = false;

    QVector<int> filteredMoves;
    QString filter;
    bool filterMatchs = true;

    int filterType = 0;

    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELMOVES_H
