#ifndef LIBRARYINFORMATION_H
#define LIBRARYINFORMATION_H

#include "characterimage.h"
#include "description.h"
#include "libraryname.h"

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {
            class LibraryInformation
            {
            public:
                LibraryInformation(const CharacterImage& aCharactorImage,
                                   const Description& aDescription,
                                   const LibraryName& aLibraryName);
                LibraryInformation(const LibraryInformation& aOther);
                LibraryInformation& operator=(const LibraryInformation& aOther);

            public:
                CharacterImage characterImage() const;
                Description description() const;
                LibraryName libraryName() const;

            private:
                CharacterImage mCharacterImage_;
                Description    mDescription_;
                LibraryName    mLibraryName_;
            };
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // LIBRARYINFORMATION_H
