import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/text_util.dart';

class PaginationBar extends StatefulWidget {

  final Function(int, int) changePage;
  final int totalRegisters;

  const PaginationBar(
    {
      required this.changePage,
      required this.totalRegisters,
      super.key
    });


  @override
  State<StatefulWidget> createState() {
    return _PaginationBarState();
  }

}

class _PaginationBarState extends State<PaginationBar> {

  int pageNumber = 0;
  int totalRegisters = 0;
  int totalPages = 0;
  int pageSize = 5;

  _PaginationBarState();

  VoidCallback getFirstPageCallBack() {
    return () {
      setState(() {
        pageNumber = 0;
        widget.changePage(pageNumber, pageSize);
      });
    };
  }

  VoidCallback getNextPageCallBack() {
    return () => setState(() {
      if (pageNumber + 1 < totalPages) {
        pageNumber = pageNumber + 1;
        widget.changePage(pageNumber, pageSize);
      }
    });
  }

  VoidCallback getPreviousPageCallBack() {
    return () {
      if (pageNumber > 0) {
        setState(() {
          pageNumber = pageNumber - 1;
        });
        widget.changePage(pageNumber, pageSize);
      }
    };
  }

  VoidCallback getLastPageCallBack() {
    return () {
      setState(() {
        pageNumber = totalPages - 1;
      });
      widget.changePage(pageNumber, pageSize);
    };
  }

  changePageSize(value) {
    setState(() {
      pageNumber = 0;
      pageSize = value;
    });
    widget.changePage(pageNumber, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    totalRegisters = widget.totalRegisters;
    totalPages = (totalRegisters / pageSize).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultButtons.transparentButton(getFirstPageCallBack() , const Icon(Icons.first_page), iconSize: 40.0),
              DefaultButtons.transparentButton(getPreviousPageCallBack() , const Icon(Icons.navigate_before), iconSize: 40.0)
            ],
          )
        ),
        Flexible(
          flex: 2,
          child: Text("${pageNumber + 1}/$totalPages"),
        ),
        Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DefaultButtons.transparentButton(getNextPageCallBack() , const Icon(Icons.navigate_next), iconSize: 40.0),
                DefaultButtons.transparentButton(getLastPageCallBack() , const Icon(Icons.last_page), iconSize: 40.0),
              ],
            )
        ),
        DropdownComponent<int>(pageSize, (text) => null, getPageOptions(), (value) => changePageSize(value), '', flex: 3)
      ],
    );
  }

  List<DropdownMenuItem<int>> getPageOptions() {
    return [
      DropdownMenuItem<int>(value: 5, child: TextUtil(5.toString(), textSize: 16,)),
      DropdownMenuItem<int>(value: 10, child: TextUtil(10.toString(), textSize: 16,)),
      DropdownMenuItem<int>(value: 15, child: TextUtil(15.toString(), textSize: 16,)),
      DropdownMenuItem<int>(value: 25, child: TextUtil(25.toString(), textSize: 16,)),
      DropdownMenuItem<int>(value: 50, child: TextUtil(50.toString(), textSize: 16,)),
    ];
  }
  
}