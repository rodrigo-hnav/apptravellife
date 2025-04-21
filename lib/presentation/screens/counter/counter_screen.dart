import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptravellife/presentation/providers/counter_provider.dart';
import 'package:apptravellife/presentation/providers/theme_provider.dart';
import 'package:apptravellife/data/seed_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apptravellife/firebase_options.dart';
import 'dart:developer';

class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int clickCounter = ref.watch(counterProvider);
    final bool isDarkmode = ref.watch(isDarkmodeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            icon: Icon(
              isDarkmode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            ),
            onPressed: () {
              ref.read(isDarkmodeProvider.notifier).update((state) => !state);
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor: $clickCounter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Sembrando datos de inicio...')),
                );
                try {
                  // Inicializar Firebase si es necesario
                  await Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  );
                  final logs = await seedAllWithLogs();
                  String logFilePath;
                  if (kIsWeb) {
                    // Web: solo muestra el log en pantalla, no descarga archivo
                    logFilePath =
                        'Solo visualización, no guardado ni descarga de archivo.';
                  } else {
                    // Mobile/Desktop: solo muestra el log en pantalla
                    logFilePath = 'Solo visualización, no guardado en archivo.';
                  }
                  if (!context.mounted) return;
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Datos de inicio cargados correctamente. Log guardado o descargado.',
                      ),
                    ),
                  );
                  // Feedback visual: obtener y mostrar los primeros 2 usuarios y 2 viajes
                  final usersSnapshot =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .limit(2)
                          .get();
                  final tripsSnapshot =
                      await FirebaseFirestore.instance
                          .collection('trips')
                          .limit(2)
                          .get();
                  final usersList = usersSnapshot.docs.map((d) => d.data());
                  final tripsList = tripsSnapshot.docs.map((d) => d.data());
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: const Text('Datos de ejemplo en Firestore'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Usuarios:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ...usersList.map((u) => Text(u.toString())),
                                const SizedBox(height: 12),
                                const Text(
                                  'Viajes:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ...tripsList.map((t) => Text(t.toString())),
                                const SizedBox(height: 18),
                                const Text(
                                  'Log de queries:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ...logs.map(
                                  (l) => Text(
                                    l,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF444444),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Log: $logFilePath',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF888888),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('Error al poblar datos: ${e.toString()}'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.dataset),
              label: const Text('Data de inicio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'fab_add',
            child: const Icon(Icons.add),
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'fab_query',
            backgroundColor: Colors.blue,
            child: const Icon(Icons.search),
            onPressed: () async {
              // Consulta los datos de usuarios y viajes y los imprime por consola en Chrome
              final usersSnapshot =
                  await FirebaseFirestore.instance.collection('users').get();
              final tripsSnapshot =
                  await FirebaseFirestore.instance.collection('trips').get();
              final usersList =
                  usersSnapshot.docs.map((d) => d.data()).toList();
              final tripsList =
                  tripsSnapshot.docs.map((d) => d.data()).toList();
              if (kIsWeb) {
                // Imprimir datos en la consola de Chrome
                log('Usuarios en Firestore:');
                log(usersList.toString());
                log('Viajes en Firestore:');
                log(tripsList.toString());
              }
              // También puedes mostrar feedback visual si lo deseas
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Consulta realizada. Revisa la consola de Chrome.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
