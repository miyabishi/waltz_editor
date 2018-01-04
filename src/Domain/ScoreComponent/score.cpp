#include "score.h"

using namespace waltz::editor::ScoreComponent;
using namespace waltz::common::Commands;

Score::Score()
 : mTempo_(Tempo(120))
 , mBeat_(Beat(4,4))
 , mNoteList_(new NoteList())
 , mPitchCurve_(new PitchCurve())
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
    parameters.append(mPitchCurve_->toParameter(mBeat_, mTempo_, aEditAreaInformation));

    return parameters;
}

void Score::appendNote(const NotePointer aNote)
{
    mNoteList_->append(aNote);
}

void Score::appendPitchChangingPoint(const PitchChangingPointPointer aPitchChangingPoint)
{
    mPitchCurve_->appendChangingPoint(aPitchChangingPoint);
}

void Score::appendNoteParameter(const NoteId aNoteId, const NoteParameterPointer aParameter)
{
    mNoteList_->appendNoteParameter(aNoteId, aParameter);
}

int Score::noteCount() const
{
    return mNoteList_->count();
}

void Score::clearScore()
{
    mNoteList_->clearNote();
    mPitchCurve_->clearPitchCurve();
}

NoteListPointer Score::noteList() const
{
    return mNoteList_;
}
