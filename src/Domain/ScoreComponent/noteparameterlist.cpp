#include "noteparameterlist.h"

using namespace waltz::editor::ScoreComponent;

NoteParameterList::NoteParameterList()
{
}

void NoteParameterList::append(const NoteParameterPointer aNoteParameter)
{
    mNoteParameterList_.append(aNoteParameter);
}

int NoteParameterList::count() const
{
    return mNoteParameterList_.count();
}

NoteParameterPointer NoteParameterList::at(int index) const
{
    return mNoteParameterList_.at(index);
}

