#include <QString>
#include "characterimage.h"

using namespace waltz::editor::LibraryComponent;

CharacterImage::CharacterImage(const QString& aPath)
    :mUrl_(QUrl::fromLocalFile(aPath))
{
}


QUrl CharacterImage::url() const
{
    return mUrl_;
}

