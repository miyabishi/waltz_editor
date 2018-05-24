#include "libraryinformation.h"

using namespace waltz::editor::LibraryComponent;

LibraryInformation::LibraryInformation(const CharacterImagePointer aCharacterImage,
                                       const DescriptionPointer aDescription,
                                       const LibraryNamePointer aLibraryName,
                                       const LibraryFilePathPointer aLibraryFilePath,
                                       const CorrespondenceSyllableListPointer aCorrespondeceSyllableList)
    : mCharacterImage_(aCharacterImage)
    , mDescription_(aDescription)
    , mLibraryName_(aLibraryName)
    , mLibraryFilePath_(aLibraryFilePath)
    , mCorrespondenceSyllableList_(aCorrespondeceSyllableList)
{
}

CharacterImagePointer LibraryInformation::characterImage() const
{
    return mCharacterImage_;
}

DescriptionPointer LibraryInformation::description() const
{
    return mDescription_;
}

LibraryNamePointer LibraryInformation::libraryName()const
{
    return mLibraryName_;
}

QVariantMap LibraryInformation::insertLibraryFilePathVariant(const QVariantMap& aVariantMap) const
{
    QVariantMap map = aVariantMap;
    map.insert(LibraryFilePath::variantMapKey(), mLibraryFilePath_->toVariant());
    return map;
}
