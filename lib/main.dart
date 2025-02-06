import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guia_moteis/bloc/bloc.dart';
import 'package:guia_moteis/filter_button.dart';
import 'package:guia_moteis/motel_card.dart';
import 'package:guia_moteis/repository/motel_repository.dart';

void main() {
  runApp(const MotelApp());
}

class MotelApp extends StatelessWidget {
  const MotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Motéis',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: BlocProvider(
        create: (context) => MotelBloc(MotelRepository())..add(FetchMotels()),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: SvgPicture.asset(
            'assets/svg/appbar_background.svg',
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(255, 209, 21, 33),
              BlendMode.srcIn,
            ),
            fit: BoxFit.fill,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: const EdgeInsets.all(16),
            icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Container(
            height: 32,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 165, 12, 22),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.bolt,
                        color: Color.fromARGB(255, 209, 21, 33),
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'ir agora',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'ir outro dia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'minha localização',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
                CustomPaint(
                  size: const Size(160, 1),
                  painter: DottedLinePainter(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(16),
              icon: const Icon(Icons.search, color: Colors.white, size: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: BlocBuilder<MotelBloc, MotelState>(
        builder: (context, state) {
          if (state is MotelInitial || state is MotelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MotelLoaded) {
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(spacing: 8, children: [
                    const SizedBox(width: 16),
                    FilterButton(activeFilters: state.activeFilters.length),
                    ...state.availableFilters.map((filter) {
                      return FilterChip(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        label: Text(filter.toLowerCase(),
                            style: const TextStyle(fontSize: 12)),
                        selected: state.activeFilters.contains(filter),
                        onSelected: (bool selected) {
                          final newFilters =
                              Set<String>.from(state.activeFilters);
                          if (selected) {
                            newFilters.add(filter);
                          } else {
                            newFilters.remove(filter);
                          }
                          context
                              .read<MotelBloc>()
                              .add(UpdateFilters(newFilters));
                        },
                      );
                    })
                  ]),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.filteredMotels.length,
                    itemBuilder: (context, index) {
                      return MotelCard(motel: state.filteredMotels[index]);
                    },
                  ),
                ),
              ],
            );
          }

          if (state is MotelError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    const dashWidth = 3;
    const dashSpace = 3;
    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
