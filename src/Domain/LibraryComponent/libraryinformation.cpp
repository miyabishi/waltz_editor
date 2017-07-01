#include "libraryinformation.h"

using namespace waltz::editor::LibraryComponent;

LibraryInformation::LibraryInformation(const CharacterImage& aCharacterImage,
                                       const Description& aDescription)
    : mCharacterImage_(aCharacterImage)
    , mDescription_(aDescription)
{
}

LibraryInformation::LibraryInformation(const LibraryInformation& aOther)
    : mCharacterImage_(aOther.mCharacterImage_)
    , mDescription_(aOther.mDescription_)
{
}

LibraryInformation& LibraryInformation::operator=(const LibraryInformation& aOther)
{
    mCharacterImage_ = aOther.mCharacterImage_;
    mDescription_ = aOther.mDescription_;
    return (*this);
}

CharacterImage LibraryInformation::characterImage() const
{
    return mCharacterImage_;
}

Description LibraryInformation::description() const
{
    return mDescription_;
}

