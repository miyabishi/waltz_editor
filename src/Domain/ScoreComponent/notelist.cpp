#include "notelist.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

namespace
{
    bool noteStartTimeLessThan(const Note& aNoteA,const Note& aNoteB)
    {
        return aNoteA.noteStartTime().value() < aNoteB.noteStartTime().value();
    }
}

NoteList::NoteList()
{

}

void NoteList::append(const Note& aNote)
{
    mNoteList_.append(aNote);
}

Parameter NoteList::toParameter()
{
    QJsonArray noteListArray;
    qSort(mNoteList_.begin(), mNoteList_.end(), noteStartTimeLessThan);
    foreach(Note note, mNoteList_)
    {
        noteListArray.append(note.toParameters().toJsonArray());
    }
    return Parameter("NoteList",noteListArray);
}

void NoteList::updateNote(const Note& aNote)
{
    mNoteList_.removeOne(aNote);
    append(aNote);
}
