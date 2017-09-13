#include "notelist.h"
using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME_NOTE_LIST = "NoteList";

    bool noteStartTimeLessThan(const NotePointer aNoteA,const NotePointer aNoteB)
    {
        return aNoteA->xPosition() < aNoteB->xPosition();
    }
}

NoteList::NoteList()
{
}
int NoteList::findNotePositionX(int aIndex) const
{
    return mNoteList_.at(aIndex)->xPosition();
}

int NoteList::count() const
{
    return mNoteList_.count();
}

void NoteList::append(const NotePointer aNote)
{
    foreach(const NotePointer note, mNoteList_)
    {
        if(note->xPositionIs(aNote->xPosition())) return;
    }

    mNoteList_.append(aNote);
}

Parameter NoteList::toParameter(
        Beat aBeat,
        Tempo aTempo,
        waltz::editor::model::EditAreaInformationPointer aEditAreaInformation)
{
    QJsonArray noteListArray;
    qSort(mNoteList_.begin(), mNoteList_.end(), noteStartTimeLessThan);
    foreach(const NotePointer note, mNoteList_)
    {
        noteListArray.append(note->toParameters(aBeat, aTempo, aEditAreaInformation).toJsonArray());
    }
    return Parameter(PARAMETER_NAME_NOTE_LIST, noteListArray);
}

void NoteList::updateNote(const NotePointer aNote)
{
    for (int index = 0; index < mNoteList_.size(); ++index)
    {
        if (! mNoteList_.at(index)->noteIdEquals(aNote->noteId())) continue;
        mNoteList_.removeAt(index);
        break;
    }
    append(aNote);
}
