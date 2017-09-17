#ifndef PITCHCURVESTARTPOINT_H
#define PITCHCURVESTARTPOINT_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchCurveStartPoint
            {
            public:
                PitchCurveStartPoint();
            private:
                PitchCurveStartPoint(const PitchCurveStartPoint& aOther);
                PitchCurveStartPoint& operator=(const PitchCurveStartPoint& aOther);
            };
            typedef QSharedPointer<PitchCurveStartPoint> PitchCurveStartPointPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVESTARTPOINT_H
