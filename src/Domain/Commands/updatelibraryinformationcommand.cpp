#include "src/Model/mainwindowmodel.h"
#include "src/Domain/LibraryComponent/characterimage.h"
#include "src/Domain/LibraryComponent/description.h"
#include "updatelibraryinformationcommand.h"
#include "parameters.h"
#include "parameter.h"
#include "commandid.h"
#include "src/Domain/LibraryComponent/libraryinformation.h"

using namespace waltz::editor::Commands;
using namespace waltz::editor::model;
using namespace waltz::editor::LibraryComponent;

namespace
{
    const CommandId COMMAND_ID("UpdateLibraryInformation");
    const QString PARAMETER_NAME_IMAGE_FILE_PATH("ImageFilePath");
    const QString PARAMETER_NAME_DESCRIPTION("Description");
}


UpdateLibraryInformationCommand::UpdateLibraryInformationCommand()
    :Command(COMMAND_ID)
{

}

void UpdateLibraryInformationCommand::exec(const Parameters& aParameters)
{
    CharacterImage characterImage(aParameters.find(PARAMETER_NAME_IMAGE_FILE_PATH).toString());
    Description description(aParameters.find(PARAMETER_NAME_DESCRIPTION).toString());
    MainWindowModel::getInstance().setLibraryInformation(
                LibraryInformation(characterImage, description));
}
