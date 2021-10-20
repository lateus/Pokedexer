#ifndef POKEMONMOVE_H
#define POKEMONMOVE_H


class PokemonMove
{
public:
    PokemonMove(int moveId, int moveVersionGroupId, int moveLearnMethodId, int learnLevel);

    int getId() const;
    int getVersionGroupId() const;
    int getLearnMethodId() const;
    int getLevel() const;

    bool operator==(const PokemonMove &pokemonMove) const;
    bool operator!=(const PokemonMove &pokemonMove) const;

private:
    const int id;
    const int versionGroupId;
    const int learnMethodId;
    const int level;
};

#endif // POKEMONMOVE_H
