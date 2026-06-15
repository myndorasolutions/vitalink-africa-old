import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class YorubaPromptButton extends StatefulWidget {
  const YorubaPromptButton({
    super.key,
    required this.assetFile,
    this.tooltip = 'Play Yoruba prompt',
  });

  final String assetFile;
  final String tooltip;

  @override
  State<YorubaPromptButton> createState() => _YorubaPromptButtonState();
}

class _YorubaPromptButtonState extends State<YorubaPromptButton> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _play() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/yoruba/${widget.assetFile}'));
    } catch (_) {
      // Asset may be a placeholder during pilot — offline path still safe.
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.volume_up),
      tooltip: widget.tooltip,
      onPressed: _play,
    );
  }
}
