#ifndef NOTERECTHEIGHT_H
#define NOTERECTHEIGHT_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteRectHeight
            {
            public:
                NoteRectHeight(int aValue);
                int value() const;
                int center() const;

            private:
                int mValue_;

            };
            typedef QSharedPointer<NoteRectHeight> NoteRectHeightPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTERECTHEIGHT_H
