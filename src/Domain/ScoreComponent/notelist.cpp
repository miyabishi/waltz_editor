#include "notelist.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    const QString PARAMETER_NAME_NOTE_LIST = "NoteList";

    bool noteStartTimeLessThan(const Note& aNoteA,const Note& aNoteB)
    {
        return aNoteA.noteStartTime().value() < aNoteB.noteStartTime().value();
    }
}

NoteList::NoteList()
{
}
NoteStartTime NoteList::findNoteStartTime(int aIndex) const
{
    return mNoteList_.at(aIndex).noteStartTime();
}

int NoteList::count() const
{
    return mNoteList_.count();
}
void NoteList::append(const Note& aNote)
{
    foreach(const Note& note, mNoteList_)
    {
        if(note.noteStartTime().value() == aNote.noteStartTime().value())
        {
            return;
        }
    }

    mNoteList_.append(aNote);
}

Parameter NoteList::toParameter()
{
    QJsonArray noteListArray;
    qSort(mNoteList_.begin(), mNoteList_.end(), noteStartTimeLessThan);
    foreach(const Note& note, mNoteList_)
    {
        noteListArray.append(note.toParameters().toJsonArray());
    }
    return Parameter(PARAMETER_NAME_NOTE_LIST,noteListArray);
}

void NoteList::updateNote(const Note& aNote)
{
    mNoteList_.removeOne(aNote);
    append(aNote);
}
