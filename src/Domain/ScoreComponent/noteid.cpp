#include "noteid.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_NAME("NoteId");
}

NoteId::NoteId(const int aValue)
    :mValue_(aValue)
{}

NoteId::NoteId(const NoteId& aOther)
    :mValue_(aOther.mValue_)
{}

Parameter NoteId::toParameter() const
{
    return Parameter(PARAMETER_NAME, mValue_);
}

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
