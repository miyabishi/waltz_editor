#ifndef PITCHCHANGINGPOINTTIME_H
#define PITCHCHANGINGPOINTTIME_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class PitchChangingPointTime
            {
            public:
                PitchChangingPointTime(double aValue);

            private:
                double mValue_;

            private:
                PitchChangingPointTime(const PitchChangingPointTime& aOther);
                PitchChangingPointTime& operator=(const PitchChangingPointTime& aOther);

            };
            typedef QSharedPointer<PitchChangingPointTime> PitchChangingPointTimePointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINTTIME_H
