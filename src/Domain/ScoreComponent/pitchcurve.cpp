#include "pitchcurve.h"

using namespace::waltz::editor::ScoreComponent;

PitchCurve::PitchCurve(const PitchCurveStartPointPointer aStartPoint,
                       const PitchCurveEndPointPointer aEndPoint)
    : mStartPoint_(aStartPoint)
    , mPitchCurve_()
    , mEndPoint_(aEndPoint)
{
}

PitchCurveStartPointPointer PitchCurve::startPoint() const
{
    return mStartPoint_;
}

PitchChangingPointPointer PitchCurve::changingPoint(int aIndex) const
{
    return mPitchCurve_.at(aIndex);
}

PitchCurveEndPointPointer PitchCurve::endPoint() const
{
    return mEndPoint_;
}

void PitchCurve::append(PitchChangingPointPointer aChangingPoint)
{
    mPitchCurve_.append(aChangingPoint);
}

int PitchCurve::changingPointCount() const
{
    return mPitchCurve_.count();
}
