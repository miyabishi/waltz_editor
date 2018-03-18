#ifndef CHARACTERIMAGE_H
#define CHARACTERIMAGE_H

#include <QSharedPointer>
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
                explicit CharacterImage(const QString& aPath);

            public:
                QUrl url() const;

            private:
                QUrl mUrl_;
            private:
                CharacterImage(const CharacterImage& aOther);
                CharacterImage& operator=(const CharacterImage& aOther);
            };
            typedef QSharedPointer<CharacterImage> CharacterImagePointer;
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CHARACTERIMAGE_H
