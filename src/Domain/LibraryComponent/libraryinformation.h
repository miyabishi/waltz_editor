#ifndef LIBRARYINFORMATION_H
#define LIBRARYINFORMATION_H

#include "characterimage.h"
#include "description.h"
#include "libraryname.h"
#include "libraryfilepath.h"

#include <QVariant>
#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {
            class LibraryInformation
            {
            public:
                LibraryInformation(const CharacterImagePointer  aCharactorImage,
                                   const DescriptionPointer     aDescription,
                                   const LibraryNamePointer     aLibraryName,
                                   const LibraryFilePathPointer aLibraryFilePath);

            public:
                CharacterImagePointer characterImage() const;
                DescriptionPointer description() const;
                LibraryNamePointer libraryName() const;
                QVariantMap insertLibraryFilePathVariant(const QVariantMap& aVariantMap) const;

            private:
                CharacterImagePointer  mCharacterImage_;
                DescriptionPointer     mDescription_;
                LibraryNamePointer     mLibraryName_;
                LibraryFilePathPointer mLibraryFilePath_;

            private:
                LibraryInformation(const LibraryInformation& aOther);
                LibraryInformation& operator=(const LibraryInformation& aOther);
            };
            typedef QSharedPointer<LibraryInformation> LibraryInformationPointer;

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // LIBRARYINFORMATION_H
