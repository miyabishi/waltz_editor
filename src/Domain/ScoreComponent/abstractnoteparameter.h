#ifndef ABSTRACTNOTEPARAMETER_H
#define ABSTRACTNOTEPARAMETER_H

#include <QSharedPointer>
#include <waltz_common/parameter.h>

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
            public:
                virtual common::Commands::Parameter toParameter() const = 0;

            private:
                AbstractNoteParameter(const AbstractNoteParameter& aOther);
                AbstractNoteParameter& operator=(const AbstractNoteParameter& aOther);
            };
            typedef QSharedPointer<AbstractNoteParameter> NoteParameterPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // ABSTRACTNOTEPARAMETER_H
