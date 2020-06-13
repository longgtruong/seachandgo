
import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchtogo/MainRepo.dart';
import 'package:searchtogo/Result.dart';
import 'package:searchtogo/ScanModel.dart';

class HomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class UploadEvent extends HomeEvent {
  final _img;

  UploadEvent(this._img);

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

class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
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

class MainBloc extends Bloc<HomeEvent, HomeState> {

  count() {
    sleep(Duration(seconds:5));
  }

  HomeRepo repo;
  Scan scan;
  MainBloc(this.repo);
  String date;
  List<Result> results;



  @override
  // TODO: implement initialState
  HomeState get initialState => NotUploaded();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is UploadEvent) {
      repo.loadDestinations();
      repo.loadModel();
      yield ImageUploaded();
    } if (event is ScanningEvent) {
      try {
        yield ImageScanning();
        scan = await repo.getLocation(event._img);
        results = scan.getOutput;
        for (int i=0;i<results.length;i++) {

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

