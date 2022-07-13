import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

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
    property string nickname

    Connections {
        target: applicationWindow

        function onApplicationLanguageIdChanged() {
            if (pokemonId > 0) {
                labelPokemonName.text  = nickname && nickname !== modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole) ? "<b>" + nickname + "</b> (" + modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole) + ")" : "<b>" + modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole) + "</b>"
                labelPokemonItem.text  = itemId  === 0 ? labelPokemonItem.text  : modelItems.getItemData(itemId, Backend.ModelItems.NameRole)
                labelPokemonMove1.text = move1Id === 0 ? labelPokemonMove1.text : modelMoves.getMoveData(move1Id, Backend.ModelMoves.NameRole)
                labelPokemonMove2.text = move2Id === 0 ? labelPokemonMove2.text : modelMoves.getMoveData(move2Id, Backend.ModelMoves.NameRole)
                labelPokemonMove3.text = move3Id === 0 ? labelPokemonMove3.text : modelMoves.getMoveData(move3Id, Backend.ModelMoves.NameRole)
                labelPokemonMove4.text = move4Id === 0 ? labelPokemonMove4.text : modelMoves.getMoveData(move4Id, Backend.ModelMoves.NameRole)
            }
        }
    }

    topInset: -8
    bottomInset: -8

    Image {
        id: imagePokemon

        width: height
        height: parent.height

        source: "qrc:/images/sprites/pokemon/3ds/" + (shiny ? "shiny/" : "normal/") + speciesId + (speciesId === 0 ? "" : "-" + (formId >= modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.FormsCountRole) ? 1 : formId + 1)) + ".png"
        sourceSize: Qt.size(height, height)

        ToolButton {
            id: toolButtonIconShiny
            x: parent.width - width
            y: 4
            height: ~~(labelPokemonNature.height/1.5)
            width: height
            padding: 0
            topInset: 0
            bottomInset: 0
            leftInset: 0
            rightInset: 0

            visible: shiny
            enabled: false
            icon.source: "qrc:/images/icons/toggle/star_on.svg"
            icon.width: width
            icon.height: height
            icon.color: Material.accentColor
            Material.accent: Material.Amber
        }
    }

    Label {
        id: labelPokemonName

        x: imagePokemon.x + imagePokemon.width + 5
        y: imagePokemon.y

        enabled: pokemonId > 0
        text: pokemonId === 0 ? "<b>" + qsTr("MissingNo") + "</b>" : nickname && nickname !== modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole) ? "<b>" + nickname + "</b> (" + modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole) + ")" : "<b>" + modelPokemon.getPokemonData(pokemonId, Backend.ModelPokemon.NameRole) + "</b>"
    }

    Label {
        id: labelPokemonNature

        x: labelPokemonName.x
        y: labelPokemonName.y + labelPokemonName.height
        leftPadding: toolButtonIconNature.width

        enabled: labelPokemonName.enabled
        text: qsTr("%1 nature").arg(natureId === 0 ? qsTr("???") : modelNatures.getNatureData(natureId, Backend.ModelNatures.NameRole))
        font.italic: true

        ToolButton {
            id: toolButtonIconNature
            y: ~~((parent.height - height)/2)
            height: parent.height
            width: height
            padding: 0
            topInset: 0
            bottomInset: 0
            leftInset: 0
            rightInset: 0

            enabled: false
            icon.source: "qrc:/images/icons/arrows/up_down.svg"
            icon.width: width
            icon.height: height
            icon.color: labelPokemonNature.color
        }
    }

    Label {
        id: labelPokemonItem

        x: labelPokemonNature.x
        y: parent.height - height - 2
        leftPadding: toolButtonIconItem.width

        enabled: labelPokemonName.enabled
        text: itemId === 0 ? qsTr("No item") : modelItems.getItemData(itemId, Backend.ModelItems.NameRole)
        font.italic: true

        ToolButton {
            id: toolButtonIconItem
            y: ~~((parent.height - height)/2)
            height: parent.height
            width: height
            padding: 0
            topInset: 0
            bottomInset: 0
            leftInset: 0
            rightInset: 0

            enabled: false
            icon.source: "qrc:/images/icons/menu/item.svg"
            icon.width: width
            icon.height: height
            icon.color: labelPokemonItem.color
        }
    }

    // Moves
    Label {
        id: labelPokemonMove1

        x: parent.width - 80

        enabled: labelPokemonName.enabled
        text: move1Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move1Id, Backend.ModelMoves.NameRole)
        font.pixelSize: 10
    }

    Label {
        id: labelPokemonMove2

        x: labelPokemonMove1.x
        y: labelPokemonMove1.y + labelPokemonMove1.height + 2

        enabled: labelPokemonName.enabled
        text: move2Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move2Id, Backend.ModelMoves.NameRole)
        font.pixelSize: labelPokemonMove1.font.pixelSize
    }

    Label {
        id: labelPokemonMove3

        x: labelPokemonMove1.x
        y: labelPokemonMove2.y + labelPokemonMove2.height + 2

        enabled: labelPokemonName.enabled
        text: move3Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move3Id, Backend.ModelMoves.NameRole)
        font.pixelSize: labelPokemonMove1.font.pixelSize
    }

    Label {
        id: labelPokemonMove4

        x: labelPokemonMove1.x
        y: labelPokemonMove3.y + labelPokemonMove3.height + 2

        enabled: labelPokemonName.enabled
        text: move4Id === 0 ? qsTr("(None)") : modelMoves.getMoveData(move4Id, Backend.ModelMoves.NameRole)
        font.pixelSize: labelPokemonMove1.font.pixelSize
    }
}
