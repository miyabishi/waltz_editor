#include "src/Model/mainwindowmodel.h"
#include "src/Domain/LibraryComponent/characterimage.h"
#include "src/Domain/LibraryComponent/description.h"
#include "src/Domain/LibraryComponent/libraryname.h"
#include "updatelibraryinformationcommand.h"
#include <waltz_common/parameters.h>
#include <waltz_common/parameter.h>
#include <waltz_common/command.h>
#include "src/Domain/LibraryComponent/libraryinformation.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::Commands;
using namespace waltz::editor::model;
using namespace waltz::editor::LibraryComponent;

namespace
{
    const CommandId COMMAND_ID("UpdateLibraryInformation");
    const QString PARAMETER_NAME_IMAGE_FILE_PATH("ImageFilePath");
    const QString PARAMETER_NAME_DESCRIPTION("Description");
    const QString PARAMETER_NAME_LIBRARY_NAME("LibraryName");
    const QString PARAMETER_NAME_LIBRARY_FILE_PATH("LibraryFilePath");
}


UpdateLibraryInformationCommand::UpdateLibraryInformationCommand()
    :Command(COMMAND_ID)
{

}

void UpdateLibraryInformationCommand::exec(const Parameters& aParameters)
{
    CharacterImagePointer characterImage(
                new CharacterImage(aParameters.find(PARAMETER_NAME_IMAGE_FILE_PATH).value().toString()));
    DescriptionPointer description(
                new Description(aParameters.find(PARAMETER_NAME_DESCRIPTION).value().toString()));
    LibraryNamePointer libraryName(
                new LibraryName(aParameters.find(PARAMETER_NAME_LIBRARY_NAME).value().toString()));
    LibraryFilePathPointer libraryFilePath(
                new LibraryFilePath(aParameters.find(PARAMETER_NAME_LIBRARY_FILE_PATH).value().toString()));

    MainWindowModel::getInstance().setLibraryInformation(
                LibraryInformationPointer(
                    new LibraryInformation(characterImage,
                                           description,
                                           libraryName,
                                           libraryFilePath)));
}
