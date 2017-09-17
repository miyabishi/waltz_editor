#ifndef PITCHCURVE_H
#define PITCHCURVE_H

#include <QSharedPointer>
#include <QList>
#include "pitchchangingpoint.h"
#include "pitchcurvestartpoint.h"
#include "pitchcurveendpoint.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class PitchCurve
            {
            public:
                PitchCurve();

            private:
                PitchCurveStartPointPointer      mPitchCurveStartPoint_;
                QList<PitchChangingPointPointer> mPitchCurve_;
                PitchCurveEndPointPointer        mPitchCurveStartPoint_;

            private:
                PitchCurve(const PitchCurve& aOther);
                PitchCurve& operator=(const PitchCurve& aOther);
            };
            typedef QSharedPointer<PitchCurve> PitchCurvePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVE_H
