import 'package:flutter/material.dart';

class TripSummaryCard extends StatefulWidget {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusBg;
  const TripSummaryCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusBg,
  });

  @override
  State<TripSummaryCard> createState() => _TripSummaryCardState();
}

class _TripSummaryCardState extends State<TripSummaryCard>
    with SingleTickerProviderStateMixin {
  double _buttonScale = 1.0;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _buttonController.addListener(() {
      setState(() {
        _buttonScale = _buttonController.value;
      });
    });
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _onButtonTapDown(TapDownDetails details) {
    _buttonController.reverse();
  }

  void _onButtonTapUp(TapUpDetails details) {
    _buttonController.forward();
  }

  void _onButtonTapCancel() {
    _buttonController.forward();
  }

  void _onButtonHover(bool hovering) {
    if (hovering) {
      _buttonController.reverse();
    } else {
      _buttonController.forward();
    }
  }

  void _showTripModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trip Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Destino: ${widget.title}'),
            Text('Fecha: ${widget.date}'),
            Text('Estado: ${widget.status}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1AFFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.statusBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  widget.status,
                  style: TextStyle(color: widget.statusColor, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(widget.date, style: const TextStyle(color: Color(0xFF9CA3AF))),
          const SizedBox(height: 16),
          MouseRegion(
            onEnter: (_) => _onButtonHover(true),
            onExit: (_) => _onButtonHover(false),
            child: GestureDetector(
              onTapDown: _onButtonTapDown,
              onTapUp: (d) {
                _onButtonTapUp(d);
                _showTripModal(context);
              },
              onTapCancel: _onButtonTapCancel,
              child: AnimatedScale(
                scale: _buttonScale,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF2D95), Color(0xFFBD00FF)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'View Trip',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
