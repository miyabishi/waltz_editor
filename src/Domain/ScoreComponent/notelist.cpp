#include "notelist.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

NoteList::NoteList()
{

}

void NoteList::append(Note aNote)
{
    mNoteList_.append(aNote);
}

Parameter NoteList::toParameter() const
{
    QJsonArray noteListArray;
    foreach(Note note, mNoteList_)
    {
        noteListArray.append(note.toParameters().toJsonArray());
    }
    return    Parameter("NoteList",noteListArray);
}
