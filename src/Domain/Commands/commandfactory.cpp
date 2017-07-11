#include "commandfactory.h"
#include <waltz_common/commandid.h>
#include "updatelibraryinformationcommand.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;

namespace
{
    const CommandId UPDATE_LIBRARY_INFORMATION_ID("UpdateLibraryInformation");
}

CommandPointer CommandFactory::createCommand(const CommandId& aCommandId)
{
    if(aCommandId == UPDATE_LIBRARY_INFORMATION_ID)
    {
        return CommandPointer(new UpdateLibraryInformationCommand());
    }
    return CommandPointer();
}

CommandFactory::CommandFactory()
{
}

