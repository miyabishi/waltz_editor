#ifndef NOTELENGTH_H
#define NOTELENGTH_H

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
                NoteLength(const NoteLength& aOther);
                NoteLength& operator=(const NoteLength& aOther);

                double value() const;

            private:
                double mSec_;
            };
        } // ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTELENGTH_H
