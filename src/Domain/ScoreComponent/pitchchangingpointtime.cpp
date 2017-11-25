#include "pitchchangingpointtime.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME = "Time";
}

PitchChangingPointTime::PitchChangingPointTime(const double aValue)
    : mParameter_( * (new Parameter(PARAMETER_NAME, aValue)))
{
}

PitchChangingPointTime::~PitchChangingPointTime()
{
    delete &mParameter_;
}

Parameter PitchChangingPointTime::toParameter()
{
    return Parameter(PARAMETER_NAME, mValue_);
}

