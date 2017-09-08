#include "commandfactory.h"
#include <waltz_common/commandid.h>
#include "updatelibraryinformationcommand.h"
#include "activeplaybuttoncommand.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;

namespace
{
    const CommandId UPDATE_LIBRARY_INFORMATION_ID("UpdateLibraryInformation");
    const CommandId ACTIVE_PLAY_BUTTON_ID("ActivePlayButton");
}

CommandPointer CommandFactory::createCommand(const CommandId& aCommandId)
{
    if(aCommandId == UPDATE_LIBRARY_INFORMATION_ID)
    {
        return CommandPointer(new UpdateLibraryInformationCommand());
    }
    if(aCommandId == ACTIVE_PLAY_BUTTON_ID)
    {
        return CommandPointer(new ActivePlayButtonCommand());
    }
    return CommandPointer();
}

CommandFactory::CommandFactory()
{
}

