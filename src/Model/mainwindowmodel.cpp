#include <QDebug>
#include <QString>
#include <QJsonObject>
#include <QJsonDocument>
#include <QUrl>
#include "mainwindowmodel.h"
#include "src/Domain/ScoreComponent/syllable.h"
#include "src/Domain/ScoreComponent/notelength.h"
#include "src/Domain/ScoreComponent/pitch.h"
#include "src/Domain/ScoreComponent/syllable.h"
#include "src/Domain/LibraryComponent/characterimage.h"
#include "src/Domain/LibraryComponent/description.h"
#include "src/Domain/Commands/commandid.h"
#include "src/Domain/Commands/parameter.h"
#include "src/Domain/Commands/parameters.h"
#include "src/Communicator/message.h"

using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;
using namespace waltz::editor::Communicator;
using namespace waltz::editor::Commands;

namespace
{
    const CommandId COMMAND_ID_LOAD_VOICE_LIBRARY("LoadVoiceLibrary");
    const CommandId COMMAND_ID_PLAY_NOTE("PlayNote");
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
    return mEditAreaInformation_.editAreaWidth();
}
int MainWindowModel::columnWidth() const
{
    return mEditAreaInformation_.columnWidth(
                mScore_->beatParent());
}

int MainWindowModel::rowHeight() const
{
    return mEditAreaInformation_.rowHeight();
}

int MainWindowModel::supportOctave() const
{
    return mEditAreaInformation_.supportOctave();
}

void MainWindowModel::appendNote(const QString& aNoteText,
                                 int aPositionX,
                                 int aPositionY,
                                 int aNoteWidth)
{
    Note note(mEditAreaInformation_.calculatePitch(aPositionY),
              Syllable(aNoteText),
              mEditAreaInformation_.calculateNoteStartTime(aPositionX,
                                                           mScore_->beat(),
                                                           mScore_->tempo()),
              mEditAreaInformation_.calculateNoteLength(aNoteWidth,
                                                        mScore_->beat(),
                                                        mScore_->tempo()));
    mScore_->appendNote(note);

    mClient_->sendMessage(
                Message(COMMAND_ID_PLAY_NOTE,
                        note.toParameters())
                );
}


QString MainWindowModel::vocalFileExtention() const
{
    return "wvocal";
}

void MainWindowModel::loadVoiceLibrary(const QUrl &aUrl)
{
    Parameters parameters;
    parameters.append(Parameter("FilePath",aUrl.toLocalFile()));

    mClient_->sendMessage(Message(COMMAND_ID_LOAD_VOICE_LIBRARY,
                                  parameters));
}

QString MainWindowModel::characterImageUrl() const
{
    return mLibraryInformation_.characterImage().url().toString();
}

QString MainWindowModel::libraryName() const
{
    qDebug() << mLibraryInformation_.libraryName().value();
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

MainWindowModel::MainWindowModel(QObject *aParent)
    : QObject(aParent)
    , mScore_(ScorePointer(
                           new Score()))
    , mEditAreaInformation_(EditAreaInformation(1, 1, 5, 4000))
    , mClient_(new Client(QUrl(QStringLiteral("ws://localhost:8080")), this))
    , mLibraryInformation_(
          waltz::editor::LibraryComponent::CharacterImage(),
          waltz::editor::LibraryComponent::Description(),
          waltz::editor::LibraryComponent::LibraryName())
{
}

MainWindowModel::~MainWindowModel()
{
}
