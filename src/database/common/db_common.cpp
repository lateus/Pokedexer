#include "db_common.h"

#include <QObject>

const QStringList typeNames = { QObject::tr("None"), QObject::tr("Normal"), QObject::tr("Fighting"), QObject::tr("Flying"), QObject::tr("Poison"), QObject::tr("Ground"), QObject::tr("Rock"), QObject::tr("Bug"), QObject::tr("Ghost"), QObject::tr("Steel"), QObject::tr("Fire"), QObject::tr("Water"), QObject::tr("Grass"), QObject::tr("Electric"), QObject::tr("Psychic"), QObject::tr("Ice"), QObject::tr("Dragon"), QObject::tr("Dark"), QObject::tr("Fairy") };

const QStringList statNames = { QObject::tr("None"), QObject::tr("Hit Points"), QObject::tr("Attack"), QObject::tr("Defense"), QObject::tr("Special Attack"), QObject::tr("Special Defense"), QObject::tr("Speed"), QObject::tr("Accuracy"), QObject::tr("Evasion") };
const QStringList statShortNames = { QObject::tr("None"), QObject::tr("HP"), QObject::tr("Atk"), QObject::tr("Def"), QObject::tr("Sp. Atk"), QObject::tr("Sp. Def"), QObject::tr("Spd"), QObject::tr("Acc"), QObject::tr("Evasion") };

const QStringList colorNames = { QObject::tr("None"), QObject::tr("Black"), QObject::tr("Blue"), QObject::tr("Brown"), QObject::tr("Gray"), QObject::tr("Green"), QObject::tr("Pink"), QObject::tr("Purple"), QObject::tr("Red"), QObject::tr("White"), QObject::tr("Yellow") };

const QStringList shapeNames = { QObject::tr("None"), QObject::tr("Ball"), QObject::tr("Squiggle"), QObject::tr("Fish"), QObject::tr("Arms"), QObject::tr("Blob"), QObject::tr("Upright"), QObject::tr("Legs"), QObject::tr("Quadruped"), QObject::tr("Wings"), QObject::tr("Tentacles"), QObject::tr("Heads"), QObject::tr("Humanoid"), QObject::tr("Bug Wings"), QObject::tr("Armor") };
const QStringList shapeAwesomeNames = { QObject::tr("None"), QObject::tr("Pomaceous"), QObject::tr("Caudal"), QObject::tr("Ichthyic"), QObject::tr("Brachial"), QObject::tr("Alvine"), QObject::tr("Sciurine"), QObject::tr("Crural"), QObject::tr("Mensal"), QObject::tr("Alar"), QObject::tr("Cilial"), QObject::tr("Polycephalic"), QObject::tr("Anthropomorphic"), QObject::tr("Lepidopterous"), QObject::tr("Chitinous") };

const QStringList flavorNames = { QObject::tr("None"), QObject::tr("Spicy"), QObject::tr("Dry"), QObject::tr("Sweet"), QObject::tr("Bitter"), QObject::tr("Sour") };

const QStringList eggGroupNames = { QObject::tr("None"), QObject::tr("Monster"), QObject::tr("Water 1"), QObject::tr("Bug"), QObject::tr("Flying"), QObject::tr("Field"), QObject::tr("Fairy"), QObject::tr("Grass"), QObject::tr("Human-Like"), QObject::tr("Water 3"), QObject::tr("Mineral"), QObject::tr("Amorphous"), QObject::tr("Water 2"), QObject::tr("Ditto"), QObject::tr("Dragon"), QObject::tr("Undiscovered") };

const QStringList moveLearnMethodNames = { QObject::tr("None"), QObject::tr("Level Up"), QObject::tr("Egg"), QObject::tr("Tutor"), QObject::tr("Machine"), QObject::tr("Pokémon Stadium: Surfing Pikachu"), QObject::tr("Light Ball Egg"), QObject::tr("Colosseum: Purification"), QObject::tr("XD: Shadow"), QObject::tr("XD: Purification"), QObject::tr("Form Change") };
const QStringList moveLearnMethodDescriptions = { QObject::tr("Cannot be learned."), QObject::tr("Learned when a Pokémon reaches a certain level."), QObject::tr("Appears on a newly-hatched Pokémon, if the father had the same move."), QObject::tr("Can be taught at any time by an NPC."), QObject::tr("Can be taught at any time by using a TM or HM."), QObject::tr("Learned when a non-rental Pikachu helps beat Prime Cup Master Ball R-2. It must participate in every battle, and you must win with no continues."), QObject::tr("Appears on a Pichu whose mother was holding a Light Ball. The father cannot be Ditto."), QObject::tr("Appears on a Shadow Pokémon as it becomes increasingly purified in Pokémon Colosseum."), QObject::tr("Appears on a Snatched Shadow Pokémon in Pokémon XD."), QObject::tr("Appears on a Shadow Pokémon as it becomes increasingly purified in Pokémon XD."), QObject::tr("Appears when Rotom or Cosplay Pikachu changes form. Disappears if the Pokémon becomes another form and this move cannot be learned in that form.") };

const QStringList typeEffectivenessNames = { QObject::tr("Inmune"), QObject::tr("Not very effective"), QObject::tr("Neutral"), QObject::tr("Super effective") };
const QStringList typeEffectivenessDescription = { QObject::tr("Damage is 0"), QObject::tr("Damage is halved"), QObject::tr("Damage is not increased nor decreased"), QObject::tr("Damage is doubled") };
const QVector<double> typeEffectivenessMultiplier = { 0, 0.5, 1, 2 };
