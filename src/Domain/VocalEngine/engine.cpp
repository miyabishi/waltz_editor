#include <QDebug>
#include "engine.h"
#include "src/Settings/editorsettings.h"

using namespace waltz::editor::VocalEngine;
using namespace waltz::editor::Settings;


Engine::Engine()
    :mProcess_(* new QProcess())
{

}

Engine::~Engine()
{
    delete &mProcess_;
}

bool Engine::start() const
{
    mProcess_.start(EditorSettings::getInstance().enginePath(),QStringList());
    if(! mProcess_.waitForStarted())
    {
        return false;
    }

    return true;
}

