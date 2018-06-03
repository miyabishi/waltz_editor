#include <QString>
#include <QUrl>
#include <QMessageBox>
#include <QApplication>
#include <QTimer>
#include <waltz_common/commandid.h>
#include <waltz_common/parameter.h>
#include <waltz_common/parameters.h>
#include <waltz_common/message.h>

#include "mainwindowmodel.h"
#include "src/Domain/LibraryComponent/characterimage.h"
#include "src/Domain/LibraryComponent/description.h"
#include "src/Domain/LibraryComponent/libraryfilepath.h"

#include "src/Domain/ScoreComponent/noteinformation.h"
#include "src/Domain/ScoreComponent/notevolume.h"
#include "src/Domain/ScoreComponent/notestarttime.h"

#include "src/Domain/ScoreComponent/vibratoamplitude.h"
#include "src/Domain/ScoreComponent/vibratolength.h"
#include "src/Domain/ScoreComponent/vibratowavelength.h"
#include "src/Domain/ScoreComponent/playbackstartingtime.h"

#include "src/Domain/History/historydatarepository.h"
#include "src/Domain/ExternalFile/waltzsongfile.h"
#include "src/Settings/editorsettings.h"


using namespace waltz::common::Communicator;
using namespace waltz::common::Commands;

using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;
using namespace waltz::editor::Communicator;
using namespace waltz::editor::Settings;

namespace
{
    const CommandId COMMAND_ID_LOAD_VOICE_LIBRARY("LoadVoiceLibrary");
    const CommandId COMMAND_ID_LOAD_DEFAULT_VOICE_LIBRARY("LoadDefaultVoiceLibrary");
    const CommandId COMMAND_ID_PLAY_NOTE("PlayNote");
    const CommandId COMMAND_ID_PLAY_SCORE("PlayScore");
    const CommandId COMMAND_ID_STOP("Stop");
    const CommandId COMMAND_ID_PAUSE("Pause");
    const CommandId COMMAND_ID_SAVE_WAV("SaveWav");
    const CommandId COMMAND_ID_EXIT("Exit");
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

QString MainWindowModel::libraryPath() const
{
    return mLibraryInformation_->libraryPath();
}

void MainWindowModel::setLibraryInformation(
        const waltz::editor::LibraryComponent::LibraryInformationPointer aLibraryInformation)
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
    return mEditAreaInformation_->editAreaWidth(mScore_->beatParent(), mScore_->beatChild());
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
    NoteInformationPointer noteInformation(
                new NoteInformation(aNoteId,
                                    aNoteText,
                                    aPositionX,
                                    aPositionY,
                                    aNoteWidth,
                                    mEditAreaInformation_->rowHeight()));

    NotePointer note(noteInformation->note());

    mScore_->appendNote(note);
    mClient_->sendMessage(Message(COMMAND_ID_PLAY_NOTE,
                                  note->toParameters(mScore_->beat(),
                                                     mScore_->tempo(),
                                                     mEditAreaInformation_)));
    scoreUpdated();
}

void MainWindowModel::appendNoteVolume(int aNoteId, int aVolume)
{
    mScore_->appendNoteParameter(NoteId(aNoteId),
                                 NoteParameterPointer(new NoteVolume(aVolume)));
}

void MainWindowModel::appendPitchChangingPoint(int aX, int aY)
{
    mScore_->appendPitchChangingPoint(
                PitchChangingPointPointer(new PitchChangingPoint(aX, aY)));
}

void MainWindowModel::clearScore()
{
    mScore_->clearScore();
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
    if (mLibraryInformation_.isNull())
    {
        return QString();
    }
    return mLibraryInformation_->characterImage()->url().toString();
}

QString MainWindowModel::libraryName() const
{
    if (mLibraryInformation_.isNull())
    {
        return QString();
    }
    return mLibraryInformation_->libraryName()->value();
}

QString MainWindowModel::libraryDescription() const
{
    if (mLibraryInformation_.isNull())
    {
        return QString();
    }
    return mLibraryInformation_->description()->value();
}

void MainWindowModel::emitErrorOccurred(const QString& aErrorMessage)
{
    emit errorOccurred(aErrorMessage);
}

void MainWindowModel::play(int aSeekBarPosition)
{
    PlaybackStartingTimePointer playbackStartTime(
                new PlaybackStartingTime(
                    mEditAreaInformation_->calculateSec(aSeekBarPosition,
                                                        mScore_->beat(),
                                                        mScore_->tempo())));
    Parameters parameters(mScore_->toParameters(mEditAreaInformation_));

    parameters.append(playbackStartTime->toParameter());

    mClient_->sendMessage(Message(COMMAND_ID_PLAY_SCORE, parameters));
}

void MainWindowModel::appendVibrato(int aNoteId,
                                    int aLength,
                                    int aWavelength,
                                    double aAmplitude)
{
    NoteId noteId (aNoteId);
    mScore_->appendNoteParameter(noteId, NoteParameterPointer(new VibratoLength(aLength)));
    mScore_->appendNoteParameter(noteId, NoteParameterPointer(new VibratoWavelength(aWavelength)));
    mScore_->appendNoteParameter(noteId, NoteParameterPointer(new VibratoAmplitude(aAmplitude)));
}

void MainWindowModel::emitActivePlayButton()
{
    emit activePlayButton();
}

void MainWindowModel::emitStartSeekBar()
{
    emit startSeekBar();
}

void MainWindowModel::emitResetSeekBar()
{
    emit resetSeekBar();
}

void MainWindowModel::emitPauseSeekBar()
{
    emit pauseSeekBar();
}

void MainWindowModel::save(const QUrl &aUrl,
                           const QVariantMap& aData)
{
    QVariantMap data =  aData;
    ExternalFile::WaltzSongFile waltzSongFile(aUrl.toLocalFile());

    if (! mLibraryInformation_.isNull())
    {
        data = mLibraryInformation_->insertLibraryFilePathVariant(data);
    }

    waltzSongFile.save(data);
}

QVariantMap MainWindowModel::load(const QUrl &aUrl)
{
    ExternalFile::WaltzSongFile waltzSongFile(aUrl.toLocalFile());
    QVariantMap data = waltzSongFile.load();
    loadVoiceLibrary(QUrl::fromLocalFile(waltz::editor::LibraryComponent::LibraryFilePath::fromVariantMap(data)->toString()));

    return data;
}

void MainWindowModel::stop()
{
    mClient_->sendMessage(Message(COMMAND_ID_STOP));
    emit resetSeekBar();
}

void MainWindowModel::pause()
{
    mClient_->sendMessage(Message(COMMAND_ID_STOP));
    emit pauseSeekBar();
}

void MainWindowModel::writeHistory(const QVariantMap& aData)
{
    History::HistoryDataRepository::getInstance().appendHistoryData(
                History::HistoryDataPointer(new History::HistoryData(aData)));
    historyDataUpdated();
}

QVariantMap MainWindowModel::readPreviousHistoryData()
{
    QVariantMap data = History::HistoryDataRepository::getInstance().moveHeadToPreviousData()->value();
    historyDataUpdated();
    return data;
}

QVariantMap MainWindowModel::readNextHistoryData()
{
    QVariantMap data = History::HistoryDataRepository::getInstance().moveHeadToNextData()->value();
    historyDataUpdated();
    return data;
}

bool MainWindowModel::hasPreviousHistoryData()
{
    return History::HistoryDataRepository::getInstance().hasPreviousData();
}

bool MainWindowModel::hasNextHistoryData()
{
    return History::HistoryDataRepository::getInstance().hasNextData();
}

void MainWindowModel::saveToClipboard(const QVariantMap& aData)
{
    mEditorClipboard_->save(aData);
}

QVariantMap MainWindowModel::loadFromClipboard() const
{
    return mEditorClipboard_->load();
}

QPoint MainWindowModel::cursorPosition() const
{
    return QCursor::pos();
}

QStringList MainWindowModel::splitLyrics(const QString& aLyrics) const
{
    QString lyrics(aLyrics.simplified());
    QStringList splitLyrics;

    if (mLibraryInformation_.isNull())
    {
        return QStringList();
    }

    while(lyrics.size() > 0)
    {
        bool hitFlag = false;
        QString hitAlias;

        for(int searchLyricsLengthIndex = lyrics.length();
            searchLyricsLengthIndex > 0;
            --searchLyricsLengthIndex)
        {
            foreach (const QString& alias, mLibraryInformation_->correspondenceAliasStringList())
            {
                QString leftSideOfLyrics = lyrics.left(searchLyricsLengthIndex);
                if (alias != leftSideOfLyrics) continue;

                hitFlag = true;
                splitLyrics.append(alias);
                hitAlias = alias;
                break;
            }
            if (hitFlag) break;
        }
        if (hitFlag == false)
        {
            lyrics = lyrics.mid(1, lyrics.size());
        }
        else
        {
            lyrics = lyrics.mid(hitAlias.size(), lyrics.size());
        }
    }

    return splitLyrics;
}

void MainWindowModel::exit() const
{
    mClient_->sendMessage(Message(COMMAND_ID_EXIT));
    QTimer::singleShot(100, qApp, SLOT(quit()));
}

void MainWindowModel::loadDefaultLibrary() const
{
    qDebug() << "load default library!!";
    mClient_->sendMessage(Message(COMMAND_ID_LOAD_DEFAULT_VOICE_LIBRARY));
}

void MainWindowModel::notifyIsReady()
{
    emit isReady();
}

MainWindowModel::MainWindowModel(QObject *aParent)
    : QObject(aParent)
    , mScore_(ScorePointer(new Score()))
    , mEditAreaInformation_(new EditAreaInformation(1, 1, 5, 100))
    , mClient_(new Client(QUrl(QString("ws://localhost:")
                                   + EditorSettings::getInstance().clientPort()), this))
    , mLibraryInformation_()
    , mEditorClipboard_(new EditorClipboard())
{
}

MainWindowModel::~MainWindowModel()
{
}
