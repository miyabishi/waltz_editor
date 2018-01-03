#include "vibratowavelength.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_NAME("VibratoWavelength");
}

VibratoWavelength::VibratoWavelength(const double aSec)
    :mParameter_( * new Parameter(PARAMETER_NAME, aSec))
{
}

VibratoWavelength::~VibratoWavelength()
{
    delete &mParameter_;
}



Parameter VibratoWavelength::toParameter() const
{
    return mParameter_;
}
