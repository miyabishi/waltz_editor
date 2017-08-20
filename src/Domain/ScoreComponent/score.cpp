#include "score.h"
#include <QDebug>

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

Score::Score()
 : mTempo_(Tempo(120))
 , mBeat_(Beat(4,4))
 , mNoteList_()
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

Parameters Score::toParameters()
{
    Parameters parameters;
    parameters.append(mNoteList_.toParameter());
    return parameters;
}

void Score::appendNote(const Note& aNote)
{
    mNoteList_.append(aNote);
}
void Score::updateNote(const Note& aNote)
{
    mNoteList_.updateNote(aNote);
}

int Score::noteCount() const
{
    return mNoteList_.count();
}

NoteStartTime Score::findNoteStartTime(int aIndex) const
{
    return mNoteList_.findNoteStartTime(aIndex);
}
