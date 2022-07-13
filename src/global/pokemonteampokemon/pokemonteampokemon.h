#ifndef POKEMONTEAMPOKEMON_H
#define POKEMONTEAMPOKEMON_H

#include <QObject>
#include <QtQml>

#include "../../../database/common/db_common.h"

class PokemonTeamPokemon : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int pokemonId READ getPokemonId WRITE setPokemonId NOTIFY pokemonIdChanged)
    Q_PROPERTY(int formId READ getFormId WRITE setFormId NOTIFY formIdChanged)
    Q_PROPERTY(int genderId READ getGenderId WRITE setGenderId NOTIFY genderIdChanged)
    Q_PROPERTY(bool shiny READ getShiny WRITE setShiny NOTIFY shinyChanged)
    Q_PROPERTY(QString nickname READ getNickname WRITE setNickname NOTIFY nicknameChanged)

    Q_PROPERTY(int abilityId READ getAbilityId WRITE setAbilityId NOTIFY abilityIdChanged)

    Q_PROPERTY(int level READ getLevel WRITE setLevel NOTIFY levelChanged)
    Q_PROPERTY(int natureId READ getNatureId WRITE setNatureId NOTIFY natureIdChanged)
    Q_PROPERTY(int ivHp READ getIvHp WRITE setIvHp NOTIFY ivHpChanged)
    Q_PROPERTY(int ivAtk READ getIvAtk WRITE setIvAtk NOTIFY ivAtkChanged)
    Q_PROPERTY(int ivDef READ getIvDef WRITE setIvDef NOTIFY ivDefChanged)
    Q_PROPERTY(int ivSpAtk READ getIvSpAtk WRITE setIvSpAtk NOTIFY ivSpAtkChanged)
    Q_PROPERTY(int ivSpDef READ getIvSpDef WRITE setIvSpDef NOTIFY ivSpDefChanged)
    Q_PROPERTY(int ivSpd READ getIvSpd WRITE setIvSpd NOTIFY ivSpdChanged)
    Q_PROPERTY(int evHp READ getEvHp WRITE setEvHp NOTIFY ivHpChanged)
    Q_PROPERTY(int evAtk READ getEvAtk WRITE setEvAtk NOTIFY evAtkChanged)
    Q_PROPERTY(int evDef READ getEvDef WRITE setEvDef NOTIFY evDefChanged)
    Q_PROPERTY(int evSpAtk READ getEvSpAtk WRITE setEvSpAtk NOTIFY evSpAtkChanged)
    Q_PROPERTY(int evSpDef READ getEvSpDef WRITE setEvSpDef NOTIFY evSpDefChanged)
    Q_PROPERTY(int evSpd READ getEvSpd WRITE setEvSpd NOTIFY evSpdChanged)

    Q_PROPERTY(int itemId READ getItemId WRITE setItemId NOTIFY itemIdChanged)

    Q_PROPERTY(int move1Id READ getMove1Id WRITE setMove1Id NOTIFY move1IdChanged)
    Q_PROPERTY(int move2Id READ getMove2Id WRITE setMove2Id NOTIFY move2IdChanged)
    Q_PROPERTY(int move3Id READ getMove3Id WRITE setMove3Id NOTIFY move3IdChanged)
    Q_PROPERTY(int move4Id READ getMove4Id WRITE setMove4Id NOTIFY move4IdChanged)

public:
    explicit PokemonTeamPokemon(QObject *parent = nullptr);

    int getPokemonId() const;
    void setPokemonId(int value);

    int getFormId() const;
    void setFormId(int value);

    int getGenderId() const;
    void setGenderId(int value);

    bool getShiny() const;
    void setShiny(bool value);

    QString getNickname() const;
    void setNickname(const QString &value);

    int getAbilityId() const;
    void setAbilityId(int value);

    int getLevel() const;
    void setLevel(int value);

    int getNatureId() const;
    void setNatureId(int value);

    int getIvHp() const;
    void setIvHp(int value);

    int getIvAtk() const;
    void setIvAtk(int value);

    int getIvDef() const;
    void setIvDef(int value);

    int getIvSpAtk() const;
    void setIvSpAtk(int value);

    int getIvSpDef() const;
    void setIvSpDef(int value);

    int getIvSpd() const;
    void setIvSpd(int value);

    int getEvHp() const;
    void setEvHp(int value);

    int getEvAtk() const;
    void setEvAtk(int value);

    int getEvDef() const;
    void setEvDef(int value);

    int getEvSpAtk() const;
    void setEvSpAtk(int value);

    int getEvSpDef() const;
    void setEvSpDef(int value);

    int getEvSpd() const;
    void setEvSpd(int value);

    int getItemId() const;
    void setItemId(int value);

    int getMove1Id() const;
    void setMove1Id(int value);

    int getMove2Id() const;
    void setMove2Id(int value);

    int getMove3Id() const;
    void setMove3Id(int value);

    int getMove4Id() const;
    void setMove4Id(int value);

    bool operator==(const PokemonTeamPokemon &pokemonTeamPokemonToCompare) const;
    bool operator!=(const PokemonTeamPokemon &pokemonTeamPokemonToCompare) const;

    // Related non-members
    friend QDataStream &operator<<(QDataStream &stream, const PokemonTeamPokemon &pokemonTeamPokemon);
    friend QDataStream &operator>>(QDataStream &stream, PokemonTeamPokemon &pokemonTeamPokemon);

signals:
    void pokemonIdChanged(int value);
    void formIdChanged(int value);
    void genderIdChanged(int value);
    void shinyChanged(bool value);
    void nicknameChanged(const QString &value);

    void abilityIdChanged(int value);

    void levelChanged(int value);
    void natureIdChanged(int value);
    void ivHpChanged(int value);
    void ivAtkChanged(int value);
    void ivDefChanged(int value);
    void ivSpAtkChanged(int value);
    void ivSpDefChanged(int value);
    void ivSpdChanged(int value);
    void evHpChanged(int value);
    void evAtkChanged(int value);
    void evDefChanged(int value);
    void evSpAtkChanged(int value);
    void evSpDefChanged(int value);
    void evSpdChanged(int value);

    void itemIdChanged(int value);
    void move1IdChanged(int value);
    void move2IdChanged(int value);
    void move3IdChanged(int value);
    void move4IdChanged(int value);

private:
    int pokemonId = 0;
    int formId = 0;
    int genderId = 0;
    bool shiny = false;
    QString nickname;

    int abilityId = 0;

    int level = 50;
    int natureId = 1;
    int ivHp = 31;
    int ivAtk = 31;
    int ivDef = 31;
    int ivSpAtk = 31;
    int ivSpDef = 31;
    int ivSpd = 31;
    int evHp = 0;
    int evAtk = 0;
    int evDef = 0;
    int evSpAtk = 0;
    int evSpDef = 0;
    int evSpd = 0;

    int itemId = 0;
    int move1Id = 0;
    int move2Id = 0;
    int move3Id = 0;
    int move4Id = 0;
};

#endif // POKEMONTEAMPOKEMON_H
