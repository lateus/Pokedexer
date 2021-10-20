#include "pokemonmove.h"

PokemonMove::PokemonMove(int moveId, int moveVersionGroupId, int moveLearnMethodId, int learnLevel)
    : id(moveId), versionGroupId(moveVersionGroupId), learnMethodId(moveLearnMethodId), level(learnLevel)
{

}

int PokemonMove::getId() const
{
    return id;
}

int PokemonMove::getVersionGroupId() const
{
    return versionGroupId;
}

int PokemonMove::getLearnMethodId() const
{
    return learnMethodId;
}

int PokemonMove::getLevel() const
{
    return level;
}

bool PokemonMove::operator==(const PokemonMove &pokemonMove) const
{
    return id == pokemonMove.id && versionGroupId == pokemonMove.versionGroupId && learnMethodId == pokemonMove.learnMethodId && level == pokemonMove.level;
}

bool PokemonMove::operator!=(const PokemonMove &pokemonMove) const
{
    return !(*this == pokemonMove);
}
