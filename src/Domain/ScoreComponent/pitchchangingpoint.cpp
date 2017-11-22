
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

    parameters.append(Parameter("Time", aEditAreaInformation->calculateNoteStartTime(x(),
                                                                                     aBeat,
                                                                                     aTempo)));
    parameters.append(Parameter("Frequency", ""));
    return parameters;
}

