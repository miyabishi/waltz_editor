#ifndef PARAMETERS_H
#define PARAMETERS_H

#include <QMap>
#include <QJsonArray>
#include "parameter.h"

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class Parameters
            {
            public:
                Parameters();
                Parameters(const Parameters& aOther);
                Parameters& operator=(const Parameters& aOther);

            public:
                void append(const Parameter& aParameter);
                QJsonArray toJsonArray() const;
                Parameter find(const QString& aParameterName) const;

            private:
                QMap<QString, Parameter> mParameters_;
            };
        } // namespace Communicator
    } // namespace editor
} // namespace waltz

#endif // PARAMETERS_H
