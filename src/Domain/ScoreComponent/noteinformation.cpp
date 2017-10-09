#include "noteinformation.h"

using namespace waltz::editor::ScoreComponent;

NoteInformation::NoteInformation(int            aNoteId,
                                 const QString& aNoteText,
                                 int            aPositionX,
                                 int            aPositionY,
                                 int            aNoteWidth,
                                 int            aNoteHeight)
    : mNoteId_(aNoteId)
    , mNoteText_(aNoteText)
    , mPositionX_(aPositionX)
    , mPositionY_(aPositionY)
    , mNoteWidth_(aNoteWidth)
    , mNoteHeight_(aNoteHeight)
{
}

NotePointer NoteInformation::note(const PortamentoInformationPointer aPortamentoInforamtion,
                                  const VibratoInformationPointer aVibratoInformation) const
{
    return NotePointer(new Note(noteId(),
                                syllable(),
                                noteRect(),
                                aPortamentoInforamtion->portamento(),
                                aVibratoInformation->vibrato()));
}

NoteId NoteInformation::noteId() const
{
    return NoteId(mNoteId_);
}

Syllable NoteInformation::syllable() const
{
    return Syllable(mNoteText_);
}


NoteRectPointer NoteInformation::noteRect() const
{
    return NoteRectPointer(
                new NoteRect(NoteRectPositionPointer(
                                 new NoteRectPosition(mPositionX_,mPositionY_)),
                             NoteRectWidthPointer(
                                 new NoteRectWidth(mNoteWidth_)),
                             NoteRectHeightPointer(
                                 new NoteRectHeight(mNoteHeight_))));
}
