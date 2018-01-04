#ifndef VIBRATOAMPLITUDE_H
#define VIBRATOAMPLITUDE_H

#include <waltz_common/parameter.h>
#include <QSharedPointer>
#include "tempo.h"
#include "beat.h"
#include "src/Model/editareainformation.h"
#include "abstractnoteparameter.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoAmplitude : public AbstractNoteParameter
            {
            public:
                explicit VibratoAmplitude(const double aValue);
                ~VibratoAmplitude();

                common::Commands::Parameter toParameter(Beat aBeat,
                                                        Tempo aTempo,
                                                        model::EditAreaInformationPointer aEditAreaInformation) const;

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
