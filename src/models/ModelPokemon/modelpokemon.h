#ifndef MODELPOKEMON_H
#define MODELPOKEMON_H

#include <QAbstractListModel>
#include <QtQml>
#include "../ModelPokemonForms/modelpokemonforms.h"
#include "../ModelPokemonMoves/modelpokemonmoves.h"
#include "../../database/types/db_types.h"

class ModelPokemon : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(bool speciesOnly READ getSpeciesOnly WRITE setSpeciesOnly NOTIFY speciesOnlyChanged)
    Q_PROPERTY(QString filter READ getFilter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(bool filterMatchs READ getFilterMatchs NOTIFY filterMatchsChanged)
    Q_PROPERTY(int filterType READ getFilterType WRITE setFilterType NOTIFY filterTypeChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, SpeciesIdRole, GenerationRole, IsDefaultRole, OrderRole, GenderRateIdRole, CaptureRateRole, BaseHappinessRole, IsBabyRole, HatchCounterRole, HasGenderDifferencesRole, FormsSwitchableRole, GrowthRateIdRole, NameRole, GenusNameRole, SpeciesDescriptionRole, SpeciesFlavorTextRole, PrimaryTypeRole, SecondaryTypeRole, HeightRole, WeightRole, BaseExperienceRole, BaseStatsRole, PrimaryAbilityRole, SecondaryAbilityRole, HiddenAbilityRole, ColorRole, ShapeRole, PrimaryEggGroupRole, SecondaryEggGroupRole, EvolutionChainIdRole, MovesRole, FormsCountRole, FormsRole };
    Q_ENUM(Roles)
    explicit ModelPokemon(QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    QString getFilter() const;
    void setFilter(const QString &value);

    bool getFilterMatchs() const;
    void setFilterMatchs(bool value);

    bool getSpeciesOnly() const;
    void setSpeciesOnly(bool value);

    int getFilterType() const;
    void setFilterType(int value);

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    QVariant getPokemonData(int pokemonId, int role) const;

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void speciesOnlyChanged(bool value);
    void filterChanged(QString value);
    void filterMatchsChanged(bool value);
    void filterTypeChanged(int value);

private:
    int currentLanguage = 9; // EN english
    int currentVersionGroup = 18; // ultra sun - ultra moon
    bool speciesOnly = true;

    // filtering
    QVector<int> filteredPokemon;
    QString filter;
    bool filterMatchs = true;

    int filterType = NoneType;

    // ModelPokemonForms *modelPokemonForms = new ModelPokemonForms;
    // ModelPokemonMoves *modelPokemonMoves = new ModelPokemonMoves;

    void updateModelByFilter();
    void disableFiltering();
};

#endif // MODELPOKEMON_H
