#ifndef VIBRATOLENGTH_H
#define VIBRATOLENGTH_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoLength
            {
            public:
                explicit VibratoLength(const double aValue);
                ~VibratoLength();

                common::Commands::Parameter toParameter() const;

            private:
                common::Commands::Parameter& mParameter_;

            private:
                VibratoLength(VibratoLength& aOther);
                VibratoLength& operator=(VibratoLength& aOther);
            };
            typedef QSharedPointer<VibratoLength> VibratoLengthPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOLENGTH_H
