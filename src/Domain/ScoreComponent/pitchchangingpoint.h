#ifndef PITCHCHANGINGPOINT_H
#define PITCHCHANGINGPOINT_H

#include <QSharedPointer>
#include "point.h"
#include "pitchcurvecontrolpoint.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchChangingPoint : Point
            {
            public:
                PitchChangingPoint(const int aX,
                                   const int aY,
                                   const PitchCurveControlPointPointer aControlPoint);
                PitchCurveControlPointPointer controlPoint() const;

            private:
                PitchCurveControlPointPointer mControlPoint_;
            private:
                PitchChangingPoint(const PitchChangingPoint& aOther);
                PitchChangingPoint& operator=(const PitchChangingPoint& aOther);
            };
            typedef QSharedPointer<PitchChangingPoint> PitchChangingPointPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINT_H
