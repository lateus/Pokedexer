QT += quick svg

#android {
#    QT += androidextras
#}

CONFIG += c++11 qmltypes

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Lite version have a smaller database in order to make it more oriented to mobile devices.
# Comment the line bellow if you are building for desktop.
CONFIG += lite
lite {
    DEFINES += LITE_VERSION
}

INCLUDEPATH += \
    src/utils \
    src/core/StatCalculator \
    src/models/ModelAbilities \
    src/models/ModelBerries \
    src/models/ModelItems \
    src/models/ModelMoves \
    src/models/ModelTypes \
    src/models/ModelTypes/ModelTypeChart \
    src/models/ModelNatures \
    src/models/ModelNatures/ModelNatureChart \
    src/models/ModelPokemon \
    src/models/ModelPokemonForms \
    src/models/ModelPokemonMoves \
    src/models/ModelPokemonTeams \
    src/models/ModelPokemonInTeam \
    src/global/pokemonteam \
    src/global/pokemonteampokemon

HEADERS += \
    src/utils/utils.h \
    src/core/StatCalculator/statcalculator.h \
    src/global/ability/ability.h \
    src/global/berry/berry.h \
    src/global/item/item.h \
    src/global/move/move.h \
    src/global/nature/nature.h \
    src/global/pokemon/pokemon.h \
    src/global/pokemonform/pokemonform.h \
    src/global/pokemonmove/pokemonmove.h \
#    src/global/pokemonteam/pokemonteam.h \
    src/global/pokemonteampokemon/pokemonteampokemon.h \
    src/global/type/type.h \
    src/models/ModelAbilities/modelabilities.h \
    src/models/ModelBerries/modelberries.h \
    src/models/ModelItems/modelitems.h \
    src/models/ModelMoves/modelmoves.h \
    src/models/ModelNatures/modelnatures.h \
    src/models/ModelNatures/ModelNatureChart/modelnaturechart.h \
    src/models/ModelPokemon/modelpokemon.h \
    src/models/ModelPokemonForms/modelpokemonforms.h \
    src/models/ModelPokemonMoves/modelpokemonmoves.h \
    src/models/ModelTypes/ModelTypeChart/modeltypechart.h \
    src/models/ModelTypes/modeltypes.h \
    src/models/ModelPokemonTeams/modelpokemonteams.h \
    src/models/ModelPokemonInTeam/modelpokemoninteam.h \
    src/database/common/db_common.h \
    src/database/abilities/db_abilities.h \
    src/database/berries/db_berries.h \
    src/database/items/db_items.h \
    src/database/moves/db_moves.h \
    src/database/natures/db_natures.h \
    src/database/pokemon/db_pokemon.h \
    src/database/types/db_types.h

SOURCES += \
    src/main.cpp \
    src/utils/utils.cpp \
    src/core/StatCalculator/statcalculator.cpp \
    src/global/ability/ability.cpp \
    src/global/berry/berry.cpp \
    src/global/item/item.cpp \
    src/global/move/move.cpp \
    src/global/nature/nature.cpp \
    src/global/pokemon/pokemon.cpp \
    src/global/pokemonform/pokemonform.cpp \
    src/global/pokemonmove/pokemonmove.cpp \
#    src/global/pokemonteam/pokemonteam.cpp \
    src/global/pokemonteampokemon/pokemonteampokemon.cpp \
    src/global/type/type.cpp \
    src/models/ModelAbilities/modelabilities.cpp \
    src/models/ModelBerries/modelberries.cpp \
    src/models/ModelItems/modelitems.cpp \
    src/models/ModelMoves/modelmoves.cpp \
    src/models/ModelNatures/modelnatures.cpp \
    src/models/ModelNatures/ModelNatureChart/modelnaturechart.cpp \
    src/models/ModelPokemon/modelpokemon.cpp \
    src/models/ModelPokemonForms/modelpokemonforms.cpp \
    src/models/ModelPokemonMoves/modelpokemonmoves.cpp \
    src/models/ModelTypes/ModelTypeChart/modeltypechart.cpp \
    src/models/ModelTypes/modeltypes.cpp \
    src/models/ModelPokemonTeams/modelpokemonteams.cpp \
    src/models/ModelPokemonInTeam/modelpokemoninteam.cpp \
    src/database/common/db_common.cpp \
    src/database/natures/db_natures.cpp \
    src/database/pokemon/db_pokemon1.cpp \
    src/database/pokemon/db_pokemon2.cpp \
    src/database/pokemon/db_pokemon3.cpp \
    src/database/pokemon/db_pokemon4.cpp \
    src/database/pokemon/db_pokemon5.cpp \
    src/database/pokemon/db_pokemon6.cpp \
    src/database/pokemon/db_pokemon7.cpp \
    src/database/pokemon/db_pokemon8.cpp \
    src/database/pokemon/db_pokemon9.cpp \
    src/database/pokemon/db_pokemon10.cpp \
    src/database/pokemon/db_pokemon11.cpp \
    src/database/pokemon/db_pokemon12.cpp \
    src/database/pokemon/db_pokemon13.cpp \
    src/database/pokemon/db_pokemon14.cpp \
    src/database/pokemon/db_pokemon15.cpp \
    src/database/pokemon/db_pokemon16.cpp \
    src/database/pokemon/db_pokemon17.cpp \
    src/database/pokemon/db_pokemon18.cpp \
    src/database/pokemon/db_pokemon19.cpp \
    src/database/pokemon/db_pokemon20.cpp \
    src/database/pokemon/db_pokemon21.cpp \
    src/database/pokemon/db_pokemon22.cpp \
    src/database/pokemon/db_pokemon23.cpp \
    src/database/pokemon/db_pokemon24.cpp \
    src/database/pokemon/db_pokemon25.cpp \
    src/database/pokemon/db_pokemon26.cpp \
    src/database/pokemon/db_pokemon27.cpp \
    src/database/pokemon/db_pokemon28.cpp \
    src/database/pokemon/db_pokemon29.cpp \
    src/database/pokemon/db_pokemon30.cpp \
    src/database/pokemon/db_pokemon31.cpp \
    src/database/pokemon/db_pokemon32.cpp \
    src/database/pokemon/db_pokemon33.cpp \
    src/database/pokemon/db_pokemon34.cpp \
    src/database/pokemon/db_pokemon35.cpp \
    src/database/pokemon/db_pokemon36.cpp \
    src/database/pokemon/db_pokemon37.cpp \
    src/database/pokemon/db_pokemon38.cpp \
    src/database/pokemon/db_pokemon39.cpp \
    src/database/types/db_types.cpp

lite {
    SOURCES += \
        src/database/abilities/db_abilities_lite.cpp \
        src/database/berries/db_berries_lite.cpp \
        src/database/items/db_items1_lite.cpp \
        src/database/items/db_items2_lite.cpp \
        src/database/moves/db_moves1_lite.cpp \
        src/database/moves/db_moves2_lite.cpp
}

!lite {
    SOURCES += \
        src/database/abilities/db_abilities.cpp \
        src/database/berries/db_berries.cpp \
        src/database/items/db_items1.cpp \
        src/database/items/db_items2.cpp \
        src/database/items/db_items3.cpp \
        src/database/items/db_items4.cpp \
        src/database/items/db_items5.cpp \
        src/database/moves/db_moves1.cpp \
        src/database/moves/db_moves2.cpp \
        src/database/moves/db_moves3.cpp \
        src/database/moves/db_moves4.cpp \
        src/database/moves/db_moves5.cpp
}

RESOURCES += \
    resources/images/icons.qrc \
    resources/images/sprites/berries.qrc \
    resources/images/sprites/items.qrc \
    resources/images/sprites/pokemon-icons/3ds/normal-icons.qrc \
    resources/images/sprites/pokemon/3ds/normal.qrc \
    resources/images/sprites/pokemon/3ds/shiny.qrc \
    resources/images/sprites/types.qrc \
    # resources/sounds/sounds.qrc \ # needs multimedia module (QT += multimedia) if used
    resources/fonts/fonts.qrc \
    # resources/translations/translations.qrc \
    resources/qt/qt.qrc \
    src/ui/ui.qrc

RC_FILE = resources/platforms/windows/resManifest.rc

QML_IMPORT_NAME = Pokedexer
QML_IMPORT_MAJOR_VERSION = 1

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

OTHER_FILES += \
    TODO.md

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
