#include "pitchchangingpoint.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;



PitchChangingPoint::PitchChangingPoint(const int aX,
                                       const int aY)
    : Point(aX, aY)
{
}

Parameters PitchChangingPoint::toParameters(aBeat, aTempo, aEditAreaInformation)
{
    Parameters parameters;

    parameters.append(Parameter("Time", aEditAreaInformation->calculateNoteStartTime(x(),
                                                                                     aBeat,
                                                                                     aTempo)));
    //TODO
    parameters.append(Parameter("Frequency", ""));
    return parameters;
}

