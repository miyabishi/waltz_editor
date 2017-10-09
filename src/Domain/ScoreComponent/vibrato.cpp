#include "vibrato.h"

using namespace waltz::editor::ScoreComponent;

Vibrato::Vibrato(const VibratoAmplitudePointer aAmplitude,
                 const VibratoFrequencyPointer aFrequency,
                 const VibratoLengthPointer    aLength)
    : mAmplitude_(aAmplitude)
    , mFrequency_(aFrequency)
    , mLength_(aLength)
{
}

VibratoLengthPointer Vibrato::length() const
{
    return mLength_;
}

VibratoAmplitudePointer Vibrato::amplitude() const
{
    return mAmplitude_;
}
