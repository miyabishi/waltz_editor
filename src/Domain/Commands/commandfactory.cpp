#include "commandfactory.h"
#include <waltz_common/commandid.h>
#include "updatelibraryinformationcommand.h"
#include "activeplaybuttoncommand.h"
#include "startseekbarcommand.h"
#include "resetseekbarcommand.h"
#include "pauseseekbarcommand.h"
#include "engineisready.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;

CommandFactory* CommandFactory::mInstance_ = 0;

CommandFactory& CommandFactory::getInstance()
{
    if (0 == mInstance_)
    {
        static CommandFactory instance;
        mInstance_ = &instance;
    }
    return *mInstance_;
}

CommandPointer CommandFactory::createCommand(const CommandId& aCommandId)
{
    foreach (waltz::common::Commands::CommandPointer command, mCommandList_) {
        if (! command->commandIdEquals(aCommandId)) continue;
        return command;
    }
    return CommandPointer();
}

CommandFactory::CommandFactory()
{
    mCommandList_ << CommandPointer(new UpdateLibraryInformationCommand());
    mCommandList_ << CommandPointer(new ActivePlayButtonCommand());
    mCommandList_ << CommandPointer(new StartSeekBarCommand());
    mCommandList_ << CommandPointer(new ResetSeekBarCommand());
    mCommandList_ << CommandPointer(new PauseSeekBarCommand());
    mCommandList_ << CommandPointer(new EngineIsReady());
}

