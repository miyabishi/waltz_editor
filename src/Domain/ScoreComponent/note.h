#ifndef NOTE_H
#define NOTE_H

#include <memory>
#include "pitch.h"
#include "syllable.h"
#include "notestarttime.h"
#include "notelength.h"

namespace waltz
{
    namespace  common
    {
        namespace Commands
        {
            class Parameters;
        }
    }
    namespace editor
    {
        namespace ScoreComponent
        {
            class Note
            {
            public:
                Note(Pitch aPitch,
                     Syllable aSyllable,
                     NoteStartTime aNoteStartTime,
                     NoteLength mNoteLength_);
                Note(const Note& aOther);
                Note& operator=(const Note& aOther);

            public:
                waltz::common::Commands::Parameters toParameters() const;

            private:
                Pitch         mPitch_;
                Syllable      mSyllable_;
                NoteStartTime mNoteStartTime_;
                NoteLength    mNoteLength_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz
#endif // NOTE_H
