import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TacheTimerModal extends StatefulWidget {
  final String tacheTitre;
  final int? tacheId;
  final Duration? initialDuration; // Durée initiale (depuis la base de données)
  final Function(Duration) onSaveDuration;

  const TacheTimerModal({
    Key? key,
    required this.tacheTitre,
    this.tacheId,
    this.initialDuration,
    required this.onSaveDuration,
  }) : super(key: key);

  @override
  State<TacheTimerModal> createState() => _TacheTimerModalState();
}

class _TacheTimerModalState extends State<TacheTimerModal> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    // Initialiser avec la durée existante si elle existe
    if (widget.initialDuration != null) {
      _elapsed = widget.initialDuration!;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _startTime = DateTime.now().subtract(_elapsed);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsed = DateTime.now().difference(_startTime!);
        });
      }
    });
  }

  void _pauseTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
    });

    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _elapsed = Duration.zero;
      _startTime = null;
    });

    _timer?.cancel();
  }

  void _saveAndClose() {
    _timer?.cancel();
    widget.onSaveDuration(_elapsed);
    Navigator.pop(context);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barre de drag
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Titre de la tâche
          Text(
            widget.tacheTitre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 32),

          // Chronomètre
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isRunning
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFE5E7EB),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Icône horloge
                Icon(
                  Icons.timer,
                  size: 48,
                  color: _isRunning
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF6B7280),
                ),
                const SizedBox(height: 16),
                // Temps écoulé
                Text(
                  _formatDuration(_elapsed),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: _isRunning
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isRunning ? 'En cours...' : 'En pause',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Boutons de contrôle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Bouton Reset
              if (_elapsed.inSeconds > 0)
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.restart_alt, size: 20),
                  label: const Text('Réinitialiser'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

              // Bouton Démarrer/Pause
              ElevatedButton.icon(
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                icon: Icon(
                  _isRunning ? Icons.pause : Icons.play_arrow,
                  size: 24,
                ),
                label: Text(_isRunning ? 'Pause' : 'Démarrer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRunning
                      ? const Color(0xFFFFA726)
                      : const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bouton Sauvegarder et fermer
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _elapsed.inSeconds > 0 ? _saveAndClose : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4DB8AC),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: const Text(
                'Sauvegarder et fermer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bouton Annuler
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Annuler',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
