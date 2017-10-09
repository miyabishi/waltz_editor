#ifndef VIBRATOSTARTPOINT_H
#define VIBRATOSTARTPOINT_H

#include <QSharedPointer>
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoStartPoint : public Point
            {
            public:
                VibratoStartPoint(int aX, int aY);

            private:
                VibratoStartPoint(const VibratoStartPoint& aOther);
                VibratoStartPoint operator=(const VibratoStartPoint& aOther);
            };
            typedef QSharedPointer<VibratoStartPoint> VibratoStartPointPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOSTARTPOINT_H
