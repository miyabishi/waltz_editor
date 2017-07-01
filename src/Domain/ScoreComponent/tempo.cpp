#include "tempo.h"

using namespace waltz::editor::ScoreComponent;

Tempo::Tempo(int aValue)
    : mValue_(aValue)
{
}

int Tempo::value() const
{
    return mValue_;
}

Tempo::Tempo(const Tempo& aOther)
    : mValue_(aOther.mValue_)
{
}

Tempo& Tempo::operator=(const Tempo& aOther)
{
    mValue_ = aOther.mValue_;
    return (*this);
}

