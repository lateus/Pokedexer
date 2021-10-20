#include "statcalculator.h"

StatCalculator::StatCalculator(QObject *parent) : QObject(parent)
{

}

int StatCalculator::calculateStat(int generation, int stat, int base, int iv, int ev, int level, int natureSigness)
{
    if (stat <= NoneStat || stat > Speed) {
        return -1;
    }

    if (generation <= 2) {
        if (stat == Hp) {
            return qFloor(((((base + iv) * 2 + qSqrt(ev)/4) * level)/100) + level + 10);
        } else {
            return qFloor(((((base + iv) * 2 + qSqrt(ev)/4) * level)/100) + 5);
        }
    } else {
        if (stat == Hp) {
            return base == 1 ? 1 : qFloor((((2*base + iv + ev/4) * level)/100) + level + 10); // base == 1 assumes Shedinja
        } else {
            double natureBonus = natureSigness > 0 ? 1.1 : natureSigness < 0 ? 0.9 : 1;
            return qFloor(((((2*base + iv + ev/4) * level)/100) + 5) * natureBonus);
        }
    }
}
