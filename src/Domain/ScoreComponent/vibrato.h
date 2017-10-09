#ifndef VIBRATO_H
#define VIBRATO_H

#include <QSharedPointer>
#include "vibratoamplitude.h"
#include "vibratolength.h"
#include "vibratofrequency.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Vibrato
            {
            public:
                Vibrato(const VibratoAmplitudePointer aAmplitude,
                        const VibratoFrequencyPointer aFrequency,
                        const VibratoLengthPointer    aLength);

            private:
                VibratoAmplitudePointer mAmplitude_;
                VibratoFrequencyPointer mFrequency_;
                VibratoLengthPointer    mLength_;

            private:
                Vibrato(const Vibrato& aOther);
                Vibrato& operator=(const Vibrato& aOther);
            };
            typedef QSharedPointer<Vibrato> VibratoPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATO_H
