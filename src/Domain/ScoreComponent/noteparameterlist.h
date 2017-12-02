#ifndef NOTEPARAMETERLIST_H
#define NOTEPARAMETERLIST_H

#include <QList>
#include "abstractnoteparameter.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class NoteParameterList
            {
            public:
                NoteParameterList();
                void append(const NoteParameterPointer aNoteParameter);

            private:
                QList <NoteParameterPointer> mNoteParameterList_;


            private:
                NoteParameterList(const NoteParameterList& aOther);
                NoteParameterList& operator=(const NoteParameterList& aOtehr);
            };

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTEPARAMETERLIST_H
