#include <waltz_common/commandid.h>
#include "resetseekbarcommand.h"
#include "src/Model/mainwindowmodel.h"
using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;

namespace
{
    const CommandId COMMAND_ID("ResetSeekBar");
}

ResetSeekBarCommand::ResetSeekBarCommand()
    : Command(COMMAND_ID)
{
}

void ResetSeekBarCommand::exec(const waltz::common::Commands::Parameters& /*aParameters*/)
{
    waltz::editor::model::MainWindowModel::getInstance().emitResetSeekBar();
}
