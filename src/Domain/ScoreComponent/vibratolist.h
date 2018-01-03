#ifndef VIBRATOLIST_H
#define VIBRATOLIST_H

#include <QSharedPointer>
#include <QList>
#include "waltz_common/parameter.h"
#include "beat.h"
#include "tempo.h"
#include "src/Model/editareainformation.h"
#include "vibrato.h"


namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoList
            {
            public:
                VibratoList();
                void append(const VibratoPointer aVibrato);
                void clearVibrato();
                common::Commands::Parameter toParameter(const Beat aBeat,
                                                        const Tempo aTempo,
                                                        const model::EditAreaInformationPointer aEditAreaInfromation) const;

            private:
                QList<VibratoPointer> mVibratoList_;

            private:
                VibratoList(const VibratoList& aOther);
                VibratoList& operator=(const VibratoList& aOther);
            };
            typedef QSharedPointer<VibratoList> VibratoListPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOLIST_H
