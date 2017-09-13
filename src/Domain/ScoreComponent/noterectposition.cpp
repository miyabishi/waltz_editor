#include "noterectposition.h"

using namespace waltz::editor::ScoreComponent;

NoteRectPosition::NoteRectPosition(const int aX,
                                   const int aY)
    : mX_(aX)
    , mY_(aY)
{

}

int NoteRectPosition::x() const
{
    return mX_;
}

int NoteRectPosition::y() const
{
    return mY_;
}
