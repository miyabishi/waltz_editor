#ifndef COMMANDFACTORY_H
#define COMMANDFACTORY_H

#include <QList>
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
                static CommandFactory& getInstance();
                waltz::common::Commands::CommandPointer createCommand(
                        const waltz::common::Commands::CommandId& aCommandId);
            private:
                CommandFactory();
                QList<waltz::common::Commands::CommandPointer> mCommandList_;
                static CommandFactory* mInstance_;
            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // COMMANDFACTORY_H
