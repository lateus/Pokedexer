#ifndef DB_BERRIES_H
#define DB_BERRIES_H

#include <QVector>
#include <QString>
#include "../../global/berry/berry.h"

enum BerryEnum {
    Cheri = 1,
    Chesto,
    Pecha,
    Rawst,
    Aspear,
    Leppa,
    Oran,
    Persim,
    Lum,
    Sitrus,
    Figy,
    Wiki,
    Mago,
    Aguav,
    Iapapa,
    Razz,
    Bluk,
    Nanab,
    Wepear,
    Pinap,
    Pomeg,
    Kelpsy,
    Qualot,
    Hondew,
    Grepa,
    Tamato,
    Cornn,
    Magost,
    Rabuta,
    Nomel,
    Spelon,
    Pamtre,
    Watmel,
    Durin,
    Belue,
    Occa,
    Passho,
    Wacan,
    Rindo,
    Yache,
    Chople,
    Kebia,
    Shuca,
    Coba,
    Payapa,
    Tanga,
    Charti,
    Kasib,
    Haban,
    Colbur,
    Babiri,
    Chilan,
    Liechi,
    Ganlon,
    Salac,
    Petaya,
    Apicot,
    Lansat,
    Starf,
    Enigma,
    Micle,
    Custap,
    Jaboca,
    Rowap,
    Roseli,
    Kee,
    Maranga
};

enum BerryFirmnessEnum {
    NoneFirmness,
    VerySoft,
    Soft,
    Hard,
    VeryHard,
    SuperHard
};

enum BerryFlavorEnum {
    NoneFlavor,
    Spicy,
    Dry,
    Sweet,
    Bitter,
    Sour
};

extern const QVector<QVector<QString>> firmnessNames;
extern const QVector<Berry> berries;

#endif // DB_BERRIES_H
