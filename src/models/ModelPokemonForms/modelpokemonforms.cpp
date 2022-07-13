#include "modelpokemonforms.h"

ModelPokemonForms::ModelPokemonForms(const QVector<PokemonForm> &pkmnForms, int languageId, int versionGroupId, QObject *parent)
    : QAbstractListModel(parent), currentLanguage(languageId), currentVersionGroup(versionGroupId), pokemonForms(pkmnForms)
{
    if (!pokemonForms.isEmpty()) {
        updateMegaStatus();
    }
}

QHash<int, QByteArray> ModelPokemonForms::roleNames() const
{
    return {
        { IdRole, "formId" },
        { VersionGroupRole, "versionGroup" },
        { PokemonIdRole, "pokemonId" },
        { OrderRole, "order" },
        { IsDefaultRole, "isDefault" },
        { IsBattleOnlyRole, "isBattleOnly" },
        { IsMegaRole, "isMega" },
        { NameRole, "name" }
    };
}

int ModelPokemonForms::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return pokemonForms.size();
}

QVariant ModelPokemonForms::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int pokemonFormId = index.row();
    return getPokemonFormData(pokemonFormId, role);
}

QVariant ModelPokemonForms::getPokemonFormData(int pokemonFormId, int role) const
{
    const PokemonForm pokemonForm = pokemonForms[pokemonFormId];

    switch (role) {
    case IdRole:
        return pokemonForm.getId();
    case VersionGroupRole:
        return pokemonForm.getVersionGroupId();
    case PokemonIdRole:
        return pokemonForm.getPokemonId();
    case OrderRole:
        return pokemonForm.getOrder();
    case IsDefaultRole:
        return pokemonForm.getIsDefault();
    case IsBattleOnlyRole:
        return pokemonForm.getIsBattleOnly();
    case IsMegaRole:
        return pokemonForm.getIsMega();
    case NameRole:
        return pokemonForm.getNames().at(currentLanguage - 1).isEmpty() ? pokemonForm.getNames().at(8) : pokemonForm.getNames().at(currentLanguage - 1);
    default:
        return QVariant();
    }
}

int ModelPokemonForms::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelPokemonForms::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelPokemonForms::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelPokemonForms::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        setPokemonForms(pokemonForms); // to reset the model
    }
}

QVector<PokemonForm> ModelPokemonForms::getPokemonForms() const
{
    return pokemonForms;
}

void ModelPokemonForms::setPokemonForms(QVector<PokemonForm> value)
{
    beginResetModel();
    pokemonForms = value;
    updateMegaStatus();
    endResetModel();
}

bool ModelPokemonForms::getHasMega() const
{
    return hasMega;
}

void ModelPokemonForms::updateMegaStatus()
{
    for (const auto &pkmnForm : qAsConst(pokemonForms)) {
        if (pkmnForm.getIsMega()) {
            if (!hasMega) {
                emit hasMegaChanged(true);
            }
            break;
        }
    }

    if (hasMega) {
        emit hasMegaChanged(false);
    }
}
