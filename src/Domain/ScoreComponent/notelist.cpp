#include <QDebug>

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
        waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const
{
    QJsonArray noteListArray;
    QList<NotePointer> noteList = mNoteList_;

    qSort(noteList.begin(), noteList.end(), noteStartTimeLessThan);
    foreach(const NotePointer note, noteList)
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

NotePointer NoteList::at(int aIndex) const
{
    return mNoteList_.at(aIndex);
}

NotePointer NoteList::find(const NoteId& aNoteId) const
{
    for (int index = 0; index < mNoteList_.size(); ++index)
    {
        if (! mNoteList_.at(index)->noteIdEquals(aNoteId)) continue;
        return mNoteList_.at(index);
    }
    return NotePointer();
}

void NoteList::clearNote()
{
    mNoteList_.clear();
}

NotePointer NoteList::findPreviousNote(const NoteRectPositionPointer aNoteRectPosition,
                                       const NoteId aCurrentNoteId) const
{
    if (mNoteList_.size() == 0) return NotePointer();
    if (mNoteList_.size() == 1) return mNoteList_.first();

    QList<NotePointer> noteList = mNoteList_;
    qSort(noteList.begin(), noteList.end(), noteStartTimeLessThan);

    // ノートが先頭だった場合
    if (noteList.first()->noteIdEquals(aCurrentNoteId)) return NotePointer();

    for (int index = 1; index < mNoteList_.size(); ++index)
    {
        if (noteList.at(index)->xPosition() < aNoteRectPosition->x()) continue;
        return noteList.at(index - 1);
    }

    return noteList.last();
}

