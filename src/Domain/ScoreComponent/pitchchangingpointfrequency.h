#ifndef PITCHCHANGINGPOINTFREQUENCY_H
#define PITCHCHANGINGPOINTFREQUENCY_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchChangingPointFrequency
            {
            public:
                PitchChangingPointFrequency(double aValue);

            private:
                double mValue_;

            private:
                PitchChangingPointFrequency(const PitchChangingPointFrequency& aOther);
                PitchChangingPointFrequency& operator=(const PitchChangingPointFrequency& aOther);
            };
            typedef QSharedPointer<PitchChangingPointFrequency> PitchChangingPointFrequencyPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINTFREQUENCY_H
