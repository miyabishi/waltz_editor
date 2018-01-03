#include "vibratoamplitude.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME("VibratoAmplitude");
}

VibratoAmplitude::VibratoAmplitude(const double aValue)
    :mParameter_(* new Parameter(PARAMETER_NAME, aValue))
{
}

VibratoAmplitude::~VibratoAmplitude()
{
    delete &mParameter_;
}

Parameter VibratoAmplitude::toParameter() const
{
    return mParameter_;
}
