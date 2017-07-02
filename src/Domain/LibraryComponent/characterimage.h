#ifndef CHARACTERIMAGE_H
#define CHARACTERIMAGE_H

#include <QUrl>

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
                QUrl url() const;

            private:
                QUrl mUrl_;
            };
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CHARACTERIMAGE_H
