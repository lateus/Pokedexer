#include "pokemonteam.h"

PokemonTeam::PokemonTeam(QObject *parent, const QString &teamName, int versionGroup) : QObject(parent), name(teamName), versionGroupId(versionGroup)
{

}

QString PokemonTeam::getName() const
{
    return name;
}

void PokemonTeam::setName(const QString &value)
{
    if (name != value) {
        name = value;
        emit nameChanged(value);
    }
}

bool PokemonTeam::getFavorite() const
{
    return favorite;
}

void PokemonTeam::setFavorite(bool value)
{
    if (favorite != value) {
        favorite = value;
        emit favoriteChanged(value);
    }
}

int PokemonTeam::getVersionGroupId() const
{
    return versionGroupId;
}

void PokemonTeam::setVersionGroupId(int value)
{
    if (versionGroupId != value) {
        versionGroupId = value;
        emit versionGroupIdChanged(value);
    }
}

PokemonTeamPokemon* PokemonTeam::getPokemon1()
{
    return pokemon1;
}

PokemonTeamPokemon* PokemonTeam::getPokemon2()
{
    return pokemon2;
}

PokemonTeamPokemon* PokemonTeam::getPokemon3()
{
    return pokemon3;
}

PokemonTeamPokemon* PokemonTeam::getPokemon4()
{
    return pokemon4;
}

PokemonTeamPokemon* PokemonTeam::getPokemon5()
{
    return pokemon5;
}

PokemonTeamPokemon* PokemonTeam::getPokemon6()
{
    return pokemon6;
}

QDataStream &operator<<(QDataStream &stream, const PokemonTeam &pokemonTeam)
{
    return stream << pokemonTeam.name << pokemonTeam.favorite << pokemonTeam.versionGroupId << *pokemonTeam.pokemon1 << *pokemonTeam.pokemon2 << *pokemonTeam.pokemon3 << *pokemonTeam.pokemon4 << *pokemonTeam.pokemon5 << *pokemonTeam.pokemon6;
}

QDataStream &operator>>(QDataStream &stream, PokemonTeam &pokemonTeam)
{
    return stream >> pokemonTeam.name >> pokemonTeam.favorite >> pokemonTeam.versionGroupId >> *pokemonTeam.pokemon1 >> *pokemonTeam.pokemon2 >> *pokemonTeam.pokemon3 >> *pokemonTeam.pokemon4 >> *pokemonTeam.pokemon5 >> *pokemonTeam.pokemon6;
}
