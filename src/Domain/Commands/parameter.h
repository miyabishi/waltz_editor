#ifndef PARAMETER_H
#define PARAMETER_H

#include <QVariant>
#include <QString>
#include <QJsonValue>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            const QString PARAMETER_KEY_NAME("Name");
            const QString PARAMETER_KEY_VALUE("Value");
            class Parameter
            {
            public:
                Parameter();
                Parameter(const QString& aName,
                        const QVariant& aValue);
                Parameter(const Parameter& aOther);
                Parameter& operator=(const Parameter& aOther);

            public:
                QVariant value() const;
                QString name() const;
                QJsonValue toJsonValue() const;
                QString toString() const;

            private:
                QString  mName_;
                QVariant mValue_;
            };
        } // namespace Communicator
    } // namespace editor
} // namespace waltz

#endif // PARAMETER_H
