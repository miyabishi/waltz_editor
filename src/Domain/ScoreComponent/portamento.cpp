#include "portamento.h"

using namespace waltz::editor::ScoreComponent;

Portamento::Portamento(const PitchCurvePointer aPitchCurve)
    : mPitchCurve_(aPitchCurve)
{
}

PitchCurvePointer Portamento::pitchCurve() const
{
    return mPitchCurve_;
}
