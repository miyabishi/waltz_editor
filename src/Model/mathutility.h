#ifndef MATHUTILITY_H
#define MATHUTILITY_H

#include <QObject>

namespace waltz
{
    namespace editor
    {
        namespace model
        {
            class MathUtility : public QObject
            {
                Q_OBJECT
            public:
                MathUtility(QObject* aParent = 0);

            public:
                Q_INVOKABLE int floor(double aX) const;
                Q_INVOKABLE int ceil(double aX) const;
            };
        }
    }
}

#endif // MATHUTILITY_H
