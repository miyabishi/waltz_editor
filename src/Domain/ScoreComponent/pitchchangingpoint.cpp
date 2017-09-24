#include "pitchchangingpoint.h"

using namespace waltz::editor::ScoreComponent;

PitchChangingPoint::PitchChangingPoint(const int aX,
                                       const int aY,
                                       const PitchCurveControlPointPointer aControlPoint)
    : Point(aX, aY)
    , mControlPoint_(aControlPoint)
{

}

PitchCurveControlPointPointer PitchChangingPoint::controlPoint() const
{
    return mControlPoint_;
}

