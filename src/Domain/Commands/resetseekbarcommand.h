#ifndef RESETSEEKBARCOMMAND_H
#define RESETSEEKBARCOMMAND_H

#include <waltz_common/command.h>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class ResetSeekBarCommand : public common::Commands::Command
            {
            public:
                ResetSeekBarCommand();

            public:
                void exec(const waltz::common::Commands::Parameters& aParameters);

            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // RESETSEEKBARCOMMAND_H
