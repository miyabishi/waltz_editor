#ifndef PITCH_H
#define PITCH_H

#include <QSharedPointer>
#include "domaindef.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Pitch
            {
            public:
                Pitch(Tone aTone, int aOctave);
            public:
                Tone tone() const;
                int octave() const;

            private:
                Tone mTone_;
                int mOctave_;

            private:
                Pitch(const Pitch& aOther);
                Pitch& operator=(const Pitch& aOther);
            };
            typedef QSharedPointer<Pitch> PitchPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCH_H
