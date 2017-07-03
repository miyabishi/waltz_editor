#ifndef PROJECT_H
#define PROJECT_H

#include <memory>
#include "notelist.h"
#include "tempo.h"
#include "beat.h"
#include "note.h"
#include "src/Domain/Commands/parameters.h"

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
                NoteList noteList();
                void appendNote(const Note& aNote);
                waltz::editor::Commands::Parameters toParameters() const;

            private:
                Tempo mTempo_;
                Beat  mBeat_;
                NoteList mNoteList_;
            };
            typedef std::shared_ptr<Score> ScorePointer;
        }
    }
}
#endif // PROJECT_H
