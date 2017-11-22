#ifndef PITCHCHANGINGPOINT_H
#define PITCHCHANGINGPOINT_H

#include <QSharedPointer>
#include <waltz_common/parameters.h>
#include "src/Model/editareainformation.h"
#include "beat.h"
#include "tempo.h"
#include "point.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class PitchChangingPoint : public Point
            {
            public:
                PitchChangingPoint(const int aX,
                                   const int aY);
                common::Commands::Parameters toParameters(Beat aBeat,
                                                          Tempo aTempo,
                                                          model::EditAreaInformationPointer aEditAreaInformation);
            private:
                PitchChangingPoint(const PitchChangingPoint& aOther);
                PitchChangingPoint& operator=(const PitchChangingPoint& aOther);
            };
            typedef QSharedPointer<PitchChangingPoint> PitchChangingPointPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // PITCHCHANGINGPOINT_H
