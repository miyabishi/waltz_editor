#ifndef ABSTRACTNOTEPARAMETER_H
#define ABSTRACTNOTEPARAMETER_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>
#include "tempo.h"
#include "beat.h"
#include "src/Model/editareainformation.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class AbstractNoteParameter
            {
            public:
                AbstractNoteParameter();
                virtual ~AbstractNoteParameter();

            public:
                virtual common::Commands::Parameter toParameter(Beat aBeat,
                                                                Tempo aTempo,
                                                                waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const = 0;

            private:
                AbstractNoteParameter(const AbstractNoteParameter& aOther);
                AbstractNoteParameter& operator=(const AbstractNoteParameter& aOther);
            };
            typedef QSharedPointer<AbstractNoteParameter> NoteParameterPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // ABSTRACTNOTEPARAMETER_H
