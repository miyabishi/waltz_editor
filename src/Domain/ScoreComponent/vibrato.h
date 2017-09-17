#ifndef VIBRATO_H
#define VIBRATO_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Vibrato
            {
            public:
                Vibrato();


            private:
                Vibrato(const Vibrato& aOther);
                Vibrato& operator=(const Vibrato& aOther);
            };
            typedef QSharedPointer<Vibrato> VibratoPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATO_H
