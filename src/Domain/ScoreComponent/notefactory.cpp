#include "notefactory.h"
#include "syllable.h"
#include "noterect.h"
#include "noterectposition.h"
#include "noterectwidth.h"
#include "noterectheight.h"
#include "portamento.h"


using namespace waltz::editor::ScoreComponent;

namespace
{
    const int DEFAULT_PORTAMENTO_LENGTH = 30;
    PitchCurveStartPointPointer createPitchCurveStartPoint(const NoteRectPointer aPreviousNoteRect,
                                                           const NoteRectPointer aCurrentNoteRect)
    {
        int x = - DEFAULT_PORTAMENTO_LENGTH;
        int y = (aCurrentNoteRect->y() + aCurrentNoteRect->height()->center())
                - (aPreviousNoteRect->y() + aPreviousNoteRect->height()->center());

        return PitchCurveStartPointPointer(
                    new PitchCurveStartPoint(x, y,
                                             PitchCurveControlPointPointer(
                                                 new PitchCurveControlPoint(x, y))));
    }

    PitchCurveStartPointPointer createPitchCurveEndPoint(const NoteRectPointer aNoteRect)
    {
        int x = 0;
        int y = aNoteRect->height()->center();

        return PitchCurveStartPointPointer(
                    new PitchCurveStartPoint(x, y,
                                             PitchCurveControlPointPointer(
                                                 new PitchCurveControlPoint(x, y))));
    }

    PitchCurvePointer createPitchCurve(const NoteRectPointer aPreviousNoteRect,
                                       const NoteRectPointer aNoteRect)
    {
        return PitchCurvePointer(new PitchCurve(createPitchCurveStartPoint(aPreviousNoteRect, aNoteRect),
                                                createPitchCurveEndPoint(aNoteRect)));

    }

    PortamentoPointer createPortamento(const NoteRectPointer aNoteRect,
                                      const NoteListPointer aNoteList)
    {
        NoteRectPointer previousNoteRect(aNoteList->findPreviousNote(aNoteRect)->noteRect());
        return PortamentoPointer(new Portamento(createPitchCurve(previousNoteRect, aNoteRect)));
    }
}

NoteFactory::NoteFactory()
{

}
NotePointer NoteFactory::create(int aNoteId,
                                const QString& aNoteText,
                                int aPositionX,
                                int aPositionY,
                                int aNoteWidth,
                                int aNoteHeight,
                                const NoteListPointer aNoteList)
{
    NoteRectPointer noteRect(new NoteRect(NoteRectPositionPointer(new NoteRectPosition(aPositionX, aPositionY)),
                                          NoteRectWidthPointer(new NoteRectWidth(aNoteWidth),
                                          NoteRectHeightPointer(new NoteRectHeight(aNoteRectHeight)))));
    PortamentoPointer portamento(createPortamento(noteRect, aNoteList));
    return NotePointer(new Note(NoteId(aNoteId),
                                Syllable(aNoteText),
                                noteRect,
                                portamento));
}
