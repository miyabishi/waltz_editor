#include "libraryinformation.h"

using namespace waltz::editor::LibraryComponent;

LibraryInformation::LibraryInformation(const CharacterImage& aCharacterImage,
                                       const Description& aDescription,
                                       const LibraryName& aLibraryName)
    : mCharacterImage_(aCharacterImage)
    , mDescription_(aDescription)
    , mLibraryName_(aLibraryName)
{
}

LibraryInformation::LibraryInformation(const LibraryInformation& aOther)
    : mCharacterImage_(aOther.mCharacterImage_)
    , mDescription_(aOther.mDescription_)
    , mLibraryName_(aOther.mLibraryName_)
{
}

LibraryInformation& LibraryInformation::operator=(const LibraryInformation& aOther)
{
    mCharacterImage_ = aOther.mCharacterImage_;
    mDescription_ = aOther.mDescription_;
    mLibraryName_ = aOther.mLibraryName_;
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

LibraryName LibraryInformation::libraryName()const
{
    return mLibraryName_;
}
