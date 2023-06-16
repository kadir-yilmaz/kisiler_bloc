
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_bloc/cubit/kisi_detay_cubit.dart';
import '../model/kisi.dart';

class KisiDetaySayfa extends StatefulWidget {
  //const KisiDetaySayfa({super.key});

  Kisi kisi;
  KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {

  var tecKisiAd = TextEditingController();
  var tecKisiTel = TextEditingController();

  @override
  void initState() {
    super.initState();

    var kisi = widget.kisi;
    tecKisiAd.text = kisi.kisi_ad;
    tecKisiTel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Detay"),),
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
                context.read<KisiDetayCubit>().guncelle(int.parse(widget.kisi.kisi_id), tecKisiAd.text, tecKisiTel.text);
              }, child: Text("Güncelle")),
            ],),
        ),
      ),
    );
  }
}
