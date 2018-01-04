#include "vibratoamplitude.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME("VibratoAmplitude");
}

VibratoAmplitude::VibratoAmplitude(const double aValue)
 :mValue_(aValue)
{
}

VibratoAmplitude::~VibratoAmplitude()
{
}

Parameter VibratoAmplitude::toParameter(Beat /*aBeat*/,
                                        Tempo /*aTempo*/,
                                        model::EditAreaInformationPointer /*aEditAreaInformation*/) const
{
    return Parameter(PARAMETER_NAME, mValue_);
}
