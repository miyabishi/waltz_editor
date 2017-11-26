#ifndef PITCHCHANGINGPOINTTIME_H
#define PITCHCHANGINGPOINTTIME_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class PitchChangingPointTime
            {
            public:
                explicit PitchChangingPointTime(double aValue);
                ~PitchChangingPointTime();

            public:
                common::Commands::Parameter toParameter();

            private:
                common::Commands::Parameter& mParameter_;

            private:
                PitchChangingPointTime(const PitchChangingPointTime& aOther);
                PitchChangingPointTime& operator=(const PitchChangingPointTime& aOther);

            };
            typedef QSharedPointer<PitchChangingPointTime> PitchChangingPointTimePointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINTTIME_H
