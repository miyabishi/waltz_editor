#include "noterect.h"

using namespace waltz::editor::ScoreComponent;


NoteRect::NoteRect(const NoteRectPositionPointer aPosition,
                   const NoteRectWidthPointer aWidth,
                   const NoteRectHeightPointer aHeight)
    : mPosition_(aPosition)
    , mWidth_(aWidth)
    , mHeight_(aHeight)
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

int NoteRect::rightX() const
{
    return mPosition_->x() + mWidth_->value();
}

PitchPointer NoteRect::pitch(const waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const
{
    return aEditAreaInformation->calculatePitch(mPosition_->y());
}

NoteRectHeightPointer NoteRect::height() const
{
    return mHeight_;
}

NoteRectPositionPointer NoteRect::position() const
{
    return mPosition_;
}

NoteRectPositionPointer NoteRect::center() const
{
    return NoteRectPositionPointer(
                new NoteRectPosition(
                    mPosition_->x() + mWidth_->value() / 2,
                    mPosition_->y() + mHeight_->value() / 2));
}
