#include "pitch.h"

using namespace waltz::editor::ScoreComponent;

Pitch::Pitch(Tone aTone, int aOctave)
    : mTone_(aTone)
    , mOctave_(aOctave)
{

}

Pitch::Pitch(const Pitch& aOther)
    : mTone_(aOther.mTone_)
    , mOctave_(aOther.mOctave_)
{
}

Pitch& Pitch::operator=(const Pitch& aOther)
{
    mTone_ = aOther.mTone_;
    mOctave_ = aOther.mOctave_;
    return (*this);
}

Tone Pitch::tone() const
{
    return mTone_;
}

int Pitch::octave() const
{
    return mOctave_;
}
