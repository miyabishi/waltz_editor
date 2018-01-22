#ifndef WALTZSONGFILE_H
#define WALTZSONGFILE_H

#include <QString>
#include <QVariantMap>

namespace waltz
{
    namespace editor
    {
        namespace ExternalFile
        {
            class WaltzSongFile
            {
            public:
                explicit WaltzSongFile(const QString& aFilePath);
                void save(const QVariantMap& aData) const;
                QVariantMap load() const;

            private:
                QString mFilePath_;

            private:
                WaltzSongFile(const WaltzSongFile& aOther);
                WaltzSongFile operator=(const WaltzSongFile& aOther);
            };
        } // namespace ExternalFile
    } // namespace editor
} // namespace waltz

#endif // WALTZSONGFILE_H
