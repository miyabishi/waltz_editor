#include "src/Model/mainwindowmodel.h"
#include "pauseseekbarcommand.h"

using namespace waltz::editor::Commands;
using namespace waltz::common::Commands;

PauseSeekBarCommand::PauseSeekBarCommand()
    :Command(CommandId("PauseSeekBar"))
{

}

void PauseSeekBarCommand::exec(const waltz::common::Commands::Parameters& /*aParameters*/)
{
    waltz::editor::model::MainWindowModel::getInstance().emitPauseSeekBar();
}
