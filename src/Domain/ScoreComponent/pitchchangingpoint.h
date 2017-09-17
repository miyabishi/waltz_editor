#ifndef PITCHCHANGINGPOINT_H
#define PITCHCHANGINGPOINT_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchChangingPoint
            {
            public:
                PitchChangingPoint(const int aX,
                                   const int aY);

            private:
                int mX_;
                int mY_;

            private:
                PitchChangingPoint(const PitchChangingPoint& aOther);
                PitchChangingPoint& operator=(const PitchChangingPoint& aOther);
            };
            typedef QSharedPointer<PitchChangingPoint> PitchChangingPointPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINT_H
