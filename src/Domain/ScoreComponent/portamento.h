#ifndef PORTAMENTO_H
#define PORTAMENTO_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class Portamento
            {
            public:
                Portamento();
            private:
                Portamento(const Portamento& aOther);
                Portamento& operator=(const Portamento& aOther);
            };

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PORTAMENTO_H
