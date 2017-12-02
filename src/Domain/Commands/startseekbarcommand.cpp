#include <waltz_common/commandid.h>
#include "startseekbarcommand.h"
#include "src/Model/mainwindowmodel.h"

using namespace waltz::editor::Commands;
using namespace waltz::common::Commands;

namespace
{
    const CommandId COMMAND_ID("StartSeekBar");
}

StartSeekBarCommand::StartSeekBarCommand()
    : Command(COMMAND_ID)
{
}

void StartSeekBarCommand::exec(const waltz::common::Commands::Parameters& /*aParameters*/)
{
    waltz::editor::model::MainWindowModel::getInstance().emitStartSeekBar();
}
