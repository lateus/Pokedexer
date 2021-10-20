#include "pokemonteampokemon.h"

PokemonTeamPokemon::PokemonTeamPokemon(QObject *parent) : QObject(parent)
{

}

int PokemonTeamPokemon::getPokemonId() const
{
    return pokemonId;
}

void PokemonTeamPokemon::setPokemonId(int value)
{
    if (pokemonId != value) {
        pokemonId = value;
        emit pokemonIdChanged(value);
    }
}

int PokemonTeamPokemon::getFormId() const
{
    return formId;
}

void PokemonTeamPokemon::setFormId(int value)
{
    if (formId != value) {
        formId = value;
        emit formIdChanged(value);
    }
}

int PokemonTeamPokemon::getGenderId() const
{
    return genderId;
}

void PokemonTeamPokemon::setGenderId(int value)
{
    if (genderId != value) {
        genderId = value;
        emit genderIdChanged(value);
    }
}

bool PokemonTeamPokemon::getShiny() const
{
    return shiny;
}

void PokemonTeamPokemon::setShiny(bool value)
{
    if (shiny != value) {
        shiny = value;
        emit shinyChanged(value);
    }
}

QString PokemonTeamPokemon::getNickname() const
{
    return nickname;
}

void PokemonTeamPokemon::setNickname(const QString &value)
{
    if (nickname != value) {
        nickname = value;
        emit nicknameChanged(value);
    }
}

int PokemonTeamPokemon::getAbilityId() const
{
    return abilityId;
}

void PokemonTeamPokemon::setAbilityId(int value)
{
    if (abilityId != value) {
        abilityId = value;
        emit abilityIdChanged(value);
    }
}

int PokemonTeamPokemon::getLevel() const
{
    return level;
}

void PokemonTeamPokemon::setLevel(int value)
{
    if (level != value) {
        level = value;
        emit levelChanged(value);
    }
}

int PokemonTeamPokemon::getNatureId() const
{
    return natureId;
}

void PokemonTeamPokemon::setNatureId(int value)
{
    if (natureId != value) {
        natureId = value;
        emit natureIdChanged(value);
    }
}

int PokemonTeamPokemon::getIvHp() const
{
    return ivHp;
}

void PokemonTeamPokemon::setIvHp(int value)
{
    if (ivHp != value) {
        ivHp = value;
        emit ivHpChanged(value);
    }
}

int PokemonTeamPokemon::getIvAtk() const
{
    return ivAtk;
}

void PokemonTeamPokemon::setIvAtk(int value)
{
    if (ivAtk != value) {
        ivAtk = value;
        emit ivAtkChanged(value);
    }
}

int PokemonTeamPokemon::getIvDef() const
{
    return ivDef;
}

void PokemonTeamPokemon::setIvDef(int value)
{
    if (ivDef != value) {
        ivDef = value;
        emit ivDefChanged(value);
    }
}

int PokemonTeamPokemon::getIvSpAtk() const
{
    return ivSpAtk;
}

void PokemonTeamPokemon::setIvSpAtk(int value)
{
    if (ivSpAtk != value) {
        ivSpAtk = value;
        emit ivSpAtkChanged(value);
    }
}

int PokemonTeamPokemon::getIvSpDef() const
{
    return ivSpDef;
}

void PokemonTeamPokemon::setIvSpDef(int value)
{
    if (ivSpDef != value) {
        ivSpDef = value;
        emit ivSpDefChanged(value);
    }
}

int PokemonTeamPokemon::getIvSpd() const
{
    return ivSpd;
}

void PokemonTeamPokemon::setIvSpd(int value)
{
    if (ivSpd != value) {
        ivSpd = value;
        emit ivSpdChanged(value);
    }
}

int PokemonTeamPokemon::getEvHp() const
{
    return evHp;
}

void PokemonTeamPokemon::setEvHp(int value)
{
    if (evHp != value) {
        evHp = value;
        emit evHpChanged(value);
    }
}

int PokemonTeamPokemon::getEvAtk() const
{
    return evAtk;
}

void PokemonTeamPokemon::setEvAtk(int value)
{
    if (evAtk != value) {
        evAtk = value;
        emit evAtkChanged(value);
    }
}

int PokemonTeamPokemon::getEvDef() const
{
    return evDef;
}

void PokemonTeamPokemon::setEvDef(int value)
{
    if (evDef != value) {
        evDef = value;
        emit evDefChanged(value);
    }
}

int PokemonTeamPokemon::getEvSpAtk() const
{
    return evSpAtk;
}

void PokemonTeamPokemon::setEvSpAtk(int value)
{
    if (evSpAtk != value) {
        evSpAtk = value;
        emit evSpAtkChanged(value);
    }
}

int PokemonTeamPokemon::getEvSpDef() const
{
    return evSpDef;
}

void PokemonTeamPokemon::setEvSpDef(int value)
{
    if (evSpDef != value) {
        evSpDef = value;
        emit evSpDefChanged(value);
    }
}

int PokemonTeamPokemon::getEvSpd() const
{
    return evSpd;
}

void PokemonTeamPokemon::setEvSpd(int value)
{
    if (evSpd != value) {
        evSpd = value;
        emit evSpdChanged(value);
    }
}

int PokemonTeamPokemon::getItemId() const
{
    return itemId;
}

void PokemonTeamPokemon::setItemId(int value)
{
    if (itemId != value) {
        itemId = value;
        emit itemIdChanged(value);
    }
}

int PokemonTeamPokemon::getMove1Id() const
{
    return move1Id;
}

void PokemonTeamPokemon::setMove1Id(int value)
{
    if (move1Id != value) {
        move1Id = value;
        emit move1IdChanged(value);
    }
}

int PokemonTeamPokemon::getMove2Id() const
{
    return move2Id;
}

void PokemonTeamPokemon::setMove2Id(int value)
{
    if (move2Id != value) {
        move2Id = value;
        emit move2IdChanged(value);
    }
}

int PokemonTeamPokemon::getMove3Id() const
{
    return move3Id;
}

void PokemonTeamPokemon::setMove3Id(int value)
{
    if (move3Id != value) {
        move3Id = value;
        emit move3IdChanged(value);
    }
}

int PokemonTeamPokemon::getMove4Id() const
{
    return move4Id;
}

void PokemonTeamPokemon::setMove4Id(int value)
{
    if (move4Id != value) {
        move4Id = value;
        emit move4IdChanged(value);
    }
}

bool PokemonTeamPokemon::operator==(const PokemonTeamPokemon &pokemonTeamPokemonToCompare) const
{
    return  pokemonId == pokemonTeamPokemonToCompare.pokemonId &&
            formId    == pokemonTeamPokemonToCompare.formId &&
            genderId  == pokemonTeamPokemonToCompare.genderId &&
            shiny     == pokemonTeamPokemonToCompare.shiny &&
            nickname  == pokemonTeamPokemonToCompare.nickname &&
            abilityId == pokemonTeamPokemonToCompare.abilityId &&
            level     == pokemonTeamPokemonToCompare.level &&
            natureId  == pokemonTeamPokemonToCompare.natureId &&
            itemId    == pokemonTeamPokemonToCompare.itemId &&
            ivHp      == pokemonTeamPokemonToCompare.ivHp &&
            ivAtk     == pokemonTeamPokemonToCompare.ivAtk &&
            ivDef     == pokemonTeamPokemonToCompare.ivDef &&
            ivSpAtk   == pokemonTeamPokemonToCompare.ivSpAtk &&
            ivSpDef   == pokemonTeamPokemonToCompare.ivSpDef &&
            ivSpd     == pokemonTeamPokemonToCompare.ivSpd &&
            evHp      == pokemonTeamPokemonToCompare.evHp &&
            evAtk     == pokemonTeamPokemonToCompare.evAtk &&
            evDef     == pokemonTeamPokemonToCompare.evDef &&
            evSpAtk   == pokemonTeamPokemonToCompare.evSpAtk &&
            evSpDef   == pokemonTeamPokemonToCompare.evSpDef &&
            evSpd     == pokemonTeamPokemonToCompare.evSpd &&
            move1Id   == pokemonTeamPokemonToCompare.move1Id &&
            move2Id   == pokemonTeamPokemonToCompare.move2Id &&
            move3Id   == pokemonTeamPokemonToCompare.move3Id &&
            move4Id   == pokemonTeamPokemonToCompare.move4Id;
}

bool PokemonTeamPokemon::operator!=(const PokemonTeamPokemon &pokemonTeamPokemonToCompare) const
{
    return !(*this == pokemonTeamPokemonToCompare);
}

QDataStream &operator<<(QDataStream &stream, const PokemonTeamPokemon &pokemonTeamPokemon)
{
    return stream << pokemonTeamPokemon.pokemonId << pokemonTeamPokemon.formId << pokemonTeamPokemon.genderId << pokemonTeamPokemon.shiny << pokemonTeamPokemon.nickname
           << pokemonTeamPokemon.abilityId
           << pokemonTeamPokemon.level << pokemonTeamPokemon.natureId
           << pokemonTeamPokemon.ivHp << pokemonTeamPokemon.ivAtk << pokemonTeamPokemon.ivDef << pokemonTeamPokemon.ivSpAtk << pokemonTeamPokemon.ivSpDef << pokemonTeamPokemon.ivSpd
           << pokemonTeamPokemon.evHp << pokemonTeamPokemon.evAtk << pokemonTeamPokemon.evDef << pokemonTeamPokemon.evSpAtk << pokemonTeamPokemon.evSpDef << pokemonTeamPokemon.evSpd
           << pokemonTeamPokemon.itemId << pokemonTeamPokemon.move1Id << pokemonTeamPokemon.move2Id << pokemonTeamPokemon.move3Id << pokemonTeamPokemon.move4Id;
}

QDataStream &operator>>(QDataStream &stream, PokemonTeamPokemon &pokemonTeamPokemon)
{
    return stream >> pokemonTeamPokemon.pokemonId >> pokemonTeamPokemon.formId >> pokemonTeamPokemon.genderId >> pokemonTeamPokemon.shiny >> pokemonTeamPokemon.nickname
                  >> pokemonTeamPokemon.abilityId
                  >> pokemonTeamPokemon.level >> pokemonTeamPokemon.natureId
                  >> pokemonTeamPokemon.ivHp >> pokemonTeamPokemon.ivAtk >> pokemonTeamPokemon.ivDef >> pokemonTeamPokemon.ivSpAtk >> pokemonTeamPokemon.ivSpDef >> pokemonTeamPokemon.ivSpd
                  >> pokemonTeamPokemon.evHp >> pokemonTeamPokemon.evAtk >> pokemonTeamPokemon.evDef >> pokemonTeamPokemon.evSpAtk >> pokemonTeamPokemon.evSpDef >> pokemonTeamPokemon.evSpd
                  >> pokemonTeamPokemon.itemId >> pokemonTeamPokemon.move1Id >> pokemonTeamPokemon.move2Id >> pokemonTeamPokemon.move3Id >> pokemonTeamPokemon.move4Id;
}
