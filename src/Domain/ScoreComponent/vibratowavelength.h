#ifndef VIBRATOWAVELENGTH_H
#define VIBRATOWAVELENGTH_H

#include <QSharedPointer>

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

            private:
                double mValue_;

            private:
                VibratoWavelength(const VibratoWavelength& aOther);
                VibratoWavelength& operator=(const VibratoWavelength& aOther);
            };
            typedef QSharedPointer<VibratoWavelength> VibratoWavelengthPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOWAVELENGTH_H
