#include "pitchcurve.h"

using namespace::waltz::editor::ScoreComponent;

PitchCurve::PitchCurve()
    : mPitchCurve_()
{
}

void PitchCurve::appendChangingPoint(PitchChangingPointPointer aChangingPoint)
{
    mPitchCurve_.append(aChangingPoint);
}

