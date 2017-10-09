#ifndef VIBRATOENDPOINT_H
#define VIBRATOENDPOINT_H

#include <QSharedPointer>
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoEndPoint : public Point
            {
            public:
                VibratoEndPoint(int aX, int aY);
            private:
                VibratoEndPoint(const VibratoEndPoint& aOther);
                VibratoEndPoint& operator=(const VibratoEndPoint& aOther);
            };
            typedef QSharedPointer<VibratoEndPoint> VibratoEndPointPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOENDPOINT_H
