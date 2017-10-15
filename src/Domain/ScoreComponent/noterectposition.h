#ifndef NOTERECTPOSITION_H
#define NOTERECTPOSITION_H

#include <QSharedPointer>
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteRectPosition : public Point
            {
            public:
                NoteRectPosition(const int aX,
                                 const int aY);



            private:
                NoteRectPosition(const NoteRectPosition& aOther);
                NoteRectPosition& operator=(const NoteRectPosition& aOther);
            };
            typedef QSharedPointer<NoteRectPosition> NoteRectPositionPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTERECTPOSITION_H
