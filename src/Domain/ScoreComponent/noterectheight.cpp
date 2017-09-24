#include "noterectheight.h"


using namespace waltz::editor::ScoreComponent;

NoteRectHeight::NoteRectHeight(const int aValue)
    : mValue_(aValue)
{
}

int NoteRectHeight::value() const
{
    return mValue_;
}

int NoteRectHeight::center() const
{
    return mValue_ / 2;
}
