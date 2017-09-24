#ifndef PITCHCURVEENDPOINT_H
#define PITCHCURVEENDPOINT_H

#include <QSharedPointer>
#include "point.h"
#include "pitchcurvecontrolpoint.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchCurveEndPoint : public Point
            {
            public:
                PitchCurveEndPoint(int aX, int aY,
                                   const PitchCurveControlPointPointer aControlPoint);
                PitchCurveControlPointPointer controlPoint() const;

            private:
                PitchCurveControlPointPointer mControlPoint_;

            private:
                PitchCurveEndPoint(const PitchCurveEndPoint& aOther);
                PitchCurveEndPoint& operator=(const PitchCurveEndPoint& aOther);
            };
            typedef QSharedPointer<PitchCurveEndPoint> PitchCurveEndPointPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVEENDPOINT_H
