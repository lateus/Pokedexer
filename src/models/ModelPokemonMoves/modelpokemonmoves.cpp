#include "modelpokemonmoves.h"
#include "../../database/moves/db_moves.h"
#include "../../database/common/db_common.h"

ModelPokemonMoves::ModelPokemonMoves(const QVector<PokemonMove> &pkmnMoves, QObject *parent)
    : QAbstractListModel(parent), pokemonMoves(pkmnMoves)
{
    if (!pokemonMoves.isEmpty()) {
        checkPokemonMoves();
    }
    disableFiltering();

    // setup signal connections
    connect(this, &ModelPokemonMoves::columnToSortChanged, [=]() {
        beginResetModel();
        sort(columnToSort, sortOrder);
        endResetModel();
    });
    connect(this, &ModelPokemonMoves::sortOrderChanged, [=]() {
        beginResetModel();
        sort(columnToSort, sortOrder);
        endResetModel();
    });
}

QHash<int, QByteArray> ModelPokemonMoves::roleNames() const
{
    return {
        { IdRole, "moveId" },
        { VersionGroupRole, "versionGroup" },
        { LearnMethodIdRole, "learnMethodId" },
        { LearnMethodNameRole, "learnMethodName" },
        { LearnMethodDescriptionRole, "learnMethodDescription" },
        { LevelRole, "level" }
    };
}

int ModelPokemonMoves::rowCount(const QModelIndex &parent) const
{
    (void)parent;
    return filteredPokemonMoves.size();
}

QVariant ModelPokemonMoves::data(const QModelIndex &index, int role) const
{
    if (!checkIndex(index, QAbstractItemModel::CheckIndexOption::IndexIsValid | QAbstractItemModel::CheckIndexOption::ParentIsInvalid)) {
        return QVariant();
    }

    int pokemonMoveIndex = index.row();
    return getPokemonMovesData(pokemonMoveIndex, role);
}

QVariant ModelPokemonMoves::getPokemonMovesData(int pokemonMoveIndex, int role) const
{
    const PokemonMove pokemonMove = pokemonMoves[checkedPokemonMoves[filteredPokemonMoves[pokemonMoveIndex]]];

    switch (role) {
    case IdRole:
        return pokemonMove.getId();
    case VersionGroupRole:
        return pokemonMove.getVersionGroupId();
    case LearnMethodIdRole:
        return pokemonMove.getLearnMethodId();
    case LearnMethodNameRole:
        return moveLearnMethodNames[pokemonMove.getLearnMethodId()];
    case LearnMethodDescriptionRole:
        return moveLearnMethodDescriptions[pokemonMove.getLearnMethodId()];
    case LevelRole:
        return pokemonMove.getLevel();
    default:
        return QVariant();
    }
}

void ModelPokemonMoves::sort(int column, Qt::SortOrder order)
{
    switch (column) {
    case 0:
        std::sort(filteredPokemonMoves.begin(), filteredPokemonMoves.end(), [=](int pokemonMoveIndex1, int pokemonMoveIndex2)
        {
            const PokemonMove pokemonMove1 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex1]];
            const PokemonMove pokemonMove2 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex2]];

            int move1Id = pokemonMove1.getId();
            int move2Id = pokemonMove2.getId();
#ifndef LITE_VERSION
            int move1VectorIndex = (move1Id - 1)/150;
            int move2VectorIndex = (move2Id - 1)/150;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : move1VectorIndex == 1 ? moves2 : move1VectorIndex == 2 ? moves3 : move1VectorIndex == 3 ? moves4 : moves5)[(move1Id - 1) % 150];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : move2VectorIndex == 1 ? moves2 : move2VectorIndex == 2 ? moves3 : move2VectorIndex == 3 ? moves4 : moves5)[(move2Id - 1) % 150];
#else
            int move1VectorIndex = (move1Id - 1)/400;
            int move2VectorIndex = (move2Id - 1)/400;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : moves2)[(move1Id - 1) % 400];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : moves2)[(move2Id - 1) % 400];
#endif

            return order == Qt::DescendingOrder ? typeNames[move1.getType()] > typeNames[move2.getType()] : typeNames[move1.getType()] < typeNames[move2.getType()];
        });
        break;
    case 1:
        std::sort(filteredPokemonMoves.begin(), filteredPokemonMoves.end(), [=](int pokemonMoveIndex1, int pokemonMoveIndex2)
        {
            const PokemonMove pokemonMove1 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex1]];
            const PokemonMove pokemonMove2 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex2]];

            int move1Id = pokemonMove1.getId();
            int move2Id = pokemonMove2.getId();
#ifndef LITE_VERSION
            int move1VectorIndex = (move1Id - 1)/150;
            int move2VectorIndex = (move2Id - 1)/150;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : move1VectorIndex == 1 ? moves2 : move1VectorIndex == 2 ? moves3 : move1VectorIndex == 3 ? moves4 : moves5)[(move1Id - 1) % 150];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : move2VectorIndex == 1 ? moves2 : move2VectorIndex == 2 ? moves3 : move2VectorIndex == 3 ? moves4 : moves5)[(move2Id - 1) % 150];
#else
            int move1VectorIndex = (move1Id - 1)/400;
            int move2VectorIndex = (move2Id - 1)/400;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : moves2)[(move1Id - 1) % 400];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : moves2)[(move2Id - 1) % 400];
#endif

            QString name1 = (move1.getNames().at(currentLanguage - 1).isEmpty() ? move1.getNames().at(8) : move1.getNames().at(currentLanguage - 1)).toLower();
            QString name2 = (move2.getNames().at(currentLanguage - 1).isEmpty() ? move2.getNames().at(8) : move2.getNames().at(currentLanguage - 1)).toLower();
            return order == Qt::DescendingOrder ? name1 > name2 : name1 < name2;
        });
        break;
    case 2:
        std::sort(filteredPokemonMoves.begin(), filteredPokemonMoves.end(), [=](int pokemonMoveIndex1, int pokemonMoveIndex2)
        {
            const PokemonMove pokemonMove1 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex1]];
            const PokemonMove pokemonMove2 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex2]];

            int move1Id = pokemonMove1.getId();
            int move2Id = pokemonMove2.getId();
#ifndef LITE_VERSION
            int move1VectorIndex = (move1Id - 1)/150;
            int move2VectorIndex = (move2Id - 1)/150;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : move1VectorIndex == 1 ? moves2 : move1VectorIndex == 2 ? moves3 : move1VectorIndex == 3 ? moves4 : moves5)[(move1Id - 1) % 150];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : move2VectorIndex == 1 ? moves2 : move2VectorIndex == 2 ? moves3 : move2VectorIndex == 3 ? moves4 : moves5)[(move2Id - 1) % 150];
#else
            int move1VectorIndex = (move1Id - 1)/400;
            int move2VectorIndex = (move2Id - 1)/400;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : moves2)[(move1Id - 1) % 400];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : moves2)[(move2Id - 1) % 400];
#endif

            int power1 = move1.getPower();
            int power2 = move2.getPower();
            return order == Qt::DescendingOrder ? power1 > power2 : power1 < power2;
        });
        break;
    case 3:
        std::sort(filteredPokemonMoves.begin(), filteredPokemonMoves.end(), [=](int pokemonMoveIndex1, int pokemonMoveIndex2)
        {
            const PokemonMove pokemonMove1 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex1]];
            const PokemonMove pokemonMove2 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex2]];

            int move1Id = pokemonMove1.getId();
            int move2Id = pokemonMove2.getId();
#ifndef LITE_VERSION
            int move1VectorIndex = (move1Id - 1)/150;
            int move2VectorIndex = (move2Id - 1)/150;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : move1VectorIndex == 1 ? moves2 : move1VectorIndex == 2 ? moves3 : move1VectorIndex == 3 ? moves4 : moves5)[(move1Id - 1) % 150];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : move2VectorIndex == 1 ? moves2 : move2VectorIndex == 2 ? moves3 : move2VectorIndex == 3 ? moves4 : moves5)[(move2Id - 1) % 150];
#else
            int move1VectorIndex = (move1Id - 1)/400;
            int move2VectorIndex = (move2Id - 1)/400;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : moves2)[(move1Id - 1) % 400];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : moves2)[(move2Id - 1) % 400];
#endif

            int accuracy1 = move1.getAccuracy();
            int accuracy2 = move2.getAccuracy();
            return order == Qt::DescendingOrder ? accuracy1 > accuracy2 : accuracy1 < accuracy2;
        });
        break;
    case 4:
        std::sort(filteredPokemonMoves.begin(), filteredPokemonMoves.end(), [=](int pokemonMoveIndex1, int pokemonMoveIndex2)
        {
            const PokemonMove pokemonMove1 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex1]];
            const PokemonMove pokemonMove2 = pokemonMoves[checkedPokemonMoves[pokemonMoveIndex2]];

            int move1Id = pokemonMove1.getId();
            int move2Id = pokemonMove2.getId();
#ifndef LITE_VERSION
            int move1VectorIndex = (move1Id - 1)/150;
            int move2VectorIndex = (move2Id - 1)/150;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : move1VectorIndex == 1 ? moves2 : move1VectorIndex == 2 ? moves3 : move1VectorIndex == 3 ? moves4 : moves5)[(move1Id - 1) % 150];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : move2VectorIndex == 1 ? moves2 : move2VectorIndex == 2 ? moves3 : move2VectorIndex == 3 ? moves4 : moves5)[(move2Id - 1) % 150];
#else
            int move1VectorIndex = (move1Id - 1)/400;
            int move2VectorIndex = (move2Id - 1)/400;
            const Move move1 = (move1VectorIndex == 0 ? moves1 : moves2)[(move1Id - 1) % 400];
            const Move move2 = (move2VectorIndex == 0 ? moves1 : moves2)[(move2Id - 1) % 400];
#endif

            int damageClass1 = move1.getDamageClass();
            int damageClass2 = move2.getDamageClass();
            return order == Qt::DescendingOrder ? damageClass1 > damageClass2 : damageClass1 < damageClass2;
        });
        break;
    default:
        break;
    }
}

void ModelPokemonMoves::checkPokemonMoves()
{
    checkedPokemonMoves.clear();
    QVector<int> tmpIds;
    for (int i = pokemonMoves.count() - 1; i >= 0; --i) {
        if (pokemonMoves[i].getVersionGroupId() <= currentVersionGroup && !tmpIds.contains(pokemonMoves[i].getId())) {
            tmpIds.append(pokemonMoves[i].getId());
            checkedPokemonMoves.append(i);
        }
    }
}

void ModelPokemonMoves::updateModelByFilter()
{
    beginResetModel();
    filteredPokemonMoves.clear();
    if (filter.isEmpty()) {
        disableFiltering();
        setFilterMatchs(true);
    } else {
        for (int i = 0; i < checkedPokemonMoves.count(); ++i) {
            int moveId = pokemonMoves[checkedPokemonMoves[i]].getId();
#ifndef LITE_VERSION
            int moveVectorIndex = (moveId - 1)/150;
            const Move move = (moveVectorIndex == 0 ? moves1 : moveVectorIndex == 1 ? moves2 : moveVectorIndex == 2 ? moves3 : moveVectorIndex == 3 ? moves4 : moves5)[(moveId - 1) % 150];
#else
            int moveVectorIndex = (moveId - 1)/400;
            const Move move = (moveVectorIndex == 0 ? moves1 : moves2)[(moveId - 1) % 400];
#endif

            const auto &names = move.getNames();
            bool match = (names.at(currentLanguage - 1).isEmpty() ? names.at(8) : names.at(currentLanguage - 1)).toLower().contains(filter.toLower());
            if (match) {
                filteredPokemonMoves.append(i);
            }
        }
        setFilterMatchs(filteredPokemonMoves.count() > 0);
        if (filteredPokemonMoves.count() == 0) {
            // Disabling filtering will show the whole model like it is not filter at all,
            // but `filterMatch` will be false anyway, indicating that the search failed
            // disableFiltering();
        }
    }
    sort(columnToSort, sortOrder);
    endResetModel();
}

void ModelPokemonMoves::disableFiltering()
{
    filteredPokemonMoves.clear();
    for (int i = 0; i < checkedPokemonMoves.count(); ++i) {
        filteredPokemonMoves.append(i);
    }
}

int ModelPokemonMoves::getCurrentVersionGroup() const
{
    return currentVersionGroup;
}

void ModelPokemonMoves::setCurrentVersionGroup(int value)
{
    if (currentVersionGroup != value) {
        currentVersionGroup = value;
        emit currentVersionGroupChanged(value);
    }
}

int ModelPokemonMoves::getCurrentLanguage() const
{
    return currentLanguage;
}

void ModelPokemonMoves::setCurrentLanguage(int value)
{
    if (currentLanguage != value) {
        currentLanguage = value;
        emit currentLanguageChanged(value);
        updateModelByFilter();
    }
}

QVector<PokemonMove> ModelPokemonMoves::getPokemonMoves() const
{
    return pokemonMoves;
}

void ModelPokemonMoves::setPokemonMoves(QVector<PokemonMove> value)
{
    beginResetModel();
    pokemonMoves = value;
    checkPokemonMoves();
    updateModelByFilter();
    endResetModel();
}

QString ModelPokemonMoves::getFilter() const
{
    return filter;
}

void ModelPokemonMoves::setFilter(const QString &value)
{
    if (filter != value) {
        filter = value;
        emit filterChanged(value);
        updateModelByFilter();
    }
}

bool ModelPokemonMoves::getFilterMatchs() const
{
    return filterMatchs;
}

void ModelPokemonMoves::setFilterMatchs(bool value)
{
    if (filterMatchs != value) {
        filterMatchs = value;
        emit filterMatchsChanged(value);
    }
}

Qt::SortOrder ModelPokemonMoves::getSortOrder() const
{
    return sortOrder;
}

void ModelPokemonMoves::setSortOrder(const Qt::SortOrder &value)
{
    if (sortOrder != value) {
        sortOrder = value;
        emit sortOrderChanged(value);
    }
}

int ModelPokemonMoves::getColumnToSort() const
{
    return columnToSort;
}

void ModelPokemonMoves::setColumnToSort(int value)
{
    if (columnToSort != value) {
        columnToSort = value;
        emit columnToSortChanged(value);
    }
}
