#include "vibratolength.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_NAME("VibratoLength");
}

VibratoLength::VibratoLength(const double aValue)
    :mParameter_(* new Parameter(PARAMETER_NAME, aValue))
{
}

VibratoLength::~VibratoLength()
{
    delete &mParameter_;
}


Parameter VibratoLength::toParameter() const
{
    return mParameter_;
}
