#include "pitch.h"

using namespace waltz::editor::ScoreComponent;

Pitch::Pitch(Tone aTone, int aOctave)
    : mTone_(aTone)
    , mOctave_(aOctave)
{
}


Tone Pitch::tone() const
{
    return mTone_;
}

int Pitch::octave() const
{
    return mOctave_;
}
