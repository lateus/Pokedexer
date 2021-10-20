#include "nature.h"

Nature::Nature(int natureId, const QString &natureName, int natureStatUp, int natureStatDown, int natureFlavorUp, int natureFlavorDown, bool natureIsNeutral)
    : id(natureId), name(natureName), statUp(natureStatUp), statDown(natureStatDown), flavorUp(natureFlavorUp), flavorDown(natureFlavorDown), isNeutral(natureIsNeutral)
{

}

int Nature::getId() const
{
    return id;
}

QString Nature::getName() const
{
    return name;
}

int Nature::getStatUp() const
{
    return statUp;
}

int Nature::getStatDown() const
{
    return statDown;
}

int Nature::getFlavorUp() const
{
    return flavorUp;
}

int Nature::getFlavorDown() const
{
    return flavorDown;
}

bool Nature::getIsNeutral() const
{
    return isNeutral;
}
