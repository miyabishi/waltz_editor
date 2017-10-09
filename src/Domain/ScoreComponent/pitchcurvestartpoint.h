#ifndef PITCHCURVESTARTPOINT_H
#define PITCHCURVESTARTPOINT_H

#include <QSharedPointer>
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchCurveStartPoint : public Point
            {
            public:
                PitchCurveStartPoint(int aX, int aY);

            private:
                PitchCurveStartPoint(const PitchCurveStartPoint& aOther);
                PitchCurveStartPoint& operator=(const PitchCurveStartPoint& aOther);
            };
            typedef QSharedPointer<PitchCurveStartPoint> PitchCurveStartPointPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVESTARTPOINT_H
