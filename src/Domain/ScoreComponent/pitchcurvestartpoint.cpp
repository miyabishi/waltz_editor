#include "pitchcurvestartpoint.h"

using namespace waltz::editor::ScoreComponent;

PitchCurveStartPoint::PitchCurveStartPoint(int aX, int aY,
                                           const PitchCurveControlPointPointer aControlPoint)
    : Point(aX, aY)
    , mControlPoint_(aControlPoint)
{
}

PitchCurveControlPointPointer PitchCurveStartPoint::controlPoint() const
{
    return mControlPoint_;
}

