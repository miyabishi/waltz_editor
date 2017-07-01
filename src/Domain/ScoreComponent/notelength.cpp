#include "notelength.h"

using namespace waltz::editor::ScoreComponent;

NoteLength::NoteLength(double aSec)
    : mSec_(aSec)
{

}

NoteLength::NoteLength(const NoteLength& aOther)
    : mSec_(aOther.mSec_)
{
}

NoteLength& NoteLength::operator=(const NoteLength& aOther)
{
    mSec_ = aOther.mSec_;
    return (*this);
}

double NoteLength::value() const
{
    return mSec_;
}

