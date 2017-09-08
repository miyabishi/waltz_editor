#ifndef ACTIVEPLAYBUTTONCOMMAND_H
#define ACTIVEPLAYBUTTONCOMMAND_H

#include <waltz_common/command.h>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class ActivePlayButtonCommand : public waltz::common::Commands::Command
            {
            public:
                ActivePlayButtonCommand();
            public:
                void exec(const waltz::common::Commands::Parameters& aParameters);
            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // ACTIVEPLAYBUTTONCOMMAND_H
