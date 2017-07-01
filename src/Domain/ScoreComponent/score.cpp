#include "score.h"
#include "notelist.h"

using namespace waltz::editor::ScoreComponent;

Score::Score()
 : mTempo_(Tempo(120))
 , mBeat_(Beat(4,4))
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

void Score::appendNote(const Note& aNote)
{
    mNoteList_.append(aNote);
}
