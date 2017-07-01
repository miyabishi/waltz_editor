#ifndef UPDATELIBRARYINFORMATIONCOMMAND_H
#define UPDATELIBRARYINFORMATIONCOMMAND_H

#include "command.h"

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class UpdateLibraryInformationCommand : public Command
            {
            public:
                UpdateLibraryInformationCommand();
            public:
                void exec(const Parameters& aParameters);
            };
        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // UPDATELIBRARYINFORMATIONCOMMAND_H
