#include "vibratofrequency.h"

using namespace waltz::editor::ScoreComponent;

VibratoFrequency::VibratoFrequency(const double aValue)
    : mValue_(aValue)
{
}

double VibratoFrequency::value() const
{
    return mValue_;
}

