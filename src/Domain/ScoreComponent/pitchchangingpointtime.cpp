#include "pitchchangingpointtime.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

PitchChangingPointTime::PitchChangingPointTime(const double aValue)
    : mValue_(aValue)
{
}

Parameter PitchChangingPointTime::toParameter()
{
    return Parameter("Time", mValue_);
}

