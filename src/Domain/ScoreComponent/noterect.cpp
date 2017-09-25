#include "noterect.h"

using namespace waltz::editor::ScoreComponent;


NoteRect::NoteRect(const NoteRectPositionPointer aPosition,
                   const NoteRectWidthPointer aWidth,
                   const NoteRectHeightPointer aHeight)
    : mPosition_(aPosition)
    , mWidth_(aWidth)
    , mNoteRectHeight_(aHeight)
{
}

NoteStartTimePointer NoteRect::noteStartTime(Beat aBeat,
                                             Tempo aTempo,
                                             const model::EditAreaInformationPointer aEditAreaInformation) const
{
    return aEditAreaInformation->calculateNoteStartTime(mPosition_->x(),
                                                        aBeat,
                                                        aTempo);
}

NoteLengthPointer NoteRect::noteLength(
        Beat aBeat,
        Tempo aTempo,
        const waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const
{
    return aEditAreaInformation->calculateNoteLength(mWidth_->value(),aBeat,aTempo);
}

int NoteRect::x() const
{
    return mPosition_->x();
}

int NoteRect::y() const
{
    return mPosition_->y();
}

PitchPointer NoteRect::pitch(const waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const
{
    return aEditAreaInformation->calculatePitch(mPosition_->y());
}

NoteRectHeightPointer NoteRect::height() const
{
    return mNoteRectHeight_;
}

NoteRectPositionPointer NoteRect::position() const
{
    return mPosition_;
}
