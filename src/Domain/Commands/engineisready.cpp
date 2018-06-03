#include "engineisready.h"
#include <waltz_common/commandid.h>
#include "src/Model/mainwindowmodel.h"

using namespace waltz::common::Commands;

namespace
{
    const CommandId COMMAND_ID("EngineIsReady");

}

using namespace waltz::editor::Commands;

EngineIsReady::EngineIsReady()
    :Command(COMMAND_ID)
{
}

void EngineIsReady::exec(const waltz::common::Commands::Parameters& /*aParameters*/)
{
    waltz::editor::model::MainWindowModel::getInstance().loadDefaultLibrary();
    waltz::editor::model::MainWindowModel::getInstance().notifyIsReady();
}
