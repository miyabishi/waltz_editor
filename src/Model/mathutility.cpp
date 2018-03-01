#include <QtMath>

#include "mathutility.h"

using namespace waltz::editor::model;

MathUtility::MathUtility(QObject* aParent)
    :QObject(aParent)
{
}

int MathUtility::floor(double aX) const
{
    return qFloor(aX);
}

int MathUtility::ceil(double aX) const
{
    return qCeil(aX);
}
