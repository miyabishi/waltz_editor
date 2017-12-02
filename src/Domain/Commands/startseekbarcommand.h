#ifndef STARTSEEKBARCOMMAND_H
#define STARTSEEKBARCOMMAND_H

#include <waltz_common/command.h>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {

            class StartSeekBarCommand : public common::Commands::Command
            {
            public:
                StartSeekBarCommand();
            public:
                void exec(const waltz::common::Commands::Parameters& aParameters);
            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // STARTSEEKBARCOMMAND_H
