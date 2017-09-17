#ifndef PITCHCURVEENDPOINT_H
#define PITCHCURVEENDPOINT_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchCurveEndPoint
            {
            public:
                PitchCurveEndPoint();

            private:
                PitchCurveEndPoint(const PitchCurveEndPoint& aOther);
                PitchCurveEndPoint& operator=(const PitchCurveEndPoint& aOther);
            };
            typedef QSharedPointer<PitchCurveEndPoint> PitchCurveEndPointPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVEENDPOINT_H
