#ifndef NOTESTARTTIME_H
#define NOTESTARTTIME_H


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
                NoteStartTime(const NoteStartTime& aOther);
                NoteStartTime& operator=(const NoteStartTime& aOther);

                double value() const;

            private:
                double mSec_;

            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTESTARTTIME_H
