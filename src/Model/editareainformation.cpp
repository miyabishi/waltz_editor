#include <qmath.h>
#include "editareainformation.h"

using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const int NUMBER_OF_TONE_IN_OCTAVE = 12;
    const int BASE_COLUMN_WIDTH        = 150;
    const int BASE_ROW_HEIGHT          = 20;
    const double BASE_PITCH_A          = 440.0;
}

EditAreaInformation::EditAreaInformation(double aWidthRate,
                                         double aHeightRate,
                                         int aSupportOctave,
                                         int aEditAreaWidth_)
    : mWidthRate_(aWidthRate)
    , mHeightRate_(aHeightRate)
    , mSupportOctarve_(aSupportOctave)
    , mEditAreaWidth_(aEditAreaWidth_)
{
}

EditAreaInformation::EditAreaInformation(const EditAreaInformation& aOther)
    : mWidthRate_(aOther.mWidthRate_)
    , mHeightRate_(aOther.mHeightRate_)
    , mSupportOctarve_(aOther.mSupportOctarve_)
    , mEditAreaWidth_(aOther.mEditAreaWidth_)
{
}

int EditAreaInformation::calculatePositionX(ScoreComponent::NoteStartTimePointer aNoteStartTime,
                                            ScoreComponent::Beat aBeat,
                                            ScoreComponent::Tempo aTempo) const
{
    return aNoteStartTime->value() / timeLengthOfABar(aTempo) * barWidth(aBeat);
}

EditAreaInformation& EditAreaInformation::operator=(const EditAreaInformation& aOther)
{
    mWidthRate_      = aOther.mWidthRate_;
    mHeightRate_     = aOther.mHeightRate_;
    mSupportOctarve_ = aOther.mSupportOctarve_;
    mEditAreaWidth_  = aOther.mEditAreaWidth_;
    return (*this);
}

int EditAreaInformation::columnWidth(int aBeatParent) const
{
    return BASE_COLUMN_WIDTH * mWidthRate_ * 4 / aBeatParent;
}
int EditAreaInformation::rowHeight() const
{
    return BASE_ROW_HEIGHT * mHeightRate_;
}

int EditAreaInformation::supportOctave() const
{
    return mSupportOctarve_;
}

int EditAreaInformation::editAreaWidth() const
{
    return mEditAreaWidth_;
}

NoteStartTimePointer EditAreaInformation::calculateNoteStartTime(int aX,
                                                                 Beat aBeat,
                                                                 Tempo aTempo) const
{
    return NoteStartTimePointer(new NoteStartTime(calculateSec(aX, aBeat, aTempo)));
}

NoteLengthPointer EditAreaInformation::calculateNoteLength(int aWidth,
                                                           Beat aBeat,
                                                           Tempo aTempo) const
{
    return NoteLengthPointer(new NoteLength(calculateSec(aWidth, aBeat, aTempo)));
}

PitchChangingPointTimePointer EditAreaInformation::calculatePitchChangningPointTime(int aX,
                                                                                    Beat aBeat,
                                                                                    Tempo aTempo) const
{
    return PitchChangingPointTimePointer(new PitchChangingPointTime(calculateSec(aX, aBeat, aTempo)));
}

PitchChangingPointFrequencyPointer EditAreaInformation::calculatePitchChangningPointFrequency(int aY) const
{
    int baseAPositionOffset = octaveHeight() * 2  + rowHeight() * 9 + rowHeight() / 2;
    int yPosition = editAreaHeight() - aY;
    double frequency = BASE_PITCH_A * qPow(2, (double)(yPosition - baseAPositionOffset) / octaveHeight());

    return PitchChangingPointFrequencyPointer(new PitchChangingPointFrequency(frequency));
}

PitchPointer EditAreaInformation::calculatePitch(int aY) const
{
    int octave = calculateBelongingOctave(aY);
    Tone tone = calculateTone(aY);

    return PitchPointer(new Pitch(tone, octave));
}

Tone EditAreaInformation::calculateTone(int aY) const
{
    return Tone(TONE_B - aY%octaveHeight()/rowHeight());
}

int EditAreaInformation::calculateBelongingOctave(int aY) const
{
    return mSupportOctarve_ - aY/octaveHeight() + 4;
}

int EditAreaInformation::octaveHeight() const
{
    return rowHeight() * 12;
}

double EditAreaInformation::calculateSec(int aX,
                                         Beat aBeat,
                                         Tempo aTempo) const
{
    return (double)aX / barWidth(aBeat) * timeLengthOfABar(aTempo);
}

int EditAreaInformation::barWidth(Beat aBeat) const
{
    return columnWidth(aBeat.parentValue()) * aBeat.childValue();
}

int EditAreaInformation::editAreaHeight() const
{
    return mSupportOctarve_ * octaveHeight();
}

double EditAreaInformation::timeLengthOfABar(Tempo aTempo) const
{
    return 60.0 / (double)aTempo.value() * 4;
}

VibratoLengthPointer EditAreaInformation::calculateVibratoLength(int aLength,
                                                                 ScoreComponent::Beat aBeat,
                                                                 ScoreComponent::Tempo aTempo) const
{
    return VibratoLengthPointer( new VibratoLength(calculateSec(aLength, aBeat, aTempo)));
}

VibratoWavelengthPointer EditAreaInformation::calculateVibratoWavelength(int aWavelength,
                                                                         ScoreComponent::Beat aBeat,
                                                                         ScoreComponent::Tempo aTempo) const
{
    return VibratoWavelengthPointer(new VibratoWavelength(calculateSec(aWavelength, aBeat, aTempo)));
}
