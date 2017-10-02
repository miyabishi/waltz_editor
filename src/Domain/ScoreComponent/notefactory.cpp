#include "notefactory.h"
#include "syllable.h"
#include "noterect.h"
#include "noterectposition.h"
#include "noterectwidth.h"
#include "noterectheight.h"
#include "portamento.h"

using namespace waltz::editor::ScoreComponent;

NoteFactory::NoteFactory()
{
}

NotePointer NoteFactory::create(int aNoteId,
                                const QString& aNoteText,
                                int aPositionX,
                                int aPositionY,
                                int aNoteWidth,
                                int aNoteHeight,
                                int aPortamentoStartX,
                                int aPortamentoStartY,
                                QList<int> aPitchChangingPointX,
                                QList<int> aPitchChangingPointY,
                                int aPortamentoEndX,
                                int aPortamentoEndY)
{
    NoteRectPointer noteRect(new NoteRect(NoteRectPositionPointer(new NoteRectPosition(aPositionX, aPositionY)),
                                          NoteRectWidthPointer(new NoteRectWidth(aNoteWidth)),
                                          NoteRectHeightPointer(new NoteRectHeight(aNoteHeight))));
    PitchCurvePointer pitchCurve(new PitchCurve(
                                     PitchCurveStartPointPointer(new PitchCurveStartPoint(
                                                                     aPortamentoStartX,
                                                                     aPortamentoStartY)),
                                     PitchCurveEndPointPointer(new PitchCurveEndPoint(
                                                                   aPortamentoEndX,
                                                                   aPortamentoEndY))));
    int changingPointCount = aPitchChangingPointX.size();
    if (changingPointCount != aPitchChangingPointY.size())
    {
        // TODO:エラーハンドリング
        qDebug() << "Error!";
    }

    for(int index = 0; index < changingPointCount; ++index)
    {
        pitchCurve->appendChangingPoint(PitchChangingPointPointer(
                                            new PitchChangingPoint(aPitchChangingPointX[index],
                                                                   aPitchChangingPointY[index])));
    }

    PortamentoPointer portamento(new Portamento(pitchCurve));
    return NotePointer(new Note(NoteId(aNoteId),
                                Syllable(aNoteText),
                                noteRect,
                                portamento));
}
