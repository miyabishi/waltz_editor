#include "correspondencesyllable.h"

using namespace waltz::editor::LibraryComponent;

namespace
{
    const QString PARAMETER_NAME = "CorrenspondenceSyllable";

}

CorrespondenceSyllable::CorrespondenceSyllable(const waltz::common::Commands::Parameters& aParameters)
    :mValue_(aParameters.find(PARAMETER_NAME).value().toString())
{

}
