#ifndef VIBRATOINFORMATION_H
#define VIBRATOINFORMATION_H

#include <QSharedPointer>
#include "vibrato.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoInformation
            {
            public:
                VibratoInformation(double aVibratoAmplitude,
                                   int aVibratoFrequency,
                                   int aVibratoLength);
                VibratoPointer vibrato() const;
            private:
                double mVibratoAmplitude_;
                int mVibratoFequency_;
                int    mVibratoLength_;

            private:
                VibratoInformation(const VibratoInformation& aOther);
                VibratoInformation& operator=(const VibratoInformation& aOther);
            };
            typedef QSharedPointer<VibratoInformation> VibratoInformationPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOINFORMATION_H
