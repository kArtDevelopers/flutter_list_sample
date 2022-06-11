import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_sample/screens/event_detail.dart';
import 'package:flutter_list_sample/utils/logs.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; //for DateFormat()

import '../utils/data_state.dart';
import '../controllers/list_controller.dart';
import '../models/events_model.dart';

final _sController = TextEditingController();

class DataListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => ListController(),
      child: Consumer<ListController>(builder:
          (BuildContext context, ListController controller, Widget? _) {
        switch (controller.dataState) {
          case DataState.Uninitialized:
            Future(() {
              controller.fetchData();
            });
            return _ListViewWidget(controller.dataList, false);
          case DataState.Initial_Fetching:
          case DataState.More_Fetching:
          case DataState.Refreshing:
            return _ListViewWidget(controller.dataList, true);
          case DataState.Fetched:
          case DataState.Error:
          case DataState.No_More_Data:
          case DataState.No_Data:
            return _ListViewWidget(controller.dataList, false);
        }
      }),
    ));
  }
}

class _ListViewWidget extends StatelessWidget {
  final List<Events> _data;
  bool _isLoading;
  _ListViewWidget(this._data, this._isLoading);
  late DataState _dataState;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _dataState = Provider.of<ListController>(context, listen: false).dataState;
    _buildContext = context;
    return SafeArea(child: _scrollNotificationWidget());
  }

  Widget _scrollNotificationWidget() {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          color: const Color.fromRGBO(17, 49, 70, 1.0),
          child: CupertinoSearchTextField(
            style: const TextStyle(color: Colors.white),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
            suffixIcon: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Colors.white,
            ),
            controller: _sController,
            onChanged: (String value) async {
              appLogs('The text has changed to: $value');
              if (value.isEmpty) {
                await _onRefresh();
              }
            },
            onSubmitted: (String value) async {
              appLogs('Submitted text: $value');
              await _onRefresh();
            },
          ),
        ),
        _dataState == DataState.Initial_Fetching?
        const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ) :
        _dataState == DataState.No_Data?
        const Expanded(
          child: Center(
            child: Text('No data found.', style: TextStyle(fontSize:14, color: Colors.white),),
          ),
        ):
        Expanded(
            child: Container(
          color: Colors.grey[200],
          child: NotificationListener<ScrollNotification>(
              onNotification: _scrollNotification,
              child: RefreshIndicator(
                onRefresh: () async {
                  await _onRefresh();
                },
                child: ListView.separated(
                  itemCount: _data.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    Events eRow = _data[index];
                    Venue? vRow = _data[index].venue;
                    List<Performers>? lsPerformers = _data[index].performers;
                    String? date;
                    if(eRow.datetimeLocal!=null){
                      date =  getFormattedDate(getDate(eRow.datetimeLocal,format: "yyyy-MM-dd'T'HH:mm:ss"), 'EEE, dd MMM yyyy HH:mm a');
                    }
                    return ListTile(
                        dense: false,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EventDetail(title: eRow.title??'', imgUrl: lsPerformers![0].image??'', isFav: index==0,
                              dateTime : date ?? 'no-dateTime',
                              loc: vRow?.displayLocation ?? 'no-location',
                            )),
                          );
                        },
                        leading: Stack(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 11, top: 5),
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                    BorderRadius.circular(7),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            lsPerformers![0].image ??
                                                'no-img')))),
                           if(index==0) const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 22.0,
                            )
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eRow.title ?? 'no-title',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              vRow?.displayLocation ?? 'no-location',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              date ?? 'no-dateTime',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                            ),
                          ],
                        ));
                  },
                ),
              )),
        )),
        if (_dataState == DataState.More_Fetching)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _isLoading = true;
      Provider.of<ListController>(_buildContext, listen: false)
          .fetchData(q: _sController.text);
    }
    return true;
  }

  _onRefresh() async {
    if (!_isLoading) {
      _isLoading = true;
      Provider.of<ListController>(_buildContext, listen: false)
          .fetchData(q: _sController.text, isRefresh: true);
    }
  }




   getFormattedDate(var date, String to){
    return DateFormat(to).format(date);
  }

  getDate(var sDateTime,{var format = 'yyyy-MM-dd HH:mm:ss'}){
    DateTime dateTime= new DateFormat(format).parse(sDateTime);
    print(dateTime);
    return dateTime;
  }
}


