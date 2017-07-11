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

Parameters NoteList::toParameters() const
{
    Parameters parameters;
    QJsonArray noteListArray;
    foreach(Note note, mNoteList_)
    {
        noteListArray.append(note.toParameters().toJsonArray());
    }

    parameters.append(
                Parameter("NoteList",
                          noteListArray));
    return parameters;
}
