#include "point.h"

using namespace waltz::editor::ScoreComponent;

Point::Point(int aX, int aY)
    : mX_(aX)
    , mY_(aY)
{
}

Point::~Point()
{
}

int Point::x() const
{
    return mX_;
}

int Point::y() const
{
    return mY_;
}

QPoint Point::toQPoint() const
{
    return QPoint(mX_, mY_);
}
