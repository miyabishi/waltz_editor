#ifndef PORTAMENTO_H
#define PORTAMENTO_H

#include <QSharedPointer>
#include "pitchcurve.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Portamento
            {
            public:
                Portamento(const PitchCurvePointer aPitchCurve);
                PitchCurvePointer pitchCurve() const;

            private:
                PitchCurvePointer mPitchCurve_;

            private:
                Portamento(const Portamento& aOther);
                Portamento& operator=(const Portamento& aOther);
            };
            typedef QSharedPointer<Portamento> PortamentoPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PORTAMENTO_H
