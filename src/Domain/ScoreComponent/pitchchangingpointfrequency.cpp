#include "pitchchangingpointfrequency.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME = "Frequency";
}

PitchChangingPointFrequency::PitchChangingPointFrequency(double aValue)
    : mParameter_(* (new Parameter(PARAMETER_NAME, aValue)))
{
}

PitchChangingPointFrequency::~PitchChangingPointFrequency()
{
    delete &mParameter_;
}

Parameter PitchChangingPointFrequency::toParameter() const
{
    return mParameter_;
}

