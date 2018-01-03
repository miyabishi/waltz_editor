#include "vibratoform.h"

using namespace waltz::editor::ScoreComponent;

VibratoForm::VibratoForm(int aLength,
                         int aWavelength,
                         double aAmplitude)
    : mLength_(aLength)
    , mWavelength_(aWavelength)
    , mAmplitude_(aAmplitude)
{
}

int VibratoForm::length() const
{
    return mLength_;
}

int VibratoForm::wavelength() const
{
    return mWavelength_;
}

double VibratoForm::amplitude() const
{
    return mAmplitude_;
}
