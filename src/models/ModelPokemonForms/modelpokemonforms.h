#ifndef MODELPOKEMONFORMS_H
#define MODELPOKEMONFORMS_H

#include <QAbstractListModel>
#include <QtQml>
#include "../../global/pokemonform/pokemonform.h"

class ModelPokemonForms : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("To internal use of ModelPokemon.")

    Q_PROPERTY(int currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(int currentVersionGroup READ getCurrentVersionGroup WRITE setCurrentVersionGroup NOTIFY currentVersionGroupChanged)
    Q_PROPERTY(bool hasMega READ getHasMega NOTIFY hasMegaChanged)

public:
    enum Roles { IdRole = Qt::UserRole + 1, VersionGroupRole, PokemonIdRole, OrderRole, IsDefaultRole, IsBattleOnlyRole, IsMegaRole, NameRole };
    Q_ENUM(Roles)
    explicit ModelPokemonForms(const QVector<PokemonForm> &pkmnForms = {}, QObject *parent = nullptr);

    int getCurrentLanguage() const;
    void setCurrentLanguage(int value);

    int getCurrentVersionGroup() const;
    void setCurrentVersionGroup(int value);

    QVector<PokemonForm> getPokemonForms() const;
    void setPokemonForms(QVector<PokemonForm> value);

    bool getHasMega() const;

protected:
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    QVariant getPokemonFormData(int pokemonFormId, int role) const;

signals:
    void currentLanguageChanged(int value);
    void currentVersionGroupChanged(int value);
    void hasMegaChanged(bool value);

private:
    int currentLanguage = 7; // ES spanish
    int currentVersionGroup = 18; // ultra sun - ultra moon

    QVector<PokemonForm> pokemonForms;
    bool hasMega = false;

    void updateMegaStatus();
};

#endif // MODELPOKEMONFORM_H
