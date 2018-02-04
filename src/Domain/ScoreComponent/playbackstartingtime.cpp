#include "playbackstartingtime.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME("PlaybackStartingTime");
}

PlaybackStartingTime::PlaybackStartingTime(double aValue)
    : mParameter_(* new Parameter(PARAMETER_NAME, aValue))
{
}

PlaybackStartingTime::~PlaybackStartingTime()
{
    delete &mParameter_;
}

Parameter PlaybackStartingTime::toParameter() const
{
    return mParameter_;
}
