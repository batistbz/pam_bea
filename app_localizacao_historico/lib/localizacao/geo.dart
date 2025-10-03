import 'package:geolocator/geolocator.dart';

Future<Position> getLocalizacaoAtual () async{
  
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnable){
    return Future.error("Serviço de localização desabilitado");

  }

  LocationPermission permissao = await Geolocator.checkPermission();
  if(permissao == LocationPermission.denied){
    permissao = await Geolocator.requestPermission();
    if(permissao == LocationPermission.denied){
      return Future.error("Permissão de localização negada");
    }

  }

  return
  await
  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}