import 'package:flutter/material.dart';
import 'package:frontend/basics_components/default_buttons.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/basics_components/default_sizes.dart';
import 'package:frontend/basics_components/dropdown_component.dart';
import 'package:frontend/basics_components/text_util.dart';
import 'package:frontend/constants/configuration_constants.dart';

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
  int pageSize = ConfigurationConstants.pageSizeDefault;

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
    return
      Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: const BoxDecoration(
          color: DefaultColors.transparency,
          borderRadius: BorderRadius.all(Radius.circular(DefaultSizes.borderRadius)),
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultButtons.transparentButton(
                      getFirstPageCallBack() ,
                      const Icon(Icons.first_page),
                      foregroundColor: DefaultColors.textColor
                  ),
                  DefaultButtons.transparentButton(
                      getPreviousPageCallBack(),
                      const Icon(Icons.navigate_before),
                      foregroundColor: DefaultColors.textColor
                  )
                ],
              )
            ),
            Flexible(
              flex: 2,
              child: TextUtil("${pageNumber + 1}/$totalPages", foreground: DefaultColors.textColor,),
            ),
            Flexible(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DefaultButtons.transparentButton(
                        getNextPageCallBack(),
                        const Icon(Icons.navigate_next),
                        foregroundColor: DefaultColors.textColor
                    ),
                    DefaultButtons.transparentButton(
                        getLastPageCallBack(),
                        const Icon(Icons.last_page),
                        foregroundColor:
                        DefaultColors.textColor
                    ),
                  ],
                )
            ),
            DropdownComponent<int>(
              pageSize, (text) => null,
              getPageOptions(), (value) => changePageSize(value), '',
              width: 90, height: 40,
            ),
          ],
        ),
      );
  }

  List<DropdownMenuItem<int>> getPageOptions() {
    return [
      DropdownMenuItem<int>(
          value: 5,
          child: Text(5.toString())
      ),
      DropdownMenuItem<int>(
          value: 10,
          child: Text(10.toString())
      ),
      DropdownMenuItem<int>(
          value: 15,
          child: Text(15.toString())
      ),
      DropdownMenuItem<int>(
          value: 25,
          child: Text(25.toString())
      ),
      DropdownMenuItem<int>(
          value: 50,
          child: Text(50.toString())
      ),
    ];
  }
  
}