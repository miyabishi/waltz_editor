#ifndef HISTORYDATA_H
#define HISTORYDATA_H

#include <QSharedPointer>
#include <QVariantMap>

namespace waltz
{
    namespace editor
    {
        namespace History
        {
            class HistoryData
            {
            public:
                explicit HistoryData(const QVariantMap& aData);
                QVariantMap value() const;
                bool isSame(QSharedPointer<HistoryData> aOther) const;

            private:
                QVariantMap          mData_;

            private:
                HistoryData(HistoryData& aOther);
                HistoryData& operator=(HistoryData& aOther);
            };
            typedef QSharedPointer<HistoryData> HistoryDataPointer;

        } // namespace ExternalFile
    } // namespace editor
} // namespace waltz

#endif // HISTORYDATA_H
