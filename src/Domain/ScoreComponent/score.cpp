#include "score.h"
#include <QDebug>

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

Score::Score()
 : mTempo_(Tempo(120))
 , mBeat_(Beat(4,4))
 , mNoteList_(new NoteList())
{
}

void Score::setTempo(int aTempo)
{
    mTempo_ = Tempo(aTempo);
}

Tempo Score::tempo() const
{
    return mTempo_;
}

void Score::setBeatParent(int aBeatParent)
{
    mBeat_ = mBeat_.changeParent(aBeatParent);
}

void Score::setBeatChild(int aBeatChild)
{
    mBeat_ = mBeat_.changeChild(aBeatChild);
}

int Score::beatChild()
{
    return mBeat_.childValue();
}

int Score::beatParent()
{
    return mBeat_.parentValue();
}

Beat Score::beat()
{
    return mBeat_;
}

Parameters Score::toParameters(const model::EditAreaInformationPointer aEditAreaInformation)
{
    Parameters parameters;
    parameters.append(mNoteList_->toParameter(mBeat_, mTempo_, aEditAreaInformation));
    return parameters;
}

void Score::appendNote(const NotePointer aNote)
{
    mNoteList_->append(aNote);
}

void Score::updateNote(const NotePointer aNote)
{
    mNoteList_->updateNote(aNote);
}

int Score::noteCount() const
{
    return mNoteList_->count();
}

NoteListPointer Score::noteList() const
{
    return mNoteList_;
}

int Score::findNotePositionX(int aIndex) const
{
    return mNoteList_->findNotePositionX(aIndex);
}
