
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchtogo/MainRepo.dart';
import 'package:searchtogo/Result.dart';
import 'package:searchtogo/ScanModel.dart';
import 'package:searchtogo/models/tuidestinations.dart';

class HomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartEvent extends HomeEvent {

}

class InfoEvent extends HomeEvent {

}

class UploadEvent extends HomeEvent {

}

class UploadedEvent extends HomeEvent {

  final _img;

  UploadedEvent(this._img);

  @override
  // TODO: implement props
  List<Object> get props => [_img];

}

class ScanningEvent extends HomeEvent {

  final _img;

  ScanningEvent(this._img);

  @override
  // TODO: implement props
  List<Object> get props => [_img];
}

class ResultEvent extends HomeEvent {

}

class NewScanEvent extends HomeEvent {

}

class LikeEvent extends HomeEvent {
  final TUIDestination destination;

  LikeEvent(this.destination);

  @override
  List<Object> get props => [destination];

}

class UnlikeEvent extends HomeEvent {
  final TUIDestination destination;

  UnlikeEvent(this.destination);

  @override
  List<Object> get props => [destination];
}

class FavoriteListEvent extends HomeEvent {

}

class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartState extends HomeState {

}

class InfoState extends HomeState {

}

class NotUploaded extends HomeState {

}

class ImageUploaded extends HomeState {

}

class ImageScanning extends HomeState {

}

class ImageScanned extends HomeState {
  final results;

  ImageScanned(this.results);

  List<Result> get getResults => results;

  @override
  // TODO: implement props
  List<Object> get props => [results];

}

class ImageNotScanned extends HomeState {

}

class FavoriteState extends HomeState {
  List<TUIDestination> favorites;

  FavoriteState(this.favorites);

  List<TUIDestination> get getFavorites => favorites;

  @override
  List<Object> get props => [favorites];


}

class MainBloc extends Bloc<HomeEvent, HomeState> {


  HomeRepo repo;
  Scan scan;
  MainBloc(this.repo);
  String date;
  List<Result> results;



  @override
  // TODO: implement initialState
  HomeState get initialState => StartState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is StartEvent) {
      yield StartState();
    }
    if (event is LikeEvent) {
      repo.addToFavorites(event.destination);
      print(repo.favorites);
    }
    if (event is UnlikeEvent) {
      repo.removeFromFavorites(event.destination);
      print(repo.favorites);
    }
    if (event is FavoriteListEvent) {
      yield FavoriteState(repo.favorites);
    }
    if (event is UploadEvent) {
      repo.loadDestinations();
      repo.loadModel();
      yield NotUploaded();
    }
    if (event is InfoEvent) {
      yield InfoState();
    }
    if (event is UploadedEvent) {
      yield ImageUploaded();
    }
    if (event is ScanningEvent) {
      try {
        yield ImageScanning();
        scan = await repo.getLocation(event._img);
        results = scan.getOutput;
        for (int i=0;i<results.length;i++) {
          print(results[i].destination.country);
          results[i].destination.addForecasts(await repo.getWeatherByCountry(results[i].destination.country));
        }
//        if (scan.getOutput[0].getConfidence>0.98) {
          yield ImageScanned(scan.getOutput);
//        } else {
//          yield ImageNotScanned();
//        }
      } catch(_) {
        yield ImageNotScanned();
      }
    }
    else if (event is NewScanEvent) {
        yield NotUploaded();
    }
  }
}

