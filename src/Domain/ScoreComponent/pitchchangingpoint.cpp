
#include "pitchchangingpoint.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;
using namespace waltz::editor::model;

PitchChangingPoint::PitchChangingPoint(const int aX,
                                       const int aY)
    : Point(aX, aY)
{
}

Parameters PitchChangingPoint::toParameters(Beat aBeat,
                                            Tempo aTempo,
                                            EditAreaInformationPointer aEditAreaInformation)
{
    Parameters parameters;
    parameters.append(aEditAreaInformation->calculatePitchChangningPointTime(x(),
                                                                             aBeat,
                                                                             aTempo)->toParameter());
    parameters.append(aEditAreaInformation->calculatePitchChangningPointFrequency(y())->toParameter());

    return parameters;
}

