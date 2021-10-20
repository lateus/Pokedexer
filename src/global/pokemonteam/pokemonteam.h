#ifndef POKEMONTEAM_H
#define POKEMONTEAM_H

#include <QObject>
#include <QtQml>

#include "../pokemonteampokemon/pokemonteampokemon.h"

class PokemonTeam : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool favorite READ getFavorite WRITE setFavorite NOTIFY favoriteChanged)
    Q_PROPERTY(int versionGroupId READ getVersionGroupId WRITE setVersionGroupId NOTIFY versionGroupIdChanged)

    Q_PROPERTY(PokemonTeamPokemon* pokemon1 READ getPokemon1 CONSTANT)
    Q_PROPERTY(PokemonTeamPokemon* pokemon2 READ getPokemon2 CONSTANT)
    Q_PROPERTY(PokemonTeamPokemon* pokemon3 READ getPokemon3 CONSTANT)
    Q_PROPERTY(PokemonTeamPokemon* pokemon4 READ getPokemon4 CONSTANT)
    Q_PROPERTY(PokemonTeamPokemon* pokemon5 READ getPokemon5 CONSTANT)
    Q_PROPERTY(PokemonTeamPokemon* pokemon6 READ getPokemon6 CONSTANT)

public:
    explicit PokemonTeam(QObject *parent = nullptr, const QString &teamName = QString(), int versionGroup = 0);

    QString getName() const;
    void setName(const QString &value);

    bool getFavorite() const;
    void setFavorite(bool value);

    int getVersionGroupId() const;
    void setVersionGroupId(int value);

    PokemonTeamPokemon* getPokemon1();
    PokemonTeamPokemon* getPokemon2();
    PokemonTeamPokemon* getPokemon3();
    PokemonTeamPokemon* getPokemon4();
    PokemonTeamPokemon* getPokemon5();
    PokemonTeamPokemon* getPokemon6();

    // Related non-members
    friend QDataStream &operator<<(QDataStream &stream, const PokemonTeam &pokemonTeam);
    friend QDataStream &operator>>(QDataStream &stream, PokemonTeam &pokemonTeam);

signals:
    void nameChanged(const QString &value);
    void favoriteChanged(bool value);
    void versionGroupIdChanged(int value);

private:
    QString name;
    bool favorite = false;
    int versionGroupId = 0; // any

    PokemonTeamPokemon *pokemon1 = new PokemonTeamPokemon;
    PokemonTeamPokemon *pokemon2 = new PokemonTeamPokemon;
    PokemonTeamPokemon *pokemon3 = new PokemonTeamPokemon;
    PokemonTeamPokemon *pokemon4 = new PokemonTeamPokemon;
    PokemonTeamPokemon *pokemon5 = new PokemonTeamPokemon;
    PokemonTeamPokemon *pokemon6 = new PokemonTeamPokemon;
};

#endif // POKEMONTEAM_H
