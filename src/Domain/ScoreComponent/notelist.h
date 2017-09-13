#ifndef NOTELIST_H
#define NOTELIST_H

#include <QSharedPointer>
#include <QList>
#include <waltz_common/parameters.h>

#include "src/Model/editareainformation.h"
#include "beat.h"
#include "tempo.h"
#include "note.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteList
            {
            public:
                NoteList();
                void append(const NotePointer aNote);
                waltz::common::Commands::Parameter toParameter(
                        Beat aBeat,
                        Tempo aTempo,
                        waltz::editor::model::EditAreaInformationPointer aEditAreaInformation);
                void updateNote(const NotePointer aNote);
                int count() const;
                int findNotePositionX(int index) const;

            private:
                QList<NotePointer> mNoteList_;
            private:
                NoteList(const NoteList& aOtehr);
                NoteList& operator=(const NoteList& aOtehr);
            };
            typedef QSharedPointer<NoteList> NoteListPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTELIST_H
