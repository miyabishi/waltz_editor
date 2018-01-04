#include "vibratolength.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_NAME("VibratoLength");
}

VibratoLength::VibratoLength(const int aValue)
    :mValue_(aValue)
{
}

VibratoLength::~VibratoLength()
{
}


Parameter VibratoLength::toParameter(Beat aBeat,
                                     Tempo aTempo,
                                     model::EditAreaInformationPointer aEditAreaInformation) const
{
    return Parameter(PARAMETER_NAME, aEditAreaInformation->calculateSec(mValue_, aBeat, aTempo));
}
