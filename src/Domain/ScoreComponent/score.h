#ifndef PROJECT_H
#define PROJECT_H

#include <memory>
#include <waltz_common/parameters.h>
#include "src/Model/editareainformation.h"
#include "notelist.h"
#include "tempo.h"
#include "beat.h"
#include "note.h"

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
                Tempo  tempo() const;
                void setBeatParent(int aBeatParent);
                void setBeatChild(int aBeatChild);
                Beat beat();
                int beatChild();
                int beatParent();
                NoteListPointer noteList() const;
                void appendNote(const NotePointer aNote);
                void updateNote(const NotePointer aNote);
                waltz::common::Commands::Parameters toParameters(const model::EditAreaInformationPointer aEditAreaInformation);
                int noteCount() const;

            private:
                Tempo mTempo_;
                Beat  mBeat_;
                NoteListPointer mNoteList_;
            };
            typedef std::shared_ptr<Score> ScorePointer;
        }
    }
}
#endif // PROJECT_H
