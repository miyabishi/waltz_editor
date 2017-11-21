#ifndef PITCHCURVE_H
#define PITCHCURVE_H

#include <QSharedPointer>
#include <QList>
#include <waltz_common/parameter.h>
#include "pitchchangingpoint.h"

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
                void appendChangingPoint(PitchChangingPointPointer aChangingPoint);
                common::Commands::Parameter toParameter(mBeat_, mTempo_, aEditAreaInformation);

            private:
                QList<PitchChangingPointPointer> mPitchCurve_;

            private:
                PitchCurve(const PitchCurve& aOther);
                PitchCurve& operator=(const PitchCurve& aOther);
            };
            typedef QSharedPointer<PitchCurve> PitchCurvePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVE_H
