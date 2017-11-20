#include <waltz_common/parameters.h>
#include <waltz_common/parameter.h>
#include "note.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

Note::Note(const NoteId&           aNoteId,
           const Syllable&         aSyllable,
           const NoteRectPointer   aNoteRect)
    : mNoteId_(aNoteId)
    , mSyllable_(aSyllable)
    , mNoteRect_(aNoteRect)
{
}

NoteId Note::noteId() const
{
    return mNoteId_;
}

bool Note::noteIdEquals(const NoteId& aOtherNoteId) const
{
    return mNoteId_ == aOtherNoteId;
}

bool Note::xPositionIs(int aX)
{
    return mNoteRect_->x() == aX;
}

int Note::xPosition() const
{
    return mNoteRect_->x();
}

Parameters Note::toParameters(Beat aBeat,
                              Tempo aTempo,
                              waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const
{
    Parameters parameters;
    PitchPointer pitch = mNoteRect_->pitch(aEditAreaInformation);

    parameters.append(Parameter("ToneValue",(int)pitch->tone()));
    parameters.append(Parameter("Octave",        pitch->octave()));
    parameters.append(Parameter("Alias",         mSyllable_.value()));
    parameters.append(Parameter("NoteStartTime", mNoteRect_->noteStartTime(aBeat, aTempo, aEditAreaInformation)->value()));
    parameters.append(Parameter("NoteLength",    mNoteRect_->noteLength(aBeat, aTempo, aEditAreaInformation)->value()));

    return parameters;
}

Syllable Note::syllable() const
{
    return mSyllable_;
}

NoteRectPointer Note::noteRect() const
{
    return mNoteRect_;
}
