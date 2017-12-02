#include "noteparameterlist.h"

using namespace waltz::editor::ScoreComponent;

NoteParameterList::NoteParameterList()
{
}

void NoteParameterList::append(const NoteParameterPointer aNoteParameter)
{
    mNoteParameterList_.append(aNoteParameter);
}

