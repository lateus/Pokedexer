#ifndef POKEMONFORM_H
#define POKEMONFORM_H

#include <QVector>
#include <QString>

class PokemonForm
{
public:
    PokemonForm(int formId, int versionGroup, int pkmnId, int formOrder, bool formIsDefault, bool formIsBattleOnly, bool formIsMega, const QVector<QString> &formNames);

    int getId() const;
    int getVersionGroupId() const;
    int getPokemonId() const;
    int getOrder() const;
    bool getIsDefault() const;
    bool getIsBattleOnly() const;
    bool getIsMega() const;
    QVector<QString> getNames() const;

private:
    const int id;
    const int versionGroupId;
    const int pokemonId;
    const int order;
    const bool isDefault;
    const bool isBattleOnly;
    const bool isMega;
    const QVector<QString> names;
};

#endif // POKEMONFORM_H
