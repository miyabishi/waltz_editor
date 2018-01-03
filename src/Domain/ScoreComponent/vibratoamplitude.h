#ifndef VIBRATOAMPLITUDE_H
#define VIBRATOAMPLITUDE_H

#include <waltz_common/parameter.h>
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
                explicit VibratoAmplitude(const double aValue);
                ~VibratoAmplitude();

                common::Commands::Parameter toParameter() const;

            private:
                common::Commands::Parameter& mParameter_;

            private:
                VibratoAmplitude(const VibratoAmplitude& aOther);
                VibratoAmplitude& operator=(const VibratoAmplitude& aOther);
            };
            typedef QSharedPointer<VibratoAmplitude> VibratoAmplitudePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOAMPLITUDE_H
