#ifndef POKEMON_H
#define POKEMON_H

#include <QPair>
#include <QVector>

#include "../pokemonform/pokemonform.h"
#include "../pokemonmove/pokemonmove.h"

class Pokemon
{
public:
    Pokemon(int pokemonId, int pokemonSpeciesId, int pokemonGenerationId, int pokemonNationalDexIndex, bool isDefaultForm, int pokemonOrder, int pokemonGenderRateId, int pokemonCaptureRate, int pokemonBaseHappiness, bool pokemonIsBaby, int pokemonHatchCounter, bool pokemonHasGenderDifferences, bool pokemonFormsSwitchable, int pokemonGrowthRateId, const QVector<QString> &pokemonNames, const QVector<QString> &pokemonGenusNames, const QVector<QString> &pokemonSpeciesDescription, const QVector<QString> &pokemonSpeciesFlavorText, int pokemonPrimaryType, int pokemonSecondaryType, int pokemonHeight, int pokemonWeight, int pokemonBaseExp, const QVector<int> &pokemonBaseStats, int pokemonPrimaryAbility, int pokemonSecondaryAbility, int pokemonHiddenAbility, int pokemonColor, int pokemonShape, int pokemonPrimaryEggGroup, int pokemonSecondaryEggGroup, int pokemonEvolutionChainId, const QVector<PokemonMove> &pokemonMoves, const QVector<PokemonForm> &pokemonForms);

    int getId() const;
    int getSpeciesId() const;
    int getGenerationId() const;
    int getNationalDexIndex() const;
    bool getIsDefault() const;
    int getOrder() const;

    int getGenderRateId() const;
    int getCaptureRate() const;
    int getBaseHappiness() const;
    bool getIsBaby() const;
    int getHatchCounter() const;
    bool getHasGenderDifferences() const;
    bool getFormsSwitchable() const;
    int getGrowthRateId() const;

    QVector<QString> getNames() const;
    QVector<QString> getGenusNames() const;
    QVector<QString> getSpeciesDescription() const;
    QVector<QString> getSpeciesFlavorText() const;

    int getPrimaryType() const;
    int getSecondaryType() const;
    int getHeight() const;
    int getWeight() const;
    int getBaseExp() const;
    QVector<int> getBaseStats() const;

    int getPrimaryAbility() const;
    int getSecondaryAbility() const;
    int getHiddenAbility() const;

    int getColor() const;
    int getShape() const;

    int getPrimaryEggGroup() const;
    int getSecondaryEggGroup() const;

    int getEvolutionChainId() const;

    QVector<PokemonMove> getMoves() const;

    QVector<PokemonForm> getForms() const;

private:
    const int id;
    const int speciesId;
    const int generationId;
    const int nationalDexIndex;
    const bool isDefault;
    const int order;

    const int genderRateId;
    const int captureRate;
    const int baseHappiness;
    const bool isBaby;
    const int hatchCounter;
    const bool hasGenderDifferences;
    const bool formsSwitchable;
    const int growthRateId;

    const QVector<QString> names;
    const QVector<QString> genusNames;
    const QVector<QString> speciesDescription;
    const QVector<QString> speciesFlavorText;

    const int primaryType;
    const int secondaryType;
    const int height;
    const int weight;
    const int baseExp;
    const QVector<int> baseStats;

    const int primaryAbility;
    const int secondaryAbility;
    const int hiddenAbility;

    const int color;
    const int shape;

    const int primaryEggGroup;
    const int secondaryEggGroup;

    const int evolutionChainId;

    const QVector<PokemonMove> moves;

    const QVector<PokemonForm> forms;
};

#endif // POKEMON_H
