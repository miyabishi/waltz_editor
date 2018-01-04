#include "vibratowavelength.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_NAME("VibratoWavelength");
}

VibratoWavelength::VibratoWavelength(const int aValue)
    :mValue_(aValue)
{
}

VibratoWavelength::~VibratoWavelength()
{
}

Parameter VibratoWavelength::toParameter(Beat aBeat,
                                         Tempo aTempo,
                                         model::EditAreaInformationPointer aEditAreaInformation) const
{
    return Parameter(PARAMETER_NAME, aEditAreaInformation->calculateSec(mValue_, aBeat, aTempo));
}
