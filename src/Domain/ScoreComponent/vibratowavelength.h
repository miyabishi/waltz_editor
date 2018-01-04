#ifndef VIBRATOWAVELENGTH_H
#define VIBRATOWAVELENGTH_H

#include <waltz_common/parameter.h>
#include <QSharedPointer>
#include "abstractnoteparameter.h"
#include "src/Model/editareainformation.h"
#include "beat.h"
#include "tempo.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class VibratoWavelength : public AbstractNoteParameter
            {
            public:
                explicit VibratoWavelength(const int aValue);
                ~VibratoWavelength();

                common::Commands::Parameter toParameter(Beat aBeat,
                                                        Tempo aTempo,
                                                        model::EditAreaInformationPointer aEditAreaInformation) const;
            private:
                int mValue_;

            private:
                VibratoWavelength(const VibratoWavelength& aOther);
                VibratoWavelength& operator=(const VibratoWavelength& aOther);
            };
            typedef QSharedPointer<VibratoWavelength> VibratoWavelengthPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOWAVELENGTH_H
