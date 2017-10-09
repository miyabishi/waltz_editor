#ifndef PORTAMENTOINFORMATION_H
#define PORTAMENTOINFORMATION_H

#include <QSharedPointer>
#include "pitchcurve.h"
#include "portamento.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PortamentoInformation
            {
            public:
                PortamentoInformation(int        aPortamentStartX,
                                      int        aPortamentStartY,
                                      QList<int> aPitchChangingPointX,
                                      QList<int> aPitchChangingPointY,
                                      int        aPortamentEndX,
                                      int        aPortamentEndY);
                PitchCurvePointer pitchCurve() const;
                PortamentoPointer portamento() const;

            private:
                int        mPortamentStartX_;
                int        mPortamentStartY_;
                QList<int> mPitchChangingPointX_;
                QList<int> mPitchChangingPointY_;
                int        mPortamentEndX_;
                int        mPortamentEndY_;

            private:
                PortamentoInformation(const PortamentoInformation& aOther);
                PortamentoInformation& operator=(const PortamentoInformation& aOther);
            };
            typedef QSharedPointer<PortamentoInformation> PortamentoInformationPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PORTAMENTOINFORMATION_H
