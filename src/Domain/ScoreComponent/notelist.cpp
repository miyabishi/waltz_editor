#include "notelist.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::editor::Commands;

NoteList::NoteList()
{

}

void NoteList::append(Note aNote)
{
    mNoteList_.append(aNote);
}

Parameters NoteList::toParameters() const
{
}
