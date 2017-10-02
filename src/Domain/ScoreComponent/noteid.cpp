#include <QDebug>
#include "noteid.h"

using namespace waltz::editor::ScoreComponent;

NoteId::NoteId(const int aValue)
    :mValue_(aValue)
{}

NoteId::NoteId(const NoteId& aOther)
    :mValue_(aOther.mValue_)
{}

NoteId& NoteId::operator=(const NoteId& aOther)
{
    mValue_ = aOther.mValue_;
    return (*this);
}

bool NoteId::operator==(const NoteId& aOther) const
{
    return mValue_ == aOther.mValue_;
}

bool NoteId::operator!=(const NoteId& aOther) const
{
    return mValue_ != aOther.mValue_;
}

int NoteId::value() const
{
    return mValue_;
}
