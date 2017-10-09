#ifndef VIBRATOAMPLITUDE_H
#define VIBRATOAMPLITUDE_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoAmplitude
            {
            public:
                VibratoAmplitude(const double aValue);

            private:
                double mValue_;

            private:
                VibratoAmplitude(const VibratoAmplitude& aOther);
                VibratoAmplitude& operator=(const VibratoAmplitude& aOther);
            };
            typedef QSharedPointer<VibratoAmplitude> VibratoAmplitudePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOAMPLITUDE_H
