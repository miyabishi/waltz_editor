#include <QString>
#include "characterimage.h"

using namespace waltz::editor::LibraryComponent;

CharacterImage::CharacterImage()
    : mImage_("qrc:/image/momo.png")
{
}

CharacterImage::CharacterImage(const QString& aPath)
    :mImage_(aPath)
{
}

CharacterImage::CharacterImage(const CharacterImage& aOther)
    :mImage_(aOther.mImage_)
{

}

CharacterImage& CharacterImage::operator=(const CharacterImage& aOther)
{
    mImage_ = aOther.mImage_;
    return (*this);
}

QImage CharacterImage::value() const
{
    return mImage_;
}

