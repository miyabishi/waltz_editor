#include <QDebug>
#include "correspondencealias.h"

using namespace waltz::editor::LibraryComponent;

namespace
{
    const QString PARAMETER_NAME = "CorrenspondenceAlias";
}

CorrespondenceAlias::CorrespondenceAlias(const waltz::common::Commands::Parameters& aParameters)
    :mValue_(aParameters.find(PARAMETER_NAME).value().toString())
{
}

QString CorrespondenceAlias::value() const
{
    return mValue_;
}
