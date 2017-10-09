#include "vibratolength.h"

using namespace waltz::editor::ScoreComponent;

VibratoLength::VibratoLength(int aValue)
    :mValue_(aValue)
{
}


int VibratoLength::value() const
{
    return mValue_;
}
