#ifndef VIBRATOLENGTH_H
#define VIBRATOLENGTH_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>
#include "abstractnoteparameter.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoLength : public AbstractNoteParameter
            {
            public:
                explicit VibratoLength(const int aValue);
                ~VibratoLength();

                common::Commands::Parameter toParameter(Beat aBeat,
                                                        Tempo aTempo,
                                                        model::EditAreaInformationPointer aEditAreaInformation) const;
            private:
                int mValue_;

            private:
                VibratoLength(VibratoLength& aOther);
                VibratoLength& operator=(VibratoLength& aOther);
            };
            typedef QSharedPointer<VibratoLength> VibratoLengthPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOLENGTH_H
