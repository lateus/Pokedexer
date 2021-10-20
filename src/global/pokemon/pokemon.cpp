#include "pokemon.h"

Pokemon::Pokemon(int pokemonId, int pokemonSpeciesId, int pokemonGenerationId, int pokemonNationalDexIndex, bool isDefaultForm, int pokemonOrder, int pokemonGenderRateId, int pokemonCaptureRate, int pokemonBaseHappiness, bool pokemonIsBaby, int pokemonHatchCounter, bool pokemonHasGenderDifferences, bool pokemonFormsSwitchable, int pokemonGrowthRateId, const QVector<QString> &pokemonNames, const QVector<QString> &pokemonGenusNames, const QVector<QString> &pokemonSpeciesDescription, const QVector<QString> &pokemonSpeciesFlavorText, int pokemonPrimaryType, int pokemonSecondaryType, int pokemonHeight, int pokemonWeight, int pokemonBaseExp, const QVector<int> &pokemonBaseStats, int pokemonPrimaryAbility, int pokemonSecondaryAbility, int pokemonHiddenAbility, int pokemonColor, int pokemonShape, int pokemonPrimaryEggGroup, int pokemonSecondaryEggGroup, int pokemonEvolutionChainId, const QVector<PokemonMove> &pokemonMoves, const QVector<PokemonForm> &pokemonForms)
    : id(pokemonId), speciesId(pokemonSpeciesId), generationId(pokemonGenerationId), nationalDexIndex(pokemonNationalDexIndex), isDefault(isDefaultForm), order(pokemonOrder), genderRateId(pokemonGenderRateId), captureRate(pokemonCaptureRate), baseHappiness(pokemonBaseHappiness), isBaby(pokemonIsBaby), hatchCounter(pokemonHatchCounter), hasGenderDifferences(pokemonHasGenderDifferences), formsSwitchable(pokemonFormsSwitchable), growthRateId(pokemonGrowthRateId), names(pokemonNames), genusNames(pokemonGenusNames), speciesDescription(pokemonSpeciesDescription), speciesFlavorText(pokemonSpeciesFlavorText), primaryType(pokemonPrimaryType), secondaryType(pokemonSecondaryType), height(pokemonHeight), weight(pokemonWeight), baseExp(pokemonBaseExp), baseStats(pokemonBaseStats), primaryAbility(pokemonPrimaryAbility), secondaryAbility(pokemonSecondaryAbility), hiddenAbility(pokemonHiddenAbility), color(pokemonColor), shape(pokemonShape), primaryEggGroup(pokemonPrimaryEggGroup), secondaryEggGroup(pokemonSecondaryEggGroup), evolutionChainId(pokemonEvolutionChainId), moves(pokemonMoves), forms(pokemonForms)
{

}

int Pokemon::getId() const
{
    return id;
}

int Pokemon::getSpeciesId() const
{
    return speciesId;
}

int Pokemon::getGenerationId() const
{
    return generationId;
}

int Pokemon::getNationalDexIndex() const
{
    return nationalDexIndex;
}

bool Pokemon::getIsDefault() const
{
    return isDefault;
}

int Pokemon::getOrder() const
{
    return order;
}

int Pokemon::getGenderRateId() const
{
    return genderRateId;
}

int Pokemon::getCaptureRate() const
{
    return captureRate;
}

int Pokemon::getBaseHappiness() const
{
    return baseHappiness;
}

bool Pokemon::getIsBaby() const
{
    return isBaby;
}

int Pokemon::getHatchCounter() const
{
    return hatchCounter;
}

bool Pokemon::getHasGenderDifferences() const
{
    return hasGenderDifferences;
}

bool Pokemon::getFormsSwitchable() const
{
    return formsSwitchable;
}

int Pokemon::getGrowthRateId() const
{
    return growthRateId;
}

QVector<QString> Pokemon::getNames() const
{
    return names;
}

QVector<QString> Pokemon::getGenusNames() const
{
    return genusNames;
}

QVector<QString> Pokemon::getSpeciesDescription() const
{
    return speciesDescription;
}

QVector<QString> Pokemon::getSpeciesFlavorText() const
{
    return speciesFlavorText;
}

int Pokemon::getPrimaryType() const
{
    return primaryType;
}

int Pokemon::getSecondaryType() const
{
    return secondaryType;
}

int Pokemon::getHeight() const
{
    return height;
}

int Pokemon::getWeight() const
{
    return weight;
}

int Pokemon::getBaseExp() const
{
    return baseExp;
}

QVector<int> Pokemon::getBaseStats() const
{
    return baseStats;
}

int Pokemon::getPrimaryAbility() const
{
    return primaryAbility;
}

int Pokemon::getSecondaryAbility() const
{
    return secondaryAbility;
}

int Pokemon::getHiddenAbility() const
{
    return hiddenAbility;
}

int Pokemon::getColor() const
{
    return color;
}

int Pokemon::getShape() const
{
    return shape;
}

int Pokemon::getPrimaryEggGroup() const
{
    return primaryEggGroup;
}

int Pokemon::getSecondaryEggGroup() const
{
    return secondaryEggGroup;
}

int Pokemon::getEvolutionChainId() const
{
    return evolutionChainId;
}

QVector<PokemonMove> Pokemon::getMoves() const
{
    return moves;
}

QVector<PokemonForm> Pokemon::getForms() const
{
    return forms;
}
