#include "notelist.h"

using namespace waltz::editor::ScoreComponent;

NoteList::NoteList()
{

}

void NoteList::append(Note aNote)
{
    mNoteList_ << aNote;
}
