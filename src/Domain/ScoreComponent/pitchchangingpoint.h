#ifndef PITCHCHANGINGPOINT_H
#define PITCHCHANGINGPOINT_H

#include <QSharedPointer>
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchChangingPoint : public Point
            {
            public:
                PitchChangingPoint(const int aX,
                                   const int aY);

            private:
                PitchChangingPoint(const PitchChangingPoint& aOther);
                PitchChangingPoint& operator=(const PitchChangingPoint& aOther);
            };
            typedef QSharedPointer<PitchChangingPoint> PitchChangingPointPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINT_H
