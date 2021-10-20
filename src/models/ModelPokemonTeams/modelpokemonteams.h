#ifndef MODELPOKEMONTEAMS_H
#define MODELPOKEMONTEAMS_H

#include <QAbstractListModel>
#include <QtQml>

#include "../ModelPokemonInTeam/modelpokemoninteam.h"

class ModelPokemonTeams : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    enum Roles { IdRole = Qt::UserRole + 1, NameRole, FavoriteRole, VersionGroupIdRole, TeamModelRole };
    Q_ENUM(Roles)
    explicit ModelPokemonTeams(QObject *parent = nullptr);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

public slots:
    QVariant getTeamData(int teamId, int role) const;
    bool setTeamData(int teamId, const QVariant &value, int role);
    bool addTeam(const QString &name = QString());
    bool removeTeam(int index);
    bool removeTeam(const QString &name);
    bool saveTeam(int index);
    bool saveTeam(const QString &name);
    int loadTeams();

    QVariant getPokemonInTeamData(int teamId, int pokemonInTeamId, int role = Qt::DisplayRole) const;
    bool clearTeamPokemon(int teamId, int pokemonInTeamId);
    bool clearTeamPokemon(const QString &teamName, int pokemonInTeamId);

    bool teamNameExists(const QString &name, Qt::CaseSensitivity caseSensitivity = Qt::CaseInsensitive) const;
    int indexOfTeam(const QString &name, Qt::CaseSensitivity caseSensitivity = Qt::CaseInsensitive) const;

    bool saveTeamState(int teamIndex);
    bool saveTeamState(const QString &teamName);
    bool compareTeamWithState(int teamIndex);
    bool restoreTeamState(int teamIndex);
    bool restoreTeamState(const QString &teamName);

signals:
    void teamDataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight, const QVector<int> &roles = QVector<int>());
    void teamStateSaved(int teamIndex);
    void teamStateRestored(int teamIndex);

private:
    QVector<ModelPokemonInTeam*> teams;
    ModelPokemonInTeam savedTeam; // see `saveTeamState` function
    const QString teamsFolder = "teams";
    const QString teamFileExtension = "pokedexerteam";
};

#endif // MODELPOKEMONTEAMS_H
