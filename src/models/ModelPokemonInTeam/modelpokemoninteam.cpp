#include "modelpokemoninteam.h"

#include <QFile>
#include <QDir>
#include <QDataStream>
#include <QCoreApplication>

ModelPokemonInTeam::ModelPokemonInTeam(const QString &teamName, int teamVersionGroupId, QObject *parent)
    : QAbstractListModel(parent), name(teamName), versionGroupId(teamVersionGroupId)
{
}

QHash<int, QByteArray> ModelPokemonInTeam::roleNames() const
{
    return {
        { IndexRole, "index" },
        { PokemonIdRole, "pokemonId" },
        { FormIdRole, "formId" },
        { GenderIdRole, "genderId" },
        { ShinyRole, "shiny" },
        { NicknameRole, "nickname" },
        { AbilityIdRole, "abilityId" },
        { LevelRole, "level" },
        { NatureIdRole, "natureId" },
        { ItemIdRole, "itemId" },
        { IvHpRole, "ivHp" },
        { IvAtkRole, "ivAtk" },
        { IvDefRole, "ivDef" },
        { IvSpAtkRole, "ivSpAtk" },
        { IvSpDefRole, "ivSpDef" },
        { IvSpdRole, "ivSpd" },
        { EvHpRole, "evHp" },
        { EvAtkRole, "evAtk" },
        { EvDefRole, "evDef" },
        { EvSpAtkRole, "evSpAtk" },
        { EvSpDefRole, "evSpDef" },
        { EvSpdRole, "evSpd" },
        { Move1IdRole, "move1Id" },
        { Move2IdRole, "move2Id" },
        { Move3IdRole, "move3Id" },
        { Move4IdRole, "move4Id" }
    };
}

QString ModelPokemonInTeam::getName() const
{
    return name;
}

void ModelPokemonInTeam::setName(const QString &value)
{
    if (name != value) {
        name = value;
        emit nameChanged(value);
    }
}

bool ModelPokemonInTeam::getFavorite() const
{
    return favorite;
}

void ModelPokemonInTeam::setFavorite(bool value)
{
    if (favorite != value) {
        favorite = value;
        emit favoriteChanged(value);
    }
}

int ModelPokemonInTeam::getVersionGroupId() const
{
    return versionGroupId;
}

void ModelPokemonInTeam::setVersionGroupId(int value)
{
    if (versionGroupId != value) {
        versionGroupId = value;
        emit versionGroupIdChanged(value);
    }
}

bool ModelPokemonInTeam::operator==(const ModelPokemonInTeam &modelPokemonInTeamToCompare) const
{
    bool requirement = name == modelPokemonInTeamToCompare.name &&
            favorite == modelPokemonInTeamToCompare.favorite &&
            versionGroupId == modelPokemonInTeamToCompare.versionGroupId &&
            teamPokemons.count() == modelPokemonInTeamToCompare.teamPokemons.count(); // always true
    if (!requirement) { // to avoid unnecesary team checking
        return false;
    }

    // if the requirement is satisfied, now check the teams one by one
    for (int i = 0; i < teamPokemons.count(); ++i) {
        if (*teamPokemons[i] != *modelPokemonInTeamToCompare.teamPokemons[i]) {
            return false;
        }
    }
    return true;
}

bool ModelPokemonInTeam::operator!=(const ModelPokemonInTeam &modelPokemonInTeamToCompare) const
{
    return !(*this == modelPokemonInTeamToCompare);
}

int ModelPokemonInTeam::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return teamPokemons.count(); // always == 6
}

QVariant ModelPokemonInTeam::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    return getTeamPokemonData(index.row(), role);
}

bool ModelPokemonInTeam::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return false;
    }

    return setTeamPokemonData(index.row(), value, role);
}

QVariant ModelPokemonInTeam::getTeamPokemonData(int pokemonIndex, int role) const
{
    if (pokemonIndex < 0 || pokemonIndex >= teamPokemons.count()) {
        return QVariant();
    }

    switch (role) {
    case IndexRole:
        return pokemonIndex;
    case PokemonIdRole:
        return teamPokemons[pokemonIndex]->getPokemonId();
    case FormIdRole:
        return teamPokemons[pokemonIndex]->getFormId();
    case GenderIdRole:
        return teamPokemons[pokemonIndex]->getGenderId();
    case ShinyRole:
        return teamPokemons[pokemonIndex]->getShiny();
    case NicknameRole:
        return teamPokemons[pokemonIndex]->getNickname();
    case AbilityIdRole:
        return teamPokemons[pokemonIndex]->getAbilityId();
    case LevelRole:
        return teamPokemons[pokemonIndex]->getLevel();
    case NatureIdRole:
        return teamPokemons[pokemonIndex]->getNatureId();
    case ItemIdRole:
        return teamPokemons[pokemonIndex]->getItemId();
    case IvHpRole:
        return teamPokemons[pokemonIndex]->getIvHp();
    case IvAtkRole:
        return teamPokemons[pokemonIndex]->getIvAtk();
    case IvDefRole:
        return teamPokemons[pokemonIndex]->getIvDef();
    case IvSpAtkRole:
        return teamPokemons[pokemonIndex]->getIvSpAtk();
    case IvSpDefRole:
        return teamPokemons[pokemonIndex]->getIvSpDef();
    case IvSpdRole:
        return teamPokemons[pokemonIndex]->getIvSpd();
    case EvHpRole:
        return teamPokemons[pokemonIndex]->getEvHp();
    case EvAtkRole:
        return teamPokemons[pokemonIndex]->getEvAtk();
    case EvDefRole:
        return teamPokemons[pokemonIndex]->getEvDef();
    case EvSpAtkRole:
        return teamPokemons[pokemonIndex]->getEvSpAtk();
    case EvSpDefRole:
        return teamPokemons[pokemonIndex]->getEvSpDef();
    case EvSpdRole:
        return teamPokemons[pokemonIndex]->getEvSpd();
    case Move1IdRole:
        return teamPokemons[pokemonIndex]->getMove1Id();
    case Move2IdRole:
        return teamPokemons[pokemonIndex]->getMove2Id();
    case Move3IdRole:
        return teamPokemons[pokemonIndex]->getMove3Id();
    case Move4IdRole:
        return teamPokemons[pokemonIndex]->getMove4Id();
    default:
        return QVariant();
    }
}

bool ModelPokemonInTeam::setTeamPokemonData(int pokemonIndex, const QVariant &value, int role)
{
    if (pokemonIndex < 0 || pokemonIndex >= teamPokemons.count()) {
        return false;
    }

    switch (role) {
    case IndexRole:
        return false;
    case PokemonIdRole:
        teamPokemons[pokemonIndex]->setPokemonId(value.toInt());
        break;
    case FormIdRole:
        teamPokemons[pokemonIndex]->setFormId(value.toInt());
        break;
    case GenderIdRole:
        teamPokemons[pokemonIndex]->setGenderId(value.toInt());
        break;
    case ShinyRole:
        teamPokemons[pokemonIndex]->setShiny(value.toBool());
        break;
    case NicknameRole:
        teamPokemons[pokemonIndex]->setNickname(value.toString());
        break;
    case AbilityIdRole:
        teamPokemons[pokemonIndex]->setAbilityId(value.toInt());
        break;
    case LevelRole:
        teamPokemons[pokemonIndex]->setLevel(value.toInt());
        break;
    case NatureIdRole:
        teamPokemons[pokemonIndex]->setNatureId(value.toInt());
        break;
    case ItemIdRole:
        teamPokemons[pokemonIndex]->setItemId(value.toInt());
        break;
    case IvHpRole:
        teamPokemons[pokemonIndex]->setIvHp(value.toInt());
        break;
    case IvAtkRole:
        teamPokemons[pokemonIndex]->setIvAtk(value.toInt());
        break;
    case IvDefRole:
        teamPokemons[pokemonIndex]->setIvDef(value.toInt());
        break;
    case IvSpAtkRole:
        teamPokemons[pokemonIndex]->setIvSpAtk(value.toInt());
        break;
    case IvSpDefRole:
        teamPokemons[pokemonIndex]->setIvSpDef(value.toInt());
        break;
    case IvSpdRole:
        teamPokemons[pokemonIndex]->setIvSpd(value.toInt());
        break;
    case EvHpRole:
        teamPokemons[pokemonIndex]->setEvHp(value.toInt());
        break;
    case EvAtkRole:
        teamPokemons[pokemonIndex]->setEvAtk(value.toInt());
        break;
    case EvDefRole:
        teamPokemons[pokemonIndex]->setEvDef(value.toInt());
        break;
    case EvSpAtkRole:
        teamPokemons[pokemonIndex]->setEvSpAtk(value.toInt());
        break;
    case EvSpDefRole:
        teamPokemons[pokemonIndex]->setEvSpDef(value.toInt());
        break;
    case EvSpdRole:
        teamPokemons[pokemonIndex]->setEvSpd(value.toInt());
        break;
    case Move1IdRole:
        teamPokemons[pokemonIndex]->setMove1Id(value.toInt());
        break;
    case Move2IdRole:
        teamPokemons[pokemonIndex]->setMove2Id(value.toInt());
        break;
    case Move3IdRole:
        teamPokemons[pokemonIndex]->setMove3Id(value.toInt());
        break;
    case Move4IdRole:
        teamPokemons[pokemonIndex]->setMove4Id(value.toInt());
        break;
    default:
        return false;
    }

    emit dataChanged(index(pokemonIndex), index(pokemonIndex), { role });
    return true;
}

bool ModelPokemonInTeam::clearPokemon(int pokemonIndex)
{
    if (pokemonIndex < 0 || pokemonIndex >= teamPokemons.count()) {
        return false;
    }

    setTeamPokemonData(pokemonIndex, 0, PokemonIdRole);
    setTeamPokemonData(pokemonIndex, 0, FormIdRole);
    setTeamPokemonData(pokemonIndex, 0, GenderIdRole);
    setTeamPokemonData(pokemonIndex, false, ShinyRole);
    setTeamPokemonData(pokemonIndex, QString(), NicknameRole);
    setTeamPokemonData(pokemonIndex, 0, AbilityIdRole);
    setTeamPokemonData(pokemonIndex, 0, LevelRole);
    setTeamPokemonData(pokemonIndex, 0, NatureIdRole);
    setTeamPokemonData(pokemonIndex, 0, ItemIdRole);
    setTeamPokemonData(pokemonIndex, 0, IvHpRole);
    setTeamPokemonData(pokemonIndex, 0, IvAtkRole);
    setTeamPokemonData(pokemonIndex, 0, IvDefRole);
    setTeamPokemonData(pokemonIndex, 0, IvSpAtkRole);
    setTeamPokemonData(pokemonIndex, 0, IvSpDefRole);
    setTeamPokemonData(pokemonIndex, 0, IvSpdRole);
    setTeamPokemonData(pokemonIndex, 0, EvHpRole);
    setTeamPokemonData(pokemonIndex, 0, EvAtkRole);
    setTeamPokemonData(pokemonIndex, 0, EvDefRole);
    setTeamPokemonData(pokemonIndex, 0, EvSpAtkRole);
    setTeamPokemonData(pokemonIndex, 0, EvSpDefRole);
    setTeamPokemonData(pokemonIndex, 0, EvSpdRole);
    setTeamPokemonData(pokemonIndex, 0, Move1IdRole);
    setTeamPokemonData(pokemonIndex, 0, Move2IdRole);
    setTeamPokemonData(pokemonIndex, 0, Move3IdRole);
    setTeamPokemonData(pokemonIndex, 0, Move4IdRole);

    return true;
}

//! Non-related members
QDataStream &operator<<(QDataStream &stream, const ModelPokemonInTeam &modelPokemonInTeam)
{
    stream << modelPokemonInTeam.name << modelPokemonInTeam.favorite << modelPokemonInTeam.versionGroupId;
    for (const PokemonTeamPokemon *pokemonInTeam : modelPokemonInTeam.teamPokemons) {
        stream << *pokemonInTeam;
    }
    return stream;
}

QDataStream &operator>>(QDataStream &stream, ModelPokemonInTeam &modelPokemonInTeam)
{
    stream >> modelPokemonInTeam.name >> modelPokemonInTeam.favorite >> modelPokemonInTeam.versionGroupId;
    for (PokemonTeamPokemon *pokemonInTeam : qAsConst(modelPokemonInTeam.teamPokemons)) {
        stream >> *pokemonInTeam;
    }
    return stream;
}
