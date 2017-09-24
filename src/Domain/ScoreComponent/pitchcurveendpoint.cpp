#include "pitchcurveendpoint.h"

using namespace waltz::editor::ScoreComponent;

PitchCurveEndPoint::PitchCurveEndPoint(int aX, int aY,
                                       const PitchCurveControlPointPointer aControlPoint)
    : Point(aX, aY)
    , mControlPoint_(aControlPoint)
{

}

PitchCurveControlPointPointer controlPoint() const
{
    return mControlPoint_;
}
