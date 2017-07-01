#include "syllable.h"

using namespace waltz::editor::ScoreComponent;

Syllable::Syllable(const QString& aValue)
    : mValue_(aValue)
{
}

Syllable::Syllable(const Syllable& aOther)
    : mValue_(aOther.mValue_)
{
}

Syllable& Syllable::operator=(const Syllable& aOther)
{
    mValue_ = aOther.mValue_;
    return (*this);
}

QString Syllable::value() const
{
    return mValue_;
}
