#ifndef PITCHCURVEENDPOINT_H
#define PITCHCURVEENDPOINT_H

#include <QSharedPointer>
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchCurveEndPoint : public Point
            {
            public:
                PitchCurveEndPoint(int aX, int aY);

            private:

            private:
                PitchCurveEndPoint(const PitchCurveEndPoint& aOther);
                PitchCurveEndPoint& operator=(const PitchCurveEndPoint& aOther);
            };
            typedef QSharedPointer<PitchCurveEndPoint> PitchCurveEndPointPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVEENDPOINT_H
