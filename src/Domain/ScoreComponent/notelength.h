#ifndef NOTELENGTH_H
#define NOTELENGTH_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteLength
            {
            public:
                explicit NoteLength(double aSec);
                double value() const;

            private:
                double mSec_;

            private:
                NoteLength(const NoteLength& aOther);
                NoteLength& operator=(const NoteLength& aOther);
            };
            typedef QSharedPointer<NoteLength> NoteLengthPointer;

        } // ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTELENGTH_H
