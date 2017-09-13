#include "notestarttime.h"

using namespace waltz::editor::ScoreComponent;

NoteStartTime::NoteStartTime(double aSec)
    : mSec_(aSec)
{

}

double NoteStartTime::value() const
{
    return mSec_;
}

