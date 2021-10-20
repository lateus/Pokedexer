#include "pokemonform.h"

PokemonForm::PokemonForm(int formId, int versionGroup, int pkmnId, int formOrder, bool formIsDefault, bool formIsBattleOnly, bool formIsMega, const QVector<QString> &formNames)
    : id(formId), versionGroupId(versionGroup), pokemonId(pkmnId), order(formOrder), isDefault(formIsDefault), isBattleOnly(formIsBattleOnly), isMega(formIsMega), names(formNames)
{

}

int PokemonForm::getId() const
{
    return id;
}

int PokemonForm::getVersionGroupId() const
{
    return versionGroupId;
}

int PokemonForm::getPokemonId() const
{
    return pokemonId;
}

int PokemonForm::getOrder() const
{
    return order;
}

bool PokemonForm::getIsDefault() const
{
    return isDefault;
}

bool PokemonForm::getIsBattleOnly() const
{
    return isBattleOnly;
}

bool PokemonForm::getIsMega() const
{
    return isMega;
}

QVector<QString> PokemonForm::getNames() const
{
    return names;
}
