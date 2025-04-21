import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptravellife/presentation/providers/user_sesion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:apptravellife/data/services/trip_service.dart';

class CreateTripCard extends ConsumerWidget {
  const CreateTripCard({super.key});

  void _showCreateTripModal(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final destinationController = TextEditingController();
    Timestamp? startDate;
    Timestamp? endDate;
    String status = 'Active';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear nuevo viaje'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: destinationController,
                        decoration: const InputDecoration(labelText: 'Destino'),
                        validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  setState(() {
                                    startDate = Timestamp.fromDate(date);
                                  });
                                }
                              },
                              child: Text(startDate == null ? 'Fecha inicio' : startDate!.toDate().toString().split(' ')[0]),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  setState(() {
                                    endDate = Timestamp.fromDate(date);
                                  });
                                }
                              },
                              child: Text(endDate == null ? 'Fecha fin' : endDate!.toDate().toString().split(' ')[0]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: status,
                        items: const [
                          DropdownMenuItem(value: 'Active', child: Text('Activo')),
                          DropdownMenuItem(value: 'Planning', child: Text('Planeando')),
                          DropdownMenuItem(value: 'Completed', child: Text('Completado')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            status = value ?? 'Active';
                          });
                        },
                        decoration: const InputDecoration(labelText: 'Estado'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate() && startDate != null && endDate != null) {
                  final user = ref.read(userSessionProvider);
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuario no autenticado')));
                    return;
                  }
                  await TripService.createTrip(
                    userId: user.id,
                    destination: destinationController.text,
                    startDate: startDate!,
                    endDate: endDate!,
                    status: status,
                  );
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Viaje creado correctamente')));
                }
              },
              child: const Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1AFFFFFF)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF232323),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(FontAwesomeIcons.plus, color: Color(0xFFFF2D95)),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => _showCreateTripModal(context, ref),
            child: const Text(
              'Create New Trip',
              style: TextStyle(color: Color(0xFFFF2D95)),
            ),
          ),
        ],
      ),
    );
  }
}
