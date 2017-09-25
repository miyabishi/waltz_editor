#include <QDebug>
#include <QString>
#include <QJsonObject>
#include <QJsonDocument>
#include <QUrl>
#include <waltz_common/commandid.h>
#include <waltz_common/parameter.h>
#include <waltz_common/parameters.h>
#include <waltz_common/message.h>

#include "mainwindowmodel.h"
#include "src/Domain/LibraryComponent/characterimage.h"
#include "src/Domain/LibraryComponent/description.h"
#include "src/Domain/ScoreComponent/notefactory.h"

using namespace waltz::common::Communicator;
using namespace waltz::common::Commands;

using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;
using namespace waltz::editor::Communicator;


namespace
{
    const CommandId COMMAND_ID_LOAD_VOICE_LIBRARY("LoadVoiceLibrary");
    const CommandId COMMAND_ID_PLAY_NOTE("PlayNote");
    const CommandId COMMAND_ID_PLAY_SCORE("PlayScore");
    const CommandId COMMAND_ID_SAVE_WAV("SaveWav");
}

MainWindowModel* MainWindowModel::mInstance_ = 0;

MainWindowModel& MainWindowModel::getInstance()
{
    if(mInstance_ == 0)
    {
        static MainWindowModel instance;
        mInstance_ = &instance;
    }
    return *mInstance_;
}

void MainWindowModel::setLibraryInformation(
        const waltz::editor::LibraryComponent::LibraryInformation& aLibraryInformation)
{
    mLibraryInformation_ = aLibraryInformation;
    emit libraryInformationUpdated();
}

void MainWindowModel::setTempo(int aTempo)
{
    mScore_->setTempo(aTempo);
}

int  MainWindowModel::tempo() const
{
    return mScore_->tempo().value();
}

void MainWindowModel::setBeatParent(int aBeatParent)
{
    mScore_->setBeatParent(aBeatParent);
}

void MainWindowModel::setBeatChild(int aBeatChild)
{
    mScore_->setBeatChild(aBeatChild);
}

int MainWindowModel::beatChild() const
{
    return mScore_->beatChild();
}

int MainWindowModel::beatParent() const
{
    return mScore_->beatParent();
}

int MainWindowModel::editAreaWidth() const
{
    return mEditAreaInformation_->editAreaWidth();
}
int MainWindowModel::columnWidth() const
{
    return mEditAreaInformation_->columnWidth(
                mScore_->beatParent());
}

int MainWindowModel::rowHeight() const
{
    return mEditAreaInformation_->rowHeight();
}

int MainWindowModel::supportOctave() const
{
    return mEditAreaInformation_->supportOctave();
}

void MainWindowModel::appendNote(int aNoteId,
                                 const QString& aNoteText,
                                 int aPositionX,
                                 int aPositionY,
                                 int aNoteWidth)
{

    NoteFactoryPointer noteFactory(new NoteFactory());
    NotePointer note(noteFactory->create(aNoteId,
                                         aNoteText,
                                         aPositionX,
                                         aPositionY,
                                         aNoteWidth,
                                         mEditAreaInformation_->rowHeight(),
                                         mScore_->noteList()));
    mScore_->appendNote(note);
    mClient_->sendMessage(Message(COMMAND_ID_PLAY_NOTE,
                                  note->toParameters(mScore_->beat(),
                                                     mScore_->tempo(),
                                                     mEditAreaInformation_)));
}

QString MainWindowModel::vocalFileExtention() const
{
    return "wvocal";
}

void MainWindowModel::loadVoiceLibrary(const QUrl &aUrl)
{
    Parameters parameters;
    parameters.append(Parameter("FilePath", aUrl.toLocalFile()));

    mClient_->sendMessage(Message(COMMAND_ID_LOAD_VOICE_LIBRARY,
                                  parameters));
}

void MainWindowModel::saveWav(const QUrl &aUrl)
{
    Parameters parameters = mScore_->toParameters(mEditAreaInformation_);
    parameters.append(Parameter("FilePath",aUrl.toLocalFile()));

    mClient_->sendMessage(Message(COMMAND_ID_SAVE_WAV,
                                  parameters));
}


QString MainWindowModel::characterImageUrl() const
{
    return mLibraryInformation_.characterImage().url().toString();
}

QString MainWindowModel::libraryName() const
{
    return mLibraryInformation_.libraryName().value();
}

QString MainWindowModel::libraryDescription() const
{
    return mLibraryInformation_.description().value();
}

void MainWindowModel::emitErrorOccurred(const QString& aErrorMessage)
{
    emit errorOccurred(aErrorMessage);
}

void MainWindowModel::play()
{
    mClient_->sendMessage(
                Message(COMMAND_ID_PLAY_SCORE,
                        mScore_->toParameters(mEditAreaInformation_)));

}

void MainWindowModel::updateNote(int aNoteId,
                                 const QString& aNoteText,
                                 int aPositionX,
                                 int aPositionY,
                                 int aNoteWidth)
{
    NoteFactoryPointer noteFactory(new NoteFactory());
    NotePointer note(noteFactory->create(aNoteId,
                                         aNoteText,
                                         aPositionX,
                                         aPositionY,
                                         aNoteWidth,
                                         mEditAreaInformation_->rowHeight(),
                                         mScore_->noteList()));
    mScore_->updateNote(note);
}


int MainWindowModel::publishNoteId()
{
    mNoteIdCounter_++;
    return mNoteIdCounter_;
}

int MainWindowModel::noteCount() const
{
    return mScore_->noteCount();
}

int MainWindowModel::findNotePositionX(int aIndex) const
{
    return mScore_->noteList()->at(aIndex)->xPosition();
}

void MainWindowModel::emitActivePlayButton()
{
    emit activePlayButton();
}

int MainWindowModel::portamentStartX(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->startPoint()->x();
}

int MainWindowModel::portamentStartY(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->startPoint()->y();
}

int MainWindowModel::portamentStartControlX(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->startPoint()->controlPoint()->x();
}

int MainWindowModel::portamentStartControlY(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->startPoint()->controlPoint()->y();
}

int MainWindowModel::pitchChangingPointX(int aNoteId, int aIndex) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->changingPoint(aIndex)->x();
}

int MainWindowModel::pitchChangingPointCount(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->changingPointCount();
}

int MainWindowModel::pitchChangingPointY(int aNoteId, int aIndex) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->changingPoint(aIndex)->y();
}

int MainWindowModel::pitchChangingPointControlX(int aNoteId, int aIndex) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->changingPoint(aIndex)->controlPoint()->x();
}

int MainWindowModel::pitchChangingPointControlY(int aNoteId, int aIndex) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->changingPoint(aIndex)->controlPoint()->y();
}

int MainWindowModel::portamentEndX(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->endPoint()->x();
}

int MainWindowModel::portamentEndY(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->endPoint()->y();
}

int MainWindowModel::portamentEndControlX(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->endPoint()->controlPoint()->x();
}

int MainWindowModel::portamentEndControlY(int aNoteId) const
{
    return findNote(aNoteId)->portamento()->pitchCurve()->endPoint()->controlPoint()->y();
}

NotePointer MainWindowModel::findNote(int aNoteId) const
{
    return mScore_->noteList()->find(NoteId(aNoteId));
}

MainWindowModel::MainWindowModel(QObject *aParent)
    : QObject(aParent)
    , mScore_(ScorePointer(new Score()))
    , mEditAreaInformation_(new EditAreaInformation(1, 1, 5, 4000))
    , mClient_(new Client(QUrl(QStringLiteral("ws://localhost:8080")), this))
    , mLibraryInformation_(
          waltz::editor::LibraryComponent::CharacterImage(),
          waltz::editor::LibraryComponent::Description(),
          waltz::editor::LibraryComponent::LibraryName())
    , mNoteIdCounter_(0)
{
}

MainWindowModel::~MainWindowModel()
{
}
