#ifndef MAINWINDOWMODEL_H
#define MAINWINDOWMODEL_H

#include <QObject>
#include <QUrl>
#include <QImage>
#include <QString>
#include <QPoint>
#include <QTimer>

#include "editorclipboard.h"
#include "src/Domain/ScoreComponent/score.h"
#include "src/Communicator/client.h"
#include "src/Model/editareainformation.h"
#include "src/Domain/LibraryComponent/libraryinformation.h"
#include "src/Domain/ScoreComponent/note.h"

namespace waltz
{
    namespace editor
    {
        namespace model
        {
            class MainWindowModel : public QObject
            {
                Q_OBJECT
            public:
                static MainWindowModel& getInstance();

            public:
                void setLibraryInformation(
                        const waltz::editor::LibraryComponent::LibraryInformationPointer aLibraryInformation);
                void emitErrorOccurred(const QString& aErrorMessage);
                void emitActivePlayButton();
                void emitStartSeekBar();
                void emitResetSeekBar();
                void emitPauseSeekBar();

            public:
                // Invocable Methods
                // For Score
                Q_INVOKABLE void setTempo(int aTempo);
                Q_INVOKABLE void setBeatParent(int aBeatParent);
                Q_INVOKABLE void setBeatChild(int aBeatChild);
                Q_INVOKABLE void appendNote(int aNoteId,
                                            const QString& aNoteText,
                                            int aPositionX,
                                            int aPositionY,
                                            int noteWidth);
                Q_INVOKABLE void appendNoteVolume(int aNoteId,
                                                  int aVolume);
                Q_INVOKABLE void appendPitchChangingPoint(int aX, int aY);

                Q_INVOKABLE void appendVibrato(int aNoteId,
                                               int aLength,
                                               int aWaveLength,
                                               double aAmplitude);

                Q_INVOKABLE int tempo() const;
                Q_INVOKABLE int beatChild() const;
                Q_INVOKABLE int beatParent() const;
                Q_INVOKABLE void clearScore();

                // for EditArea
                Q_INVOKABLE int editAreaWidth() const;
                Q_INVOKABLE int columnWidth() const;
                Q_INVOKABLE int rowHeight() const;
                Q_INVOKABLE int supportOctave() const;

                // for Voice Library
                Q_INVOKABLE void loadVoiceLibrary(const QUrl& aUrl);
                Q_INVOKABLE QString characterImageUrl() const;
                Q_INVOKABLE QString libraryName() const;
                Q_INVOKABLE QString libraryDescription() const;
                Q_INVOKABLE QString vocalFileExtention() const;

                // for Controller
                Q_INVOKABLE void play(int aSeekBarPosition = 0);
                Q_INVOKABLE void stop();
                Q_INVOKABLE void pause();

                // for toolBar
                Q_INVOKABLE void saveWav(const QUrl& aUrl);
                Q_INVOKABLE void save(const QUrl& aUrl,
                                      const QVariantMap& aData);

                Q_INVOKABLE QVariantMap load(const QUrl& aUrl);

                // for HistoryData
                Q_INVOKABLE void writeHistory(const QVariantMap& aData);
                Q_INVOKABLE QVariantMap readPreviousHistoryData();
                Q_INVOKABLE QVariantMap readNextHistoryData();
                Q_INVOKABLE bool hasPreviousHistoryData();
                Q_INVOKABLE bool hasNextHistoryData();


                // for Clipboard
                Q_INVOKABLE void saveToClipboard(const QVariantMap& aData);
                Q_INVOKABLE QVariantMap loadFromClipboard() const;

                // for context menu
                Q_INVOKABLE QPoint cursorPosition() const;

                Q_INVOKABLE QStringList splitLyrics(const QString& aLyrics) const;

                Q_INVOKABLE void exit() const;

            signals:
                void errorOccurred(const QString& aErrorMessage);
                void activePlayButton();
                void libraryInformationUpdated();
                void scoreUpdated();
                void historyDataUpdated();
                void startSeekBar();
                void resetSeekBar();
                void pauseSeekBar();


            private:
                static MainWindowModel*              mInstance_;
                ScoreComponent::ScorePointer         mScore_;
                EditAreaInformationPointer           mEditAreaInformation_;
                Communicator::Client*                mClient_;
                LibraryComponent::LibraryInformationPointer mLibraryInformation_;
                EditorClipboardPointer               mEditorClipboard_;
                QTimer*                              mExitTimer_;

            private:
                explicit MainWindowModel(QObject *parent = 0);
                ~MainWindowModel();
            };
        } // namespace model
    } // namespace editor
} // namespace waltz

#endif // MAINWINDOWMODEL_H
