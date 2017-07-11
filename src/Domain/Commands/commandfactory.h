#ifndef COMMANDFACTORY_H
#define COMMANDFACTORY_H

#include <waltz_common/command.h>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class CommandFactory
            {
            public:
                static waltz::common::Commands::CommandPointer createCommand(
                        const waltz::common::Commands::CommandId& aCommandId);
            private:
                CommandFactory();
            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // COMMANDFACTORY_H
