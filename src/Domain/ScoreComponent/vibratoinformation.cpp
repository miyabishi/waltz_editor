#include "vibratoinformation.h"

using namespace waltz::editor::ScoreComponent;

VibratoInformation::VibratoInformation(double aVibratoAmplitude,
                                       int aVibratoFrequency,
                                       int aVibratoLength)
    : mVibratoAmplitude_(aVibratoAmplitude)
    , mVibratoFequency_(aVibratoFrequency)
    , mVibratoLength_(aVibratoLength)
{
}


VibratoPointer VibratoInformation::vibrato() const
{
    return VibratoPointer(new Vibrato(
                              VibratoAmplitudePointer(
                                  new VibratoAmplitude(mVibratoAmplitude_)),
                              VibratoFrequencyPointer(
                                  new VibratoFrequency(mVibratoFequency_)),
                              VibratoLengthPointer(
                                  new VibratoLength(mVibratoLength_))
                              ));
}
