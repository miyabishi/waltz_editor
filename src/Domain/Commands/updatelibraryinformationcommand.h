#ifndef UPDATELIBRARYINFORMATIONCOMMAND_H
#define UPDATELIBRARYINFORMATIONCOMMAND_H

#include <waltz_common/command.h>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class UpdateLibraryInformationCommand : public waltz::common::Commands::Command
            {
            public:
                UpdateLibraryInformationCommand();
            public:
                void exec(const waltz::common::Commands::Parameters& aParameters);
            };
        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // UPDATELIBRARYINFORMATIONCOMMAND_H
