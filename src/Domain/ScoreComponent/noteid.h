#ifndef NOTEID_H
#define NOTEID_H

#include <QDebug>
namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class NoteId
            {
            public:
                NoteId(const int aValue);
                NoteId(const NoteId& aOther);
                NoteId& operator=(const NoteId& aOther);
                int value() const;
                bool operator==(const NoteId& aOther) const;
                bool operator!=(const NoteId& aOther) const;

            private:
                int mValue_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTEID_H