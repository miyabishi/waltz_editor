#ifndef PLAYBACKSTARTINGTIME_H
#define PLAYBACKSTARTINGTIME_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PlaybackStartingTime
            {
            public:
                explicit PlaybackStartingTime(double aValue);
                ~PlaybackStartingTime();
                common::Commands::Parameter toParameter() const;
            private:
                common::Commands::Parameter& mParameter_;

            private:
                PlaybackStartingTime(const PlaybackStartingTime& aOther);
                PlaybackStartingTime& operator=(const PlaybackStartingTime& aOther);
            };
            typedef QSharedPointer<PlaybackStartingTime> PlaybackStartingTimePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PLAYBACKSTARTINGTIME_H
