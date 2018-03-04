#ifndef HISTORYDATAID_H
#define HISTORYDATAID_H

#include <QString>
#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace History
        {
            class HistoryDataId
            {
            public:
                explicit HistoryDataId(const QString& aValue);

            private:
                QString mValue_;

            private:
                HistoryDataId(HistoryDataId& aOther);
                HistoryDataId& operator=(HistoryDataId& aOther);

            };
            typedef QSharedPointer<HistoryDataId> HistoryDataIdPointer;

        } // namespace History
    } // namespace editor
} // namespace waltz

#endif // HISTORYDATAID_H
