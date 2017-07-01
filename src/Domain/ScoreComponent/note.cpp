#include "src/Domain/Commands/parameters.h"
#include "src/Domain/Commands/parameter.h"
#include "note.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::editor::Commands;

Note::Note(Pitch aPitch,
           Syllable aSyllable,
           NoteStartTime aNoteStartTime,
           NoteLength aNoteLength)
    : mPitch_(aPitch)
    , mSyllable_(aSyllable)
    , mNoteStartTime_(aNoteStartTime)
    , mNoteLength_(aNoteLength)
{
}

Note::Note(const Note& aOther)
    : mPitch_(aOther.mPitch_)
    , mSyllable_(aOther.mSyllable_)
    , mNoteStartTime_(aOther.mNoteStartTime_)
    , mNoteLength_(aOther.mNoteLength_)
{
}

Note& Note::operator=(const Note& aOther)
{
    mPitch_         = aOther.mPitch_;
    mSyllable_      = aOther.mSyllable_;
    mNoteStartTime_ = aOther.mNoteStartTime_;
    mNoteLength_    = aOther.mNoteLength_;

    return (*this);
}

Parameters Note::toParameters() const
{
    Parameters parameters;
    parameters.append(Parameter("ToneValue",(int)mPitch_.tone()));
    parameters.append(Parameter("Octave",        mPitch_.octave()));
    parameters.append(Parameter("Alias",         mSyllable_.value()));
    parameters.append(Parameter("NoteStartTime", mNoteStartTime_.value()));
    parameters.append(Parameter("NoteLength",    mNoteLength_.value()));

    return parameters;
}

