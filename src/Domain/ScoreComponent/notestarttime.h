#ifndef NOTESTARTTIME_H
#define NOTESTARTTIME_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class NoteStartTime
            {
            public:
                explicit NoteStartTime(double aSec);
                double value() const;

            private:
                double mSec_;

            private:
                NoteStartTime(const NoteStartTime& aOther);
                NoteStartTime& operator=(const NoteStartTime& aOther);
            };
            typedef QSharedPointer<NoteStartTime> NoteStartTimePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTESTARTTIME_H
