#ifndef PROJECT_H
#define PROJECT_H

#include <memory>
#include <waltz_common/parameters.h>
#include "src/Model/editareainformation.h"
#include "abstractnoteparameter.h"
#include "notelist.h"
#include "tempo.h"
#include "beat.h"
#include "note.h"
#include "noteid.h"
#include "pitchcurve.h"
#include "pitchchangingpoint.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Score
            {
            public:
                Score();

                void setTempo(int aTempo);
                Tempo tempo() const;
                void setBeatParent(int aBeatParent);
                void setBeatChild(int aBeatChild);
                Beat beat();
                int beatChild();
                int beatParent();
                NoteListPointer noteList() const;
                void appendNote(const NotePointer aNote);
                void appendNoteParameter(const NoteId aNoteId,
                                         const NoteParameterPointer aParameter);
                void appendPitchChangingPoint(const PitchChangingPointPointer aPitchChangingPoint);
                waltz::common::Commands::Parameters toParameters(const model::EditAreaInformationPointer aEditAreaInformation);
                int noteCount() const;
                void clearScore();

            private:
                void clearNote();
                void clearPitchCurve();

            private:
                Tempo mTempo_;
                Beat  mBeat_;
                NoteListPointer mNoteList_;
                PitchCurvePointer mPitchCurve_;
            };
            typedef std::shared_ptr<Score> ScorePointer;
        }
    }
}
#endif // PROJECT_H
