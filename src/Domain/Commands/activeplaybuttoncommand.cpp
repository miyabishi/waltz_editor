#include <waltz_common/commandid.h>
#include "activeplaybuttoncommand.h"
#include "src/Model/mainwindowmodel.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;

namespace
{
    const CommandId COMMAND_ID("ActivePlayButton");
}

ActivePlayButtonCommand::ActivePlayButtonCommand()
    :waltz::common::Commands::Command(COMMAND_ID)
{
}


void ActivePlayButtonCommand::exec(const Parameters& /*aParameters*/)
{
    waltz::editor::model::MainWindowModel::getInstance().emitActivePlayButton();
}

