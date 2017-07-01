#ifndef NOTELIST_H
#define NOTELIST_H

#include<QList>
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

            private:
                QList<Note> mNoteList_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTELIST_H
