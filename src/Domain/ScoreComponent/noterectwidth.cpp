#include "noterectwidth.h"

using namespace waltz::editor::ScoreComponent;

NoteRectWidth::NoteRectWidth(const int aValue)
    :mValue_(aValue)
{
}

int NoteRectWidth::value() const
{
    return mValue_;
}
