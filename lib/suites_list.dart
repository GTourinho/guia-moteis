import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/models/suite.dart';

class SuitesList extends StatefulWidget {
  final List<Suite> suites;

  const SuitesList({super.key, required this.suites});

  @override
  State<SuitesList> createState() => _SuitesListState();
}

class _SuitesListState extends State<SuitesList> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.95);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView.builder(
      clipBehavior: Clip.none,
      itemCount: widget.suites.length,
      controller: pageController,
      itemBuilder: (BuildContext context, int index) {
        final suite = widget.suites[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        suite.fotos.first,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            suite.nome.toLowerCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (suite.exibirQtdDisponiveis)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.notification_important,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Text(
                                  ' só mais ${suite.qtd} pelo app',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ...suite.categoriaItens.take(5).map(
                      (item) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: ColoredBox(
                            color: const Color.fromARGB(223, 245, 239, 239),
                            child: Image.network(
                              item.icone,
                              height: 40,
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
                        );
                      },
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Text(
                              'ver\ntodos',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 94, 88, 88),
                              ),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 16,
                              color: Color.fromARGB(255, 94, 88, 88),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              ...suite.periodos.map(
                (periodo) => InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  periodo.tempoFormatado,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                if (periodo.desconto != null)
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      '${periodo.desconto!.desconto.toInt().toString()}% off',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                if (periodo.desconto != null)
                                  Text(
                                    'R\$ ${periodo.valor.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                const SizedBox(width: 4),
                                Text(
                                  'R\$ ${periodo.valorTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          size: 32,
                          color: Color.fromARGB(255, 94, 88, 88),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
