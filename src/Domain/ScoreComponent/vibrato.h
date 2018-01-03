#ifndef VIBRATO_H
#define VIBRATO_H

#include <QSharedPointer>
#include <waltz_common/parameters.h>
#include "vibratoform.h"
#include "noteid.h"
#include "beat.h"
#include "tempo.h"
#include "src/Model/editareainformation.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Vibrato
            {
            public:
                Vibrato(const NoteId aNoteId,
                        const VibratoFormPointer aVibratoForm);

                common::Commands::Parameters toParameters(const Beat aBeat,
                                                          const Tempo aTempo,
                                                          const model::EditAreaInformationPointer aEditAreaInformation) const;
            private:
                NoteId mNoteId_;
                VibratoFormPointer mVibratoForm_;

            private:
                Vibrato(const Vibrato& aOther);
                Vibrato& operator=(const Vibrato& aOther);
            };
            typedef QSharedPointer<Vibrato> VibratoPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATO_H
