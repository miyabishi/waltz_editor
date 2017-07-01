#ifndef COMMANDFACTORY_H
#define COMMANDFACTORY_H

#include "command.h"

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class CommandId;
            class CommandFactory
            {
            public:
                static CommandPointer createCommand(const CommandId& aCommandId);
            private:
                CommandFactory();
            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // COMMANDFACTORY_H
