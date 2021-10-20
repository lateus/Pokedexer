#ifndef MODELPOKEMONINTEAM_H
#define MODELPOKEMONINTEAM_H

#include <QAbstractListModel>
#include <QtQml>

#include "../../global/pokemonteampokemon/pokemonteampokemon.h"

class ModelPokemonInTeam : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool favorite READ getFavorite WRITE setFavorite NOTIFY favoriteChanged)
    Q_PROPERTY(int versionGroupId READ getVersionGroupId WRITE setVersionGroupId NOTIFY versionGroupIdChanged)

public:
    enum Roles {
        IndexRole = Qt::UserRole + 1, PokemonIdRole, FormIdRole, GenderIdRole,
        ShinyRole, NicknameRole, AbilityIdRole, LevelRole, NatureIdRole, ItemIdRole,
        IvHpRole, IvAtkRole, IvDefRole, IvSpAtkRole, IvSpDefRole, IvSpdRole,
        EvHpRole, EvAtkRole, EvDefRole, EvSpAtkRole, EvSpDefRole, EvSpdRole,
        Move1IdRole, Move2IdRole, Move3IdRole, Move4IdRole
    };
    Q_ENUM(Roles)
    explicit ModelPokemonInTeam(const QString &teamName = QString(), int teamVersionGroupId = 0, QObject *parent = nullptr);

    QString getName() const;
    void setName(const QString &value);

    bool getFavorite() const;
    void setFavorite(bool value);

    int getVersionGroupId() const;
    void setVersionGroupId(int value);

    bool operator==(const ModelPokemonInTeam &modelPokemonInTeamToCompare) const;
    bool operator!=(const ModelPokemonInTeam &modelPokemonInTeamToCompare) const;

    // Related non-members
    friend QDataStream &operator<<(QDataStream &stream, const ModelPokemonInTeam &pokemonTeam);
    friend QDataStream &operator>>(QDataStream &stream, ModelPokemonInTeam &pokemonTeam);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

public slots:
    QVariant getTeamPokemonData(int pokemonIndex, int role) const;
    bool setTeamPokemonData(int pokemonIndex, const QVariant &value, int role);
    bool clearPokemon(int pokemonIndex);

signals:
    void nameChanged(const QString &value);
    void favoriteChanged(bool value);
    void versionGroupIdChanged(int value);

private:
    QVector<PokemonTeamPokemon*> teamPokemons = { new PokemonTeamPokemon(), new PokemonTeamPokemon(), new PokemonTeamPokemon(), new PokemonTeamPokemon(), new PokemonTeamPokemon(), new PokemonTeamPokemon() };

    // QML
    QString name;
    bool favorite = false;
    int versionGroupId = 0; // any
};

#endif // MODELPOKEMONTEAMS_H
