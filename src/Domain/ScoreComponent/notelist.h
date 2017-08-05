#ifndef NOTELIST_H
#define NOTELIST_H

#include<QList>
#include<waltz_common/parameters.h>
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
                void append(const Note& aNote);
                waltz::common::Commands::Parameter toParameter();
                void updateNote(const Note& aNote);

            private:
                QList<Note> mNoteList_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTELIST_H
