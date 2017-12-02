#include "commandfactory.h"
#include <waltz_common/commandid.h>
#include "updatelibraryinformationcommand.h"
#include "activeplaybuttoncommand.h"
#include "startseekbarcommand.h"
#include "resetseekbarcommand.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;

namespace
{
    const CommandId UPDATE_LIBRARY_INFORMATION_ID("UpdateLibraryInformation");
    const CommandId ACTIVE_PLAY_BUTTON_ID("ActivePlayButton");
    const CommandId START_SEEK_BAR_ID("StartSeekBar");
    const CommandId RESET_SEEK_BAR_ID("ResetSeekBar");

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

    if(aCommandId == START_SEEK_BAR_ID)
    {
        return CommandPointer(new StartSeekBarCommand());
    }
    if(aCommandId == RESET_SEEK_BAR_ID)
    {
        return CommandPointer(new ResetSeekBarCommand());
    }
    return CommandPointer();
}

CommandFactory::CommandFactory()
{
}

