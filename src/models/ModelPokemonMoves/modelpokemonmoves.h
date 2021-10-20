#ifndef MODELPOKEMONMOVES_H
#define MODELPOKEMONMOVES_H

#include <QAbstractListModel>
#include <QtQml>
#include "../../global/pokemonmove/pokemonmove.h"

class ModelPokemonMoves : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("To internal use of ModelPokemon.")

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)
    Q_PROPERTY(int columnToSort READ getColumnToSort WRITE setColumnToSort NOTIFY columnToSortChanged)
    Q_PROPERTY(Qt::SortOrder sortOrder READ getSortOrder WRITE setSortOrder NOTIFY sortOrderChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, VersionGroupRole, LearnMethodIdRole, LearnMethodNameRole, LearnMethodDescriptionRole, LevelRole };
    Q_ENUM(Roles)
    explicit ModelPokemonMoves(const QVector<PokemonMove> &pkmnMoves = {}, QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    QVector<PokemonMove> getPokemonMoves() const;
    void setPokemonMoves(QVector<PokemonMove> value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

    int getColumnToSort() const;
    void setColumnToSort(int value);

    Qt::SortOrder getSortOrder() const;
    void setSortOrder(const Qt::SortOrder &value);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    void sort(int column, Qt::SortOrder order = Qt::AscendingOrder);

public slots:
    QVariant getPokemonMovesData(int pokemonMoveIndex, int role) const;

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);
    void columnToSortChanged(int value);
    void sortOrderChanged(Qt::SortOrder value);

private:
    int currentLanguage = 7; // ES spanish
    int currentVersionGroup = 18; // ultra sun - ultra moon

    QVector<PokemonMove> pokemonMoves;
    QVector<int> checkedPokemonMoves;

    // filtering
    QVector<int> filteredPokemonMoves;
    QString filter;
    bool filterMatchs = true;

    // sorting
    int columnToSort = -1; // none
    Qt::SortOrder sortOrder = Qt::AscendingOrder;

    void checkPokemonMoves();
    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELPOKEMONMOVES_H
