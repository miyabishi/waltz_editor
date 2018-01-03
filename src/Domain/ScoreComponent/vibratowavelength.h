#ifndef VIBRATOWAVELENGTH_H
#define VIBRATOWAVELENGTH_H

#include <waltz_common/parameter.h>
#include <QSharedPointer>
#include "beat.h"
#include "tempo.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class VibratoWavelength
            {
            public:
                explicit VibratoWavelength(const double aSec);
                ~VibratoWavelength();

                common::Commands::Parameter toParameter() const;
            private:
                common::Commands::Parameter& mParameter_;

            private:
                VibratoWavelength(const VibratoWavelength& aOther);
                VibratoWavelength& operator=(const VibratoWavelength& aOther);
            };
            typedef QSharedPointer<VibratoWavelength> VibratoWavelengthPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOWAVELENGTH_H
