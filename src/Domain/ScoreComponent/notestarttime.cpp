#include "notestarttime.h"

using namespace waltz::editor::ScoreComponent;

NoteStartTime::NoteStartTime(double aSec)
    : mSec_(aSec)
{

}

NoteStartTime::NoteStartTime(const NoteStartTime& aOther)
    : mSec_(aOther.mSec_)
{

}

NoteStartTime& NoteStartTime::operator=(const NoteStartTime& aOther)
{
    mSec_ = aOther.mSec_;
    return (*this);
}

double NoteStartTime::value() const
{
    return mSec_;
}

