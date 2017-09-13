#ifndef NOTERECTPOSITION_H
#define NOTERECTPOSITION_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteRectPosition
            {
            public:
                NoteRectPosition(const int aX,
                                 const int aY);
                int x() const;
                int y() const;

            private:
                int mX_;
                int mY_;

            private:
                NoteRectPosition(const NoteRectPosition& aOther);
                NoteRectPosition& operator=(const NoteRectPosition& aOther);
            };
            typedef QSharedPointer<NoteRectPosition> NoteRectPositionPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTERECTPOSITION_H
