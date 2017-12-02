#ifndef NOTELIST_H
#define NOTELIST_H

#include <QSharedPointer>
#include <QList>
#include <waltz_common/parameters.h>

#include "src/Model/editareainformation.h"
#include "beat.h"
#include "tempo.h"
#include "note.h"
#include "noteid.h"
#include "noterectposition.h"
#include "abstractnoteparameter.h"

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
                        waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const;
                void updateNote(const NotePointer aNote);
                int count() const;
                NotePointer at(int aIndex) const;
                NotePointer find(const NoteId& aNoteId) const;
                NotePointer findPreviousNote(const NoteRectPositionPointer aNoteRect,
                                             const NoteId aCurrentNoteId = NoteId(-1)) const;
                void clearNote();
                void appendNoteParameter(const NoteId aNoteId,
                                         const NoteParameterPointer aNoteParameter) const;

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
