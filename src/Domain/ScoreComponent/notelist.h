#ifndef NOTELIST_H
#define NOTELIST_H

#include<QList>
#include "src/Domain/Commands/parameters.h"
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
                void append(Note aNote);
                waltz::editor::Commands::Parameters toParameters() const;

            private:
                QList<Note> mNoteList_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTELIST_H
