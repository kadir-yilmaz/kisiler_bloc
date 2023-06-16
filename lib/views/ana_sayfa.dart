import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_bloc/cubit/ana_sayfa_cubit.dart';
import 'package:kisiler_bloc/views/kisi_detay_sayfa.dart';
import 'package:kisiler_bloc/views/kisi_kayit_sayfa.dart';

import '../model/kisi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();

    context.read<AnaSayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
          decoration: InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            context.read<AnaSayfaCubit>().ara(aramaSonucu);
          },
        )
            : const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = false;
              });
              context.read<AnaSayfaCubit>().kisileriYukle();
            },
            icon: const Icon(Icons.clear),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<AnaSayfaCubit, List<Kisi>>(
        builder: (context, kisiListesi) {
          if (kisiListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: kisiListesi.length,
              itemBuilder: (context, index) {
                var kisi = kisiListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KisiDetaySayfa(kisi: kisi),
                      ),
                    ).then((value) => () {
                      context.read<AnaSayfaCubit>().kisileriYukle();
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kisi.kisi_ad,
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${kisi.kisi_ad} silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: () {
                                      context.read<AnaSayfaCubit>().sil(int.parse(kisi.kisi_id));
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KisiKayitSayfa(),
            ),
          ).then((value) {
            context.read<AnaSayfaCubit>().kisileriYukle();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
