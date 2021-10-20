#include "modelpokemonteams.h"

#include <QFile>
#include <QDir>
#include <QDataStream>
#include <QCoreApplication>

ModelPokemonTeams::ModelPokemonTeams(QObject *parent) : QAbstractListModel(parent)
{
    loadTeams();
}

QHash<int, QByteArray> ModelPokemonTeams::roleNames() const
{
    return {
        { IdRole, "teamId" },
        { NameRole, "name" },
        { FavoriteRole, "favorite" },
        { VersionGroupIdRole, "versionGroupId" },
        { TeamModelRole, "teamModel" },
    };
}

int ModelPokemonTeams::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return teams.count();
}

QVariant ModelPokemonTeams::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    return getTeamData(index.row(), role);
}

bool ModelPokemonTeams::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return false;
    }

    return setTeamData(index.row(), value, role);
}

QVariant ModelPokemonTeams::getTeamData(int teamId, int role) const
{
    if (teamId < 0 || teamId >= teams.count()) {
        return QVariant();
    }
    auto team = teams[teamId];

    switch (role) {
    case IdRole:
        return teamId;
    case NameRole:
        return team->getName();
    case FavoriteRole:
        return team->getFavorite();
    case VersionGroupIdRole:
        return team->getVersionGroupId();
    case TeamModelRole:
        return QVariant::fromValue(team);
    default:
        return QVariant();
    }
}

bool ModelPokemonTeams::setTeamData(int teamId, const QVariant &value, int role)
{
    if (teamId < 0 || teamId >= teams.count()) {
        return false;
    }
    auto team = teams[teamId];

    // the following vars will only be used if the role is `NameRole`
    QString oldName, newName;
    bool moveFile = false;

    switch (role) {
    case IdRole:
        return false;
    case NameRole:
        // BUG: The filename must always match the team's name. Otherwise we will end up with copies of the same team file.
        oldName = team->getName();
        newName = value.toString();
        if (teamNameExists(newName)) {
            qCritical("The new name is already taken by another team. Operation canceled.");
            return false;
        }
        moveFile = oldName != newName;
        if (moveFile) {
            QString filename = teamsFolder + "/" + oldName + "." + teamFileExtension;
            QString newFilename = teamsFolder + "/" + newName + "." + teamFileExtension;
            if (!QFile::rename(filename, newFilename)) {
                qWarning("Couldn't rename the team (%s -> %s). A copy may be saved instead.", qPrintable(filename), qPrintable(newFilename));
            }
        } else {
            if (savedTeam.getName() == oldName) { // when the name changes, it's already saved
                savedTeam.setName(newName);
            }
        }
        team->setName(newName);
        break;
    case FavoriteRole:
        team->setFavorite(value.toBool());
        break;
    case VersionGroupIdRole:
        team->setVersionGroupId(value.toInt());
        break;
    case TeamModelRole:
        return false;
    default:
        return false;
    }

    emit dataChanged(index(teamId), index(teamId), { role });
    return true;
}

bool ModelPokemonTeams::addTeam(const QString &name)
{
    if (teamNameExists(name)) {
        qCritical("The new name is already taken by another team. Operation canceled.");
        return false;
    }
    beginInsertRows(QModelIndex(), teams.count(), teams.count());
    ModelPokemonInTeam *team = new ModelPokemonInTeam(name.isEmpty() ? QString::number(teams.count() + 1) : name, 0, this);
    teams.append(team);
    connect(team, &ModelPokemonInTeam::dataChanged, this, &ModelPokemonTeams::teamDataChanged);
    bool saveResult = saveTeam(teams.count() - 1);
    if (!saveResult) {
        qWarning("The team was added to the list but it couldn't be saved on disk. Save it manually.");
    }
    endInsertRows();
    return true;
}

bool ModelPokemonTeams::removeTeam(int index)
{
    if (index < 0 || index >= teams.count()) {
        return false;
    }
    bool isFavorite = teams[index]->getFavorite();
    if (isFavorite) {
        qCritical("Cannot remove a team that is marked as favorite. Remove the mark first.");
        return false;
    }
    beginRemoveRows(QModelIndex(), index, index);
    QString teamName = teams[index]->getName();
    QString fileName = teamsFolder + "/" + teamName + "." + teamFileExtension;
    if (!QFile::remove(fileName)) {
        qCritical("The team %s couldn't be removed from disk.", qPrintable(fileName));
        return false;
    }
    delete teams.takeAt(index);
    endRemoveRows();
    return true;
}

bool ModelPokemonTeams::removeTeam(const QString &name)
{
    return removeTeam(indexOfTeam(name));
}

bool ModelPokemonTeams::saveTeam(int index)
{
    if (index < 0 || index >= teams.count()) {
        return false;
    }

    auto team = teams[index];
    if (!QDir().exists("teams")) {
        QDir().mkpath("teams");
    }
    QString filename = teamsFolder + "/" + team->getName() + "." + teamFileExtension;
    QFile f(filename);
    if (!f.open(QFile::WriteOnly)) {
        qCritical("Cannot open file for output");
        return false;
    }

    QDataStream out(&f);
    out << *team;
    f.close();
    return true;
}

bool ModelPokemonTeams::saveTeam(const QString &name)
{
    return saveTeam(indexOfTeam(name));
}

int ModelPokemonTeams::loadTeams()
{
    QDir d("teams");
    const QStringList teamList = d.entryList(QDir::Files | QDir::NoDotAndDotDot | QDir::NoSymLinks);
    QFile f;
    for (const QString &teamElement : teamList) {
        if (!teamElement.endsWith(teamFileExtension)) {
            continue;
        }
        f.setFileName(d.path() + "/" + teamElement);
        if (!f.open(QFile::ReadOnly)) {
            qCritical("Cannot open file %s for input", f.fileName().toUtf8().constData());
            continue;
        }
        QDataStream in(&f);
        ModelPokemonInTeam *team = new ModelPokemonInTeam;
        in >> *team;
        QString fileBaseName(teamElement); // the team's name must match the file's name
        fileBaseName.remove("." + teamFileExtension);
        team->setName(fileBaseName);
        teams.append(team);
        f.close();
        connect(team, &ModelPokemonInTeam::dataChanged, this, &ModelPokemonTeams::teamDataChanged);
    }
    return teams.count();
}

QVariant ModelPokemonTeams::getPokemonInTeamData(int teamId, int pokemonInTeamId, int role) const
{
    if (teamId < 0 || teamId >= teams.count()) { // cannot call `rowCount()` so... 6 is.
        return QVariant();
    }
    return teams[teamId]->getTeamPokemonData(pokemonInTeamId, role);
}

bool ModelPokemonTeams::clearTeamPokemon(int teamId, int pokemonInTeamId)
{
    if (teamId < 0 || teamId >= teams.count()) { // cannot call `rowCount()` so... 6 is.
        return false;
    }

    return teams[teamId]->clearPokemon(pokemonInTeamId);
}

bool ModelPokemonTeams::clearTeamPokemon(const QString &teamName, int pokemonInTeamId)
{
    return clearTeamPokemon(indexOfTeam(teamName), pokemonInTeamId);
}

bool ModelPokemonTeams::teamNameExists(const QString &name, Qt::CaseSensitivity caseSensitivity) const
{
    for (const ModelPokemonInTeam *team : teams) {
        QString teamName = team->getName();
        if (caseSensitivity == Qt::CaseInsensitive ? teamName.toLower() == name.toLower() : teamName == name) {
            return true;
        }
    }
    return false;
}

int ModelPokemonTeams::indexOfTeam(const QString &name, Qt::CaseSensitivity caseSensitivity) const
{
    for (int i = 0; i < teams.count(); ++i) {
        const ModelPokemonInTeam *team = teams[i];
        QString teamName = team->getName();
        if (caseSensitivity == Qt::CaseInsensitive ? teamName.toLower() == name.toLower() : teamName == name) {
            return i;
        }
    }
    return -1;
}

bool ModelPokemonTeams::saveTeamState(int teamIndex)
{
    if (teamIndex < 0 || teamIndex >= teams.count()) {
        return false;
    }

    const ModelPokemonInTeam *selectedTeam = teams[teamIndex];
    savedTeam.setName(selectedTeam->getName());
    savedTeam.setFavorite(selectedTeam->getFavorite());
    savedTeam.setVersionGroupId(selectedTeam->getVersionGroupId());

    // Now call `setTeamPokemonData` and `getTeamPokemonData`...
    for (int i = 0; i < 6; ++i) {
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::PokemonIdRole), ModelPokemonInTeam::PokemonIdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::FormIdRole), ModelPokemonInTeam::FormIdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::GenderIdRole), ModelPokemonInTeam::GenderIdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::ShinyRole), ModelPokemonInTeam::ShinyRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::NicknameRole), ModelPokemonInTeam::NicknameRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::AbilityIdRole), ModelPokemonInTeam::AbilityIdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::LevelRole), ModelPokemonInTeam::LevelRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::NatureIdRole), ModelPokemonInTeam::NatureIdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::ItemIdRole), ModelPokemonInTeam::ItemIdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::IvHpRole), ModelPokemonInTeam::IvHpRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::IvAtkRole), ModelPokemonInTeam::IvAtkRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::IvDefRole), ModelPokemonInTeam::IvDefRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::IvSpAtkRole), ModelPokemonInTeam::IvSpAtkRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::IvSpDefRole), ModelPokemonInTeam::IvSpDefRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::IvSpdRole), ModelPokemonInTeam::IvSpdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::EvHpRole), ModelPokemonInTeam::EvHpRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::EvAtkRole), ModelPokemonInTeam::EvAtkRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::EvDefRole), ModelPokemonInTeam::EvDefRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::EvSpAtkRole), ModelPokemonInTeam::EvSpAtkRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::EvSpDefRole), ModelPokemonInTeam::EvSpDefRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::EvSpdRole), ModelPokemonInTeam::EvSpdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::Move1IdRole), ModelPokemonInTeam::Move1IdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::Move2IdRole), ModelPokemonInTeam::Move2IdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::Move3IdRole), ModelPokemonInTeam::Move3IdRole);
        savedTeam.setTeamPokemonData(i, selectedTeam->getTeamPokemonData(i, ModelPokemonInTeam::Move4IdRole), ModelPokemonInTeam::Move4IdRole);
    }

    emit teamStateSaved(teamIndex);
    return true;
}

bool ModelPokemonTeams::saveTeamState(const QString &teamName)
{
    return saveTeamState(indexOfTeam(teamName));
}

bool ModelPokemonTeams::compareTeamWithState(int teamIndex)
{
    if (teamIndex < 0 || teamIndex >= teams.count()) {
        return false;
    }

    return savedTeam == *teams[teamIndex];
}

bool ModelPokemonTeams::restoreTeamState(int teamIndex)
{

    if (teamIndex < 0 || teamIndex >= teams.count()) {
        return false;
    }

    ModelPokemonInTeam *selectedTeam = teams[teamIndex];
    selectedTeam->setName(savedTeam.getName());
    selectedTeam->setFavorite(savedTeam.getFavorite());
    selectedTeam->setVersionGroupId(savedTeam.getVersionGroupId());

    // Now call `setTeamPokemonData` and `getTeamPokemonData`...
    for (int i = 0; i < 6; ++i) {
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::PokemonIdRole), ModelPokemonInTeam::PokemonIdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::FormIdRole), ModelPokemonInTeam::FormIdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::GenderIdRole), ModelPokemonInTeam::GenderIdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::ShinyRole), ModelPokemonInTeam::ShinyRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::NicknameRole), ModelPokemonInTeam::NicknameRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::AbilityIdRole), ModelPokemonInTeam::AbilityIdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::LevelRole), ModelPokemonInTeam::LevelRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::NatureIdRole), ModelPokemonInTeam::NatureIdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::ItemIdRole), ModelPokemonInTeam::ItemIdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::IvHpRole), ModelPokemonInTeam::IvHpRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::IvAtkRole), ModelPokemonInTeam::IvAtkRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::IvDefRole), ModelPokemonInTeam::IvDefRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::IvSpAtkRole), ModelPokemonInTeam::IvSpAtkRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::IvSpDefRole), ModelPokemonInTeam::IvSpDefRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::IvSpdRole), ModelPokemonInTeam::IvSpdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::EvHpRole), ModelPokemonInTeam::EvHpRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::EvAtkRole), ModelPokemonInTeam::EvAtkRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::EvDefRole), ModelPokemonInTeam::EvDefRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::EvSpAtkRole), ModelPokemonInTeam::EvSpAtkRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::EvSpDefRole), ModelPokemonInTeam::EvSpDefRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::EvSpdRole), ModelPokemonInTeam::EvSpdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::Move1IdRole), ModelPokemonInTeam::Move1IdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::Move2IdRole), ModelPokemonInTeam::Move2IdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::Move3IdRole), ModelPokemonInTeam::Move3IdRole);
        selectedTeam->setTeamPokemonData(i, savedTeam.getTeamPokemonData(i, ModelPokemonInTeam::Move4IdRole), ModelPokemonInTeam::Move4IdRole);
    }

    emit teamStateRestored(teamIndex);
    return true;
}

bool ModelPokemonTeams::restoreTeamState(const QString &teamName)
{
    return restoreTeamState(indexOfTeam(teamName));
}
