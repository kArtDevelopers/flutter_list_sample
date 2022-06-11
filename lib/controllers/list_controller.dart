// This class is extended by ChangeNotifier
// Since we will be notifying the Consumers or Listening widgets
import 'package:flutter/material.dart';
import 'package:flutter_list_sample/utils/data_state.dart';
import 'package:flutter_list_sample/models/events_model.dart';

import '../network/api_manager.dart';

class ListController extends ChangeNotifier {
  int _currentPageNumber = 1; // Current Page to get Data from API
  int _totalPages = 2; // Total Pages of Data from API
  DataState _dataState = DataState.Uninitialized; // Current State of Data. Initially it will be UnInitialized
  bool get _didLastLoad => _currentPageNumber >= _totalPages; // Property through which we can check if last page have been loaded from API or not
  DataState get dataState => _dataState; // getters of State of Data
  List<Events> _dataList = []; // List Containing the data
  List<Events> get dataList => _dataList;

  // Method to Fetch Data, I will explain it below the code
  fetchData({String q='', bool isRefresh = false}) async {
    if (!isRefresh) {
      _dataState = (_dataState == DataState.Uninitialized)
          ? DataState.Initial_Fetching
          : DataState.More_Fetching;
    } else {
      _dataList.clear();
      _currentPageNumber = 1;
      _dataState = DataState.Refreshing;
    }
    notifyListeners();
    try {
      if (_didLastLoad) {
        _dataState = DataState.No_More_Data;
      } else {
        EventsModel eventsModel= await APIManager().fetchData(_currentPageNumber,q);
        List<Events> list = eventsModel.events??[];
          Meta? meta = eventsModel.meta;
          if(list.isNotEmpty){
            _dataList += list;
            _dataState = DataState.Fetched;
            _currentPageNumber += 1;
            _totalPages = meta?.total??2;
          }else{
            _dataList.clear();
            _dataState = DataState.No_Data;
            _currentPageNumber = 1;
            _totalPages = 2;
          }
      }
      notifyListeners();
    } catch (e) {
      _dataState = DataState.Error;
      notifyListeners();
    }
  }
}