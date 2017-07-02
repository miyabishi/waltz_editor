#include <QString>
#include "characterimage.h"

using namespace waltz::editor::LibraryComponent;

CharacterImage::CharacterImage()
    : mUrl_()
{
}

CharacterImage::CharacterImage(const QString& aPath)
    :mUrl_(QUrl::fromLocalFile(aPath))
{
}

CharacterImage::CharacterImage(const CharacterImage& aOther)
    :mUrl_(aOther.mUrl_)
{
}

CharacterImage& CharacterImage::operator=(const CharacterImage& aOther)
{
    mUrl_ = aOther.mUrl_;
    return (*this);
}

QUrl CharacterImage::url() const
{
    return mUrl_;
}

