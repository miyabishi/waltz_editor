#ifndef NOTERECTWIDTH_H
#define NOTERECTWIDTH_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class NoteRectWidth
            {
            public:
                explicit NoteRectWidth(const int aValue);
            public:
                int value() const;

            private:
                int mValue_;

            private:
                NoteRectWidth(const NoteRectWidth& aOther);
                NoteRectWidth& operator=(const NoteRectWidth& aOther);
            };
            typedef QSharedPointer<NoteRectWidth> NoteRectWidthPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTERECTWIDTH_H
