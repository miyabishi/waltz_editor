#ifndef PITCH_H
#define PITCH_H

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
                Pitch(const Pitch& aOther);

                Pitch& operator=(const Pitch& aOther);

                Tone tone() const;
                int octave() const;

            private:
                Tone mTone_;
                int mOctave_;

            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCH_H
