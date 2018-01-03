#include "vibrato.h"

using namespace waltz::editor::ScoreComponent;

Vibrato::Vibrato(const NoteId aNoteId, const VibratoForm aVibratoForm)
  : mNoteId_(aNoteId)
  , mVibratoForm_(aVibratoForm)
{
}
