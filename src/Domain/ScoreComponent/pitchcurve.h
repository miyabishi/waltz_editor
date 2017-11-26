#ifndef PITCHCURVE_H
#define PITCHCURVE_H

#include <QSharedPointer>
#include <QList>
#include <waltz_common/parameter.h>
#include "beat.h"
#include "tempo.h"
#include "src/Model/editareainformation.h"
#include "pitchchangingpoint.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class PitchCurve
            {
            public:
                PitchCurve();
                void appendChangingPoint(PitchChangingPointPointer aChangingPoint);
                waltz::common::Commands::Parameter toParameter(
                        Beat aBeat,
                        Tempo aTempo,
                        waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const;
                void clearPitchCurve();

            private:
                QList<PitchChangingPointPointer> mPitchCurve_;

            private:
                PitchCurve(const PitchCurve& aOther);
                PitchCurve& operator=(const PitchCurve& aOther);
            };
            typedef QSharedPointer<PitchCurve> PitchCurvePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCURVE_H
