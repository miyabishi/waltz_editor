#include "vibratofrequency.h"

using namespace waltz::editor::ScoreComponent;

VibratoFrequency::VibratoFrequency(const int aValue)
    : mValue_(aValue)
{
}

int VibratoFrequency::value() const
{
    return mValue_;
}

