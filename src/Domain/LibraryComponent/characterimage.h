#ifndef CHARACTERIMAGE_H
#define CHARACTERIMAGE_H

#include <QImage>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {
            class CharacterImage
            {
            public:
                CharacterImage();
                explicit CharacterImage(const QString& aPath);
                CharacterImage(const CharacterImage& aOther);
                CharacterImage& operator=(const CharacterImage& aOther);

            public:
                QImage value() const;

            private:
                QImage mImage_;
            };
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CHARACTERIMAGE_H
