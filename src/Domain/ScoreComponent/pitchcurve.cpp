#include "pitchcurve.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_PITCH_CURVE = "PitchCurve";

    bool pitchCurveLessThan(const PitchChangingPointPointer aPitchChangingPointA,
                                const PitchChangingPointPointer aPitchChangingPointB)
    {
        return aPitchChangingPointA->x() < aPitchChangingPointB->x();
    }
}

PitchCurve::PitchCurve()
    : mPitchCurve_()
{
}

void PitchCurve::appendChangingPoint(PitchChangingPointPointer aChangingPoint)
{
    mPitchCurve_.append(aChangingPoint);
}

Parameter PitchCurve::toParameter(Beat aBeat,
                                  Tempo aTempo,
                                  waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const
{
    QJsonArray pitchChangingPointListArray;
    QList<PitchChangingPointPointer> pitchCurve = mPitchCurve_;

    qSort(pitchCurve.begin(), pitchCurve.end(), pitchCurveLessThan);
    foreach(const PitchChangingPointPointer pitchChangingPoint, pitchCurve)
    {
        pitchChangingPointListArray.append(pitchChangingPoint->toParameters(aBeat, aTempo, aEditAreaInformation).toJsonArray());
    }
    return Parameter(PARAMETER_PITCH_CURVE, pitchChangingPointListArray);
}
