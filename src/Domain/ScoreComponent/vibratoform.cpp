#include "vibratoform.h"

using namespace waltz::editor::ScoreComponent;

VibratoForm::VibratoForm(int aLength,
                         int aWavelength,
                         int aAmplitude)
    : mLength_(aLength)
    , mWavelength_(aWavelength)
    , mAmplitude_(aAmplitude)
{
}
