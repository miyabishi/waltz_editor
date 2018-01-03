#include "vibratolist.h"

using namespace waltz::editor::ScoreComponent;

VibratoList::VibratoList()
{
}

void VibratoList::append(const VibratoPointer aVibrato)
{
    mVibratoList_.append(aVibrato);
}

void VibratoList::clearVibrato()
{
    mVibratoList_.clear();
}
