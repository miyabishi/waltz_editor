#ifndef NOTEFACTORY_H
#define NOTEFACTORY_H

#include <QSharedPointer>
#include "note.h"
#include "notelist.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteFactory
            {
            public:
                NoteFactory();

            public:
                NotePointer create(int aNoteId,
                                   const QString& aNoteText,
                                   int aPositionX,
                                   int aPositionY,
                                   int aNoteWidth,
                                   int aNoteHeight,
                                   const NoteListPointer aNoteList);
            private:
                NoteFactory(const NoteFactory& aOther);
                NoteFactory& operator=(const NoteFactory& aOther);
            };
            typedef QSharedPointer<NoteFactory> NoteFactoryPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTEFACTORY_H
