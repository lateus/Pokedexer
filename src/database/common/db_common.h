#ifndef DB_COMMON_H
#define DB_COMMON_H

#include <QStringList>

enum StatEnum {
    NoneStat,
    Hp,
    Attack,
    Defense,
    SpecialAttack,
    SpecialDefense,
    Speed,
    Accuracy,
    Evasion
};

enum ColorEnum {
    NoneColor,
    BlackColor,
    BlueColor,
    BrownColor,
    GrayColor,
    GreenColor,
    PinkColor,
    PurpleColor,
    RedColor,
    WhiteColor,
    YellowColor
};

enum ShapeEnum {
    NoneShape,
    BallShape,
    SquiggleShape,
    FishShape,
    ArmsShape,
    BlobShape,
    UprightShape,
    LegsShape,
    QuadrupedShape,
    WingsShape,
    TentaclesShape,
    HeadsShape,
    HumanoidShape,
    BugWingsShape,
    ArmorShape
};

enum EggGroupEnum {
    NoneEggGroup,
    MonsterEggGroup,
    Water1EggGroup,
    BugEggGroup,
    FlyingEggGroup,
    GroundEggGroup,
    FairyEggGroup,
    PlantEggGroup,
    HumanShapeEggGroup,
    Water3EggGroup,
    MineralEggGroup,
    IndeterminateEggGroup,
    Water2EggGroup,
    DittoEggGroup,
    DragonEggGroup,
    NoEggsEggGroup
};

enum MoveLearnMethodEnum {
    NoneLearnMethod,
    LevelUpLearnMethod,
    EggLearnMethod,
    TutorLearnMethod,
    MachineLearnMethod,
    StadiumSurfingPikachuLearnMethod,
    LightBallEggLearnMethod,
    ColosseumPurificationLearnMethod,
    XdShadowLearnMethod,
    XdPurificationLearnMethod,
    FormChangeLearnMethod
};

enum TypeEffectivenessEnum {
    Inmune,
    NotVeryEffective,
    Neutral,
    SuperEffective,
};

enum GenderEnum {
    Genderless,
    Male,
    Female
};

enum GenderRate {
    FemaleZeroOfEight,  // 100.0% M -   0.0% F
    FemaleOneOfEight,   //  87.5% M -  12.5% F
    FemaleTwoOfEight,   //  75.0% M -  25.0% F
    FemaleThreeOfEight, //  62.5% M -  37.5% F (no one until now has this rate)
    FemaleFourOfEight,  //  50.0% M -  50.0% F
    FemaleFiveOfEight,  //  37.5% M -  62.5% F (no one until now has this rate)
    FemaleSixOfEight,   //  75.0% M -  25.0% F
    FemaleSevenOfEight, //  12.5% M -  87.5% F
    FemaleEightOfEight, //   0.0% M - 100.0% F
    NeverFemaleNorMale = 0xFF  //   0.0% M -   0.0% F (equivalent to genderless)
};

extern const QStringList typeNames;

extern const QStringList statNames;
extern const QStringList statShortNames;

extern const QStringList colorNames;

extern const QStringList shapeNames;
extern const QStringList shapeAwesomeNames;

extern const QStringList flavorNames;

extern const QStringList eggGroupNames;

extern const QStringList moveLearnMethodNames;
extern const QStringList moveLearnMethodDescriptions;

extern const QStringList typeEffectivenessNames;
extern const QStringList typeEffectivenessDescription;
extern const QVector<double> typeEffectivenessMultiplier;

#endif // DB_COMMON_H
