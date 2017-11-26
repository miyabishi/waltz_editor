#ifndef PITCHCHANGINGPOINTFREQUENCY_H
#define PITCHCHANGINGPOINTFREQUENCY_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchChangingPointFrequency
            {
            public:
                explicit PitchChangingPointFrequency(double aValue);
                ~PitchChangingPointFrequency();


            public:
                common::Commands::Parameter toParameter() const;

            private:
                common::Commands::Parameter& mParameter_;

            private:
                PitchChangingPointFrequency(const PitchChangingPointFrequency& aOther);
                PitchChangingPointFrequency& operator=(const PitchChangingPointFrequency& aOther);
            };
            typedef QSharedPointer<PitchChangingPointFrequency> PitchChangingPointFrequencyPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINTFREQUENCY_H
