#include "modelpokemon.h"
#include "../../database/pokemon/db_pokemon.h"

ModelPokemon::ModelPokemon(QObject *parent) : QAbstractListModel(parent)
{
    disableFiltering();
}

QHash<int, QByteArray> ModelPokemon::roleNames() const
{
    return {
        { IdRole, "pokemonId" },
        { SpeciesIdRole, "speciesId" },
        { GenerationRole, "generation" },
        { IsDefaultRole, "isDefault" },
        { OrderRole, "order" },
        { GenderRateIdRole, "genderRateId" },
        { CaptureRateRole, "captureRate" },
        { BaseHappinessRole, "baseHappiness" },
        { IsBabyRole, "isBaby" },
        { HatchCounterRole, "hatchCounter" },
        { HasGenderDifferencesRole, "hasGenderDifferences" },
        { FormsSwitchableRole, "formsSwitchable" },
        { GrowthRateIdRole, "growthRateId" },
        { NameRole, "name" },
        { GenusNameRole, "genusName" },
        { SpeciesDescriptionRole, "speciesDescription" },
        { SpeciesFlavorTextRole, "speciesFlavorText" },
        { PrimaryTypeRole, "primaryType" },
        { SecondaryTypeRole, "secondaryType" },
        { HeightRole, "pokemonHeight" },
        { WeightRole, "pokemonWeight" },
        { BaseExperienceRole, "baseExperience" },
        { BaseStatsRole, "baseStats" },
        { PrimaryAbilityRole, "primaryAbility" },
        { SecondaryAbilityRole, "secondaryAbility" },
        { HiddenAbilityRole, "hiddenAbility" },
        { ColorRole, "colorId" },
        { ShapeRole, "shapeId" },
        { PrimaryEggGroupRole, "primaryEggGroup" },
        { SecondaryEggGroupRole, "secondaryEggGroup" },
        { EvolutionChainIdRole, "evolutionChainId" },
        { MovesRole, "moves" },
        { FormsCountRole, "formsCount" },
        { FormsRole, "forms" }
    };
}

int ModelPokemon::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredPokemon.size();
}

QVariant ModelPokemon::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int pokemonId = filteredPokemon[index.row()];
    return getPokemonData(pokemonId, role);
}

QVariant ModelPokemon::getPokemonData(int pokemonId, int role) const
{
    int pokemonVectorIndex = (pokemonId - 1)/25;
    if (pokemonId <= 0 || pokemonVectorIndex > 38 || (pokemonVectorIndex == 38 && (pokemonId - 1) % 25 >= pokemon39.count())) {
        return QVariant();
    }
    const Pokemon pkmn = (pokemonVectorIndex == 0 ? pokemon1 : pokemonVectorIndex == 1 ? pokemon2 : pokemonVectorIndex == 2 ? pokemon3 : pokemonVectorIndex == 3 ? pokemon4 : pokemonVectorIndex == 4 ? pokemon5 : pokemonVectorIndex == 5 ? pokemon6 : pokemonVectorIndex == 6 ? pokemon7 : pokemonVectorIndex == 7 ? pokemon8 : pokemonVectorIndex == 8 ? pokemon9 : pokemonVectorIndex == 9 ? pokemon10 : pokemonVectorIndex == 10 ? pokemon11 : pokemonVectorIndex == 11 ? pokemon12 : pokemonVectorIndex == 12 ? pokemon13 : pokemonVectorIndex == 13 ? pokemon14 : pokemonVectorIndex == 14 ? pokemon15 : pokemonVectorIndex == 15 ? pokemon16 : pokemonVectorIndex == 16 ? pokemon17 : pokemonVectorIndex == 17 ? pokemon18 : pokemonVectorIndex == 18 ? pokemon19 : pokemonVectorIndex == 19 ? pokemon20 : pokemonVectorIndex == 20 ? pokemon21 : pokemonVectorIndex == 21 ? pokemon22 : pokemonVectorIndex == 22 ? pokemon23 : pokemonVectorIndex == 23 ? pokemon24 : pokemonVectorIndex == 24 ? pokemon25 : pokemonVectorIndex == 25 ? pokemon26 : pokemonVectorIndex == 26 ? pokemon27 : pokemonVectorIndex == 27 ? pokemon28 : pokemonVectorIndex == 28 ? pokemon29 : pokemonVectorIndex == 29 ? pokemon30 : pokemonVectorIndex == 30 ? pokemon31 : pokemonVectorIndex == 31 ? pokemon32 : pokemonVectorIndex == 32 ? pokemon33 : pokemonVectorIndex == 33 ? pokemon34 : pokemonVectorIndex == 34 ? pokemon35 : pokemonVectorIndex == 35 ? pokemon36 : pokemonVectorIndex == 36 ? pokemon37 : pokemonVectorIndex == 37 ? pokemon38 : pokemon39)[(pokemonId - 1) % 25];


    // avoid some warnings
    QStringList baseStats;

    switch (role) {
    case IdRole:
        return pkmn.getId();
    case SpeciesIdRole:
        return pkmn.getSpeciesId();
    case GenerationRole:
        return pkmn.getGenerationId();
    case IsDefaultRole:
        return pkmn.getIsDefault();
    case OrderRole:
        return pkmn.getOrder();
    case GenderRateIdRole:
        return pkmn.getGenderRateId();
    case CaptureRateRole:
        return pkmn.getCaptureRate();
    case BaseHappinessRole:
        return pkmn.getBaseHappiness();
    case IsBabyRole:
        return pkmn.getIsBaby();
    case HatchCounterRole:
        return pkmn.getHatchCounter();
    case HasGenderDifferencesRole:
        return pkmn.getHasGenderDifferences();
    case FormsSwitchableRole:
        return pkmn.getFormsSwitchable();
    case GrowthRateIdRole:
        return pkmn.getGrowthRateId();
    case NameRole:
        return pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1);
    case GenusNameRole:
        return pkmn.getGenusNames().at(currentLanguage - 1).isEmpty() ? pkmn.getGenusNames().at(8) : pkmn.getGenusNames().at(currentLanguage - 1);
    case SpeciesDescriptionRole:
        return pkmn.getSpeciesDescription().count() <= 0 ? "" : pkmn.getSpeciesDescription().at(currentLanguage - 1).isEmpty() ? pkmn.getSpeciesDescription().at(8) : pkmn.getSpeciesDescription().at(currentLanguage - 1);;
    case SpeciesFlavorTextRole:
        return pkmn.getSpeciesFlavorText().at(currentLanguage - 1).isEmpty() ? pkmn.getSpeciesFlavorText().at(8) : pkmn.getSpeciesFlavorText().at(currentLanguage - 1);
    case PrimaryTypeRole:
        return pkmn.getPrimaryType();
    case SecondaryTypeRole:
        return pkmn.getSecondaryType();
    case HeightRole:
        return pkmn.getHeight();
    case WeightRole:
        return pkmn.getWeight();
    case BaseExperienceRole:
        return pkmn.getBaseExp();
    case BaseStatsRole:
        for (const auto &stat : pkmn.getBaseStats()) {
            baseStats.append(QString::number(stat));
        }
        return baseStats;
    case PrimaryAbilityRole:
        return pkmn.getPrimaryAbility();
    case SecondaryAbilityRole:
        return pkmn.getSecondaryAbility();
    case HiddenAbilityRole:
        return pkmn.getHiddenAbility();
    case ColorRole:
        return pkmn.getColor();
    case ShapeRole:
        return pkmn.getShape();
    case PrimaryEggGroupRole:
        return pkmn.getPrimaryEggGroup();
    case SecondaryEggGroupRole:
        return pkmn.getSecondaryEggGroup();
    case EvolutionChainIdRole:
        return pkmn.getEvolutionChainId();
    case MovesRole:
        // modelPokemonMoves->setPokemonMoves(pkmn.getMoves());
        if (pkmn.getId() != pkmn.getSpeciesId()) {
            // It's there a pokemon that learns a totally different move when changes form?
            // Remove all `#if 0` if so
#if 0
            auto pokemonMoves(pkmn.getMoves());
#endif

            int speciesId = pkmn.getSpeciesId();
            int speciesVectorIndex = (speciesId - 1)/25;
            const Pokemon pkmnSpecie = (speciesVectorIndex == 0 ? pokemon1 : speciesVectorIndex == 1 ? pokemon2 : speciesVectorIndex == 2 ? pokemon3 : speciesVectorIndex == 3 ? pokemon4 : speciesVectorIndex == 4 ? pokemon5 : speciesVectorIndex == 5 ? pokemon6 : speciesVectorIndex == 6 ? pokemon7 : speciesVectorIndex == 7 ? pokemon8 : speciesVectorIndex == 8 ? pokemon9 : speciesVectorIndex == 9 ? pokemon10 : speciesVectorIndex == 10 ? pokemon11 : speciesVectorIndex == 11 ? pokemon12 : speciesVectorIndex == 12 ? pokemon13 : speciesVectorIndex == 13 ? pokemon14 : speciesVectorIndex == 14 ? pokemon15 : speciesVectorIndex == 15 ? pokemon16 : speciesVectorIndex == 16 ? pokemon17 : speciesVectorIndex == 17 ? pokemon18 : speciesVectorIndex == 18 ? pokemon19 : speciesVectorIndex == 19 ? pokemon20 : speciesVectorIndex == 20 ? pokemon21 : speciesVectorIndex == 21 ? pokemon22 : speciesVectorIndex == 22 ? pokemon23 : speciesVectorIndex == 23 ? pokemon24 : speciesVectorIndex == 24 ? pokemon25 : speciesVectorIndex == 25 ? pokemon26 : speciesVectorIndex == 26 ? pokemon27 : speciesVectorIndex == 27 ? pokemon28 : speciesVectorIndex == 28 ? pokemon29 : speciesVectorIndex == 29 ? pokemon30 : speciesVectorIndex == 30 ? pokemon31 : speciesVectorIndex == 31 ? pokemon32 : speciesVectorIndex == 32 ? pokemon33 : speciesVectorIndex == 33 ? pokemon34 : speciesVectorIndex == 34 ? pokemon35 : speciesVectorIndex == 35 ? pokemon36 : speciesVectorIndex == 36 ? pokemon37 : speciesVectorIndex == 37 ? pokemon38 : pokemon39)[(speciesId - 1) % 25];
            const auto &speciesMoves = pkmnSpecie.getMoves();
#if 0
            for (auto move : speciesMoves) {
                if (!pokemonMoves.contains(move)) {
                    pokemonMoves.append(PokemonMove(move));
                }
            }
            modelPokemonMoves = new ModelPokemonMoves(pokemonMoves);
#else
            return QVariant::fromValue(new ModelPokemonMoves(speciesMoves, currentLanguage, currentVersionGroup));
#endif
        } else {
            return QVariant::fromValue(new ModelPokemonMoves(pkmn.getMoves(), currentLanguage, currentVersionGroup));
        }
    case FormsCountRole:
        return pkmn.getForms().count();
    case FormsRole:
        // The app crashes some times when setting the form (probably because reseting the forms while reseting the forms)
         // modelPokemonForms->setPokemonForms(pkmn.getForms());
        return QVariant::fromValue(new ModelPokemonForms(pkmn.getForms(), currentLanguage, currentVersionGroup));
    default:
        return QVariant();
    }
}

void ModelPokemon::updateModelByFilter()
{
    beginResetModel();
    QVector<int> speciesIds;
    filteredPokemon.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (const auto &pkmn : pokemon1) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon2) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon3) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon4) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon5) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon6) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon7) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon8) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon9) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon10) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon11) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon12) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon13) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon14) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon15) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon16) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon17) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon18) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon19) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon20) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon21) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon22) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon23) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon24) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon25) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon26) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon27) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon28) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon29) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon30) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon31) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon32) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon33) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon34) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon35) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon36) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon37) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon38) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        for (const auto &pkmn : pokemon39) {
            bool match = (pkmn.getNames().at(currentLanguage - 1).isEmpty() ? pkmn.getNames().at(8) : pkmn.getNames().at(currentLanguage - 1)).toLower().contains(filter.toLower());
            bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
            if (speciesOnly) {
                match = match && !speciesIds.contains(pkmn.getSpeciesId());
                speciesIds.append(pkmn.getSpeciesId());
            }
            if (match && matchType) {
                filteredPokemon.append(pkmn.getId());
            }
        }
        setFilterMatchs(filteredPokemon.count() > 0);
        if (filteredPokemon.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    endResetModel();
}

void ModelPokemon::disableFiltering()
{
    QVector<int> speciesIds;
    filteredPokemon.clear();
    for (const auto &pkmn : pokemon1) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon2) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon3) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon4) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon5) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon6) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon7) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon8) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon9) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon10) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon11) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon12) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon13) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon14) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon15) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon16) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon17) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon18) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon19) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon20) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon21) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon22) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon23) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon24) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon25) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon26) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon27) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon28) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon29) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon30) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon31) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon32) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon33) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon34) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon35) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon36) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon37) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon38) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
    for (const auto &pkmn : pokemon39) {
        bool match = !speciesOnly || (speciesOnly && !speciesIds.contains(pkmn.getSpeciesId()));
        bool matchType = filterType == NoneType || filterType == pkmn.getPrimaryType() || filterType == pkmn.getSecondaryType();
        speciesIds.append(pkmn.getSpeciesId());
        if (match && matchType) {
            filteredPokemon.append(pkmn.getId());
        }
    }
}

int ModelPokemon::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelPokemon::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelPokemon::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelPokemon::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        // modelPokemonMoves->setCurrentLanguage(value);
        // modelPokemonForms->setCurrentLanguage(value);
        updateModelByFilter();
    }
}

bool ModelPokemon::getSpeciesOnly() const
{
    return speciesOnly;
}

void ModelPokemon::setSpeciesOnly(bool value)
{
    if (speciesOnly != value) {
        speciesOnly = value;
        emit speciesOnlyChanged(value);
        updateModelByFilter();
    }
}

QString ModelPokemon::getFilter() const
{
    return filter;
}

void ModelPokemon::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelPokemon::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelPokemon::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}

int ModelPokemon::getFilterType() const
{
    return filterType;
}

void ModelPokemon::setFilterType(int value)
{
    if (filterType != value) {
        filterType = value;
        emit filterTypeChanged(value);
        updateModelByFilter();
    }
}
