#ifndef LIBRARYINFORMATION_H
#define LIBRARYINFORMATION_H

#include "characterimage.h"
#include "description.h"

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
                                   const Description& aDescription);
                LibraryInformation(const LibraryInformation& aOther);
                LibraryInformation& operator=(const LibraryInformation& aOther);

            public:
                CharacterImage characterImage() const;
                Description description() const;

            private:
                CharacterImage mCharacterImage_;
                Description    mDescription_;
            };
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // LIBRARYINFORMATION_H
