import QtQuick 2.15
import QtQuick.Controls 2.15

import Pokedexer 1.0 as Backend


ItemDelegate {
    id: itemDelegatePokemon

    property int pokemonId: 0
    readonly property int speciesId: pokemonId > 0 ? modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.SpeciesIdRole) : 0
    property int formId: 0
    property int natureId: 0
    property int itemId: 0
    property bool shiny: false
    property int move1Id: 0
    property int move2Id: 0
    property int move3Id: 0
    property int move4Id: 0

    topInset: -8
    bottomInset: -8

    Image {
        id: imagePokemon

        width: height
        height: parent.height

        source: "qrc:/images/sprites/pokemon/3ds/" + (shiny ? "shiny/" : "normal/") + speciesId + (speciesId === 0 ? "" : "-" + (formId >= modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.FormsCountRole) ? 1 : formId + 1)) + ".png"
        sourceSize: Qt.size(height, height)
    }

    Label {
        id: labelPokemonName

        x: imagePokemon.x + imagePokemon.width + 5
        y: imagePokemon.y

        text: pokemonId === 0 ? qsTr("MissingNo") : modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole)
        font.bold: true
    }

    Label {
        id: labelPokemonNature

        x: labelPokemonName.x
        y: labelPokemonName.y + labelPokemonName.height + 2

        text: qsTr("%1 nature").arg(natureId === 0 ? qsTr("???") : modelNatures.getNatureData(natureId, Backend.ModelNatures.NameRole))
        font.italic: true
    }

    Label {
        id: labelPokemonItem

        x: labelPokemonNature.x
        y: parent.height - height - 2

        text: itemId === 0 ? qsTr("No item") : modelItems.getItemData(itemId, Backend.ModelItems.NameRole)
        font.italic: true
    }

    // Moves
    Label {
        id: labelPokemonMove1

        x: parent.width - 80

        text: move1Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move1Id, Backend.ModelMoves.NameRole)
        font.pixelSize: 10
    }

    Label {
        id: labelPokemonMove2

        x: labelPokemonMove1.x
        y: labelPokemonMove1.y + labelPokemonMove1.height + 2

        text: move2Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move2Id, Backend.ModelMoves.NameRole)
        font.pixelSize: labelPokemonMove1.font.pixelSize
    }

    Label {
        id: labelPokemonMove3

        x: labelPokemonMove1.x
        y: labelPokemonMove2.y + labelPokemonMove2.height + 2

        text: move3Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move3Id, Backend.ModelMoves.NameRole)
        font.pixelSize: labelPokemonMove1.font.pixelSize
    }

    Label {
        id: labelPokemonMove4

        x: labelPokemonMove1.x
        y: labelPokemonMove3.y + labelPokemonMove3.height + 2

        text: move4Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move4Id, Backend.ModelMoves.NameRole)
        font.pixelSize: labelPokemonMove1.font.pixelSize
    }
}
