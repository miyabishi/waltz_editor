#include "editareainformation.h"

using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const int BASE_COLUMN_WIDTH = 100;
    const int BASE_ROW_HEIGHT   = 20;
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

NoteStartTime EditAreaInformation::calculateNoteStartTime(int aX,
                                                          Beat aBeat,
                                                          Tempo aTempo) const
{
    return NoteStartTime(calculateSec(aX, aBeat, aTempo));
}

NoteLength EditAreaInformation::calculateNoteLength(int aWidth,
                                                    Beat aBeat,
                                                    Tempo aTempo) const
{
    return NoteLength(calculateSec(aWidth, aBeat, aTempo));
}

Pitch EditAreaInformation::calculatePitch(int aY) const
{
    int octave = calculateBelongingOctave(aY);
    Tone tone = calculateTone(aY);

    return Pitch(tone, octave);
}

Tone EditAreaInformation::calculateTone(int aY) const
{
    return Tone(TONE_B - aY%octaveHeight()/rowHeight());
}

int EditAreaInformation::calculateBelongingOctave(int aY) const
{
    return mSupportOctarve_ - aY/octaveHeight();
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

double EditAreaInformation::timeLengthOfABar(Tempo aTempo) const
{
    return 60.0 / (double)aTempo.value() * 4;
}