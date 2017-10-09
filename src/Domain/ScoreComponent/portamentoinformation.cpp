#include <QDebug>
#include "portamentoinformation.h"

using namespace waltz::editor::ScoreComponent;

PortamentoInformation::PortamentoInformation(int        aPortamentStartX,
                                             int        aPortamentStartY,
                                             QList<int> aPitchChangingPointX,
                                             QList<int> aPitchChangingPointY,
                                             int        aPortamentEndX,
                                             int        aPortamentEndY)
    : mPortamentStartX_(aPortamentStartX)
    , mPortamentStartY_(aPortamentStartY)
    , mPitchChangingPointX_(aPitchChangingPointX)
    , mPitchChangingPointY_(aPitchChangingPointY)
    , mPortamentEndX_(aPortamentEndX)
    , mPortamentEndY_(aPortamentEndY)
{

}

PitchCurvePointer PortamentoInformation::pitchCurve() const
{
    PitchCurvePointer pitchCurve(new PitchCurve(
                                 PitchCurveStartPointPointer(
                                     new PitchCurveStartPoint(mPortamentStartX_,
                                                              mPortamentStartY_)),
                                 PitchCurveEndPointPointer(
                                     new PitchCurveEndPoint(mPortamentEndX_,
                                                            mPortamentEndY_))));

    int changingPointCount = mPitchChangingPointX_.size();
    if (changingPointCount != mPitchChangingPointY_.size())
    {
        // TODO:エラーハンドリング
        qDebug() << "Error!";
    }

    for(int index = 0; index < changingPointCount; ++index)
    {
        pitchCurve->appendChangingPoint(PitchChangingPointPointer(
                                            new PitchChangingPoint(mPitchChangingPointX_[index],
                                                                   mPitchChangingPointY_[index])));
    }

    return pitchCurve;
}

PortamentoPointer PortamentoInformation::portamento() const
{
    return PortamentoPointer(new Portamento(pitchCurve()));
}
