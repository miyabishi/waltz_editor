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
                PitchCurve(const PitchCurveStartPointPointer aStartPoint,
                           const PitchCurveEndPointPointer aEndPoint);

                PitchCurveStartPointPointer startPoint() const;
                void append(PitchChangingPointPointer aChangingPoint);
                int changingPointCount() const;
                PitchChangingPointPointer changingPoint(int aIndex) const;
                PitchCurveEndPointPointer endPoint() const;

            private:
                PitchCurveStartPointPointer      mStartPoint_;
                QList<PitchChangingPointPointer> mPitchCurve_;
                PitchCurveEndPointPointer        mEndPoint_;

            private:
                PitchCurve(const PitchCurve& aOther);
                PitchCurve& operator=(const PitchCurve& aOther);
            };
            typedef QSharedPointer<PitchCurve> PitchCurvePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVE_H
