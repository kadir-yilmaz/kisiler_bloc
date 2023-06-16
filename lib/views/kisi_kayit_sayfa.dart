
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/kisi_kayit_cubit.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({super.key});

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {

  var tecKisiAd = TextEditingController();
  var tecKisiTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Kişi"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tecKisiAd,
                decoration: InputDecoration(hintText: "Kişi ad"),
              ),
              TextField(
                controller: tecKisiTel,
                decoration: InputDecoration(hintText: "Kişi tel"),
              ),
              ElevatedButton(onPressed: () {
                context.read<KisiKayitCubit>().kayit(tecKisiAd.text, tecKisiTel.text);
              }, child: Text("Kaydet")),
            ],),
        ),
      ),
    );
  }
}
