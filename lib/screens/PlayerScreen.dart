import 'package:audio_service/audio_service.dart';
import 'package:finamp/components/AlbumImage.dart';
import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../components/PlayerScreen/SongName.dart';
import '../components/PlayerScreen/ProgressSlider.dart';
import '../components/PlayerScreen/PlayerButtons.dart';
import '../components/PlayerScreen/ExitButton.dart';
import '../components/PlayerScreen/QueueButton.dart';
import '../components/PlayerScreen/PlaybackMode.dart';
import '../services/connectIfDisconnected.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
      onVerticalSwipe: (direction) {
        if (direction == SwipeDirection.down) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        // appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  child: const _PlayerScreenAlbumImage(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SongName(),
                        const ProgressSlider(),
                        const PlayerButtons(),
                        Stack(
                          alignment: Alignment.center,
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: PlaybackMode(),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ExitButton(),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: QueueButton(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// This widget is just an AlbumImage in a StreamBuilder to get the song id.
class _PlayerScreenAlbumImage extends StatelessWidget {
  const _PlayerScreenAlbumImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
        stream: AudioService.currentMediaItemStream,
        builder: (context, snapshot) {
          connectIfDisconnected();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlbumImage(itemId: snapshot.data!.extras!["parentId"]),
          );
        });
  }
}
