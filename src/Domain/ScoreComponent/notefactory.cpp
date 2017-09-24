#include "notefactory.h"
#include "syllable.h"
#include "noterect.h"
#include "noterectposition.h"
#include "noterectwidth.h"
#include "portamento.h"

using namespace waltz::editor::ScoreComponent;

namespace
{
    PortamentoPointer createPortament(const NoteRectPointer aNoteRect,
                                      const ScorePointer aScore)
    {

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
                                const ScorePointer aScore)
{
    NoteRectPointer noteRect(new NoteRect(NoteRectPositionPointer(new NoteRectPosition(aPositionX, aPositionY)),
                                          NoteRectWidthPointer(new NoteRectWidth(aNoteWidth))));
    PortamentoPointer portamento(noteRect, aScore);
    return NotePointer(new Note(NoteId(aNoteId),
                                Syllable(aNoteText),
                                noteRect,
                                portamento));
}
