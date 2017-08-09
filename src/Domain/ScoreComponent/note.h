#ifndef NOTE_H
#define NOTE_H

#include <memory>
#include "pitch.h"
#include "syllable.h"
#include "notestarttime.h"
#include "notelength.h"
#include "noteid.h"

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
                Note(const NoteId& aNoteId,
                     const Pitch& aPitch,
                     const Syllable& aSyllable,
                     const NoteStartTime& aNoteStartTime,
                     const NoteLength& mNoteLength_);
                Note(const Note& aOther);
                Note& operator=(const Note& aOther);
                bool operator==(const Note& aOther) const;
                bool operator!=(const Note& aOther) const;

            public:
                waltz::common::Commands::Parameters toParameters() const;
                NoteStartTime noteStartTime() const;

            private:
                NoteId        mNoteId_;
                Pitch         mPitch_;
                Syllable      mSyllable_;
                NoteStartTime mNoteStartTime_;
                NoteLength    mNoteLength_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz
#endif // NOTE_H
