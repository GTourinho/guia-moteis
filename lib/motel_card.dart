import 'package:flutter/material.dart';
import 'package:guia_moteis/models/motel.dart';
import 'package:guia_moteis/suites_list.dart';

class MotelCard extends StatelessWidget {
  final Motel motel;

  const MotelCard({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    motel.logo,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey,
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        motel.fantasia.toLowerCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${motel.distancia}km',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ' - ${motel.bairro}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color(0xFFE6A706),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFFE6A706),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  motel.media.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Text(
                                '${motel.qtdAvaliacoes} avaliações',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(255, 68, 68, 68),
                    size: 28,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SuitesList(suites: motel.suites),
        ],
      ),
    );
  }
}
