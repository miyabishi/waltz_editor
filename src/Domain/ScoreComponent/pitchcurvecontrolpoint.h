#ifndef PITCHCURVECONTROLPOINT_H
#define PITCHCURVECONTROLPOINT_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchCurveControlPoint
            {
            public:
                PitchCurveControlPoint();
            private:
                PitchCurveControlPoint(const PitchCurveControlPoint& aOther);
                PitchCurveControlPoint& operator=(const PitchCurveControlPoint& aOther);
            };
            typedef QSharedPointer <PitchCurveControlPoint> PitchCurveControlPointPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVECONTROLPOINT_H
