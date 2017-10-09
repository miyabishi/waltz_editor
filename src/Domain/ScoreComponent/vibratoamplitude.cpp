#include "vibratoamplitude.h"

using namespace waltz::editor::ScoreComponent;

VibratoAmplitude::VibratoAmplitude(const double aValue)
    :mValue_(aValue)
{
}

double VibratoAmplitude::value() const
{
    return mValue_;
}
