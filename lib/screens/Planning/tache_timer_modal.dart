import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class _TacheTimerModalState extends State<TacheTimerModal>
    with WidgetsBindingObserver {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  DateTime? _startTime;
  Duration? _accumulatedDuration; // Durée accumulée avant le démarrage actuel

  String get _timerKey => 'timer_${widget.tacheId ?? 'temp'}_start';
  String get _accumulatedKey => 'timer_${widget.tacheId ?? 'temp'}_accumulated';
  String get _runningKey => 'timer_${widget.tacheId ?? 'temp'}_running';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadTimerState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Quand l'app revient au premier plan, recalculer le temps écoulé
      _loadTimerState();
    }
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final startTimeMs = prefs.getInt(_timerKey);
    final accumulatedMs = prefs.getInt(_accumulatedKey) ?? 0;
    final wasRunning = prefs.getBool(_runningKey) ?? false;

    if (mounted) {
      setState(() {
        _accumulatedDuration = Duration(milliseconds: accumulatedMs);

        if (widget.initialDuration != null && accumulatedMs == 0) {
          // Première ouverture, utiliser la durée initiale
          _elapsed = widget.initialDuration!;
          _accumulatedDuration = widget.initialDuration!;
        } else if (startTimeMs != null && wasRunning) {
          // Le chronomètre était en cours - recalculer le temps écoulé
          _startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMs);
          _elapsed =
              DateTime.now().difference(_startTime!) + _accumulatedDuration!;
          _isRunning = true;
          // Relancer le Timer pour l'affichage en temps réel
          _restartTimerForDisplay();
        } else {
          // Le chronomètre était en pause
          _elapsed = _accumulatedDuration ?? Duration.zero;
        }
      });
    }
  }

  void _restartTimerForDisplay() {
    // Annuler l'ancien timer s'il existe
    _timer?.cancel();

    // Créer un nouveau timer pour rafraîchir l'affichage
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _startTime != null && _isRunning) {
        setState(() {
          _elapsed = DateTime.now().difference(_startTime!) +
              (_accumulatedDuration ?? Duration.zero);
        });
      }
    });
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isRunning && _startTime != null) {
      await prefs.setInt(_timerKey, _startTime!.millisecondsSinceEpoch);
      await prefs.setInt(_accumulatedKey,
          (_accumulatedDuration ?? Duration.zero).inMilliseconds);
      await prefs.setBool(_runningKey, true);
    } else {
      await prefs.setInt(_accumulatedKey, _elapsed.inMilliseconds);
      await prefs.setBool(_runningKey, false);
      await prefs.remove(_timerKey);
    }
  }

  Future<void> _clearTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_timerKey);
    await prefs.remove(_accumulatedKey);
    await prefs.remove(_runningKey);
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _accumulatedDuration = _elapsed;
      _startTime = DateTime.now();
    });

    _saveTimerState();
    _restartTimerForDisplay();
  }

  void _pauseTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
      _accumulatedDuration = _elapsed;
    });

    _timer?.cancel();
    _saveTimerState();
  }

  void _saveAndClose() {
    _timer?.cancel();
    _clearTimerState();
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

          // Bouton de contrôle
          Center(
            child: ElevatedButton.icon(
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
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
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
