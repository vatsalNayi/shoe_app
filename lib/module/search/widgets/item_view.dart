import 'package:flutter/material.dart';
// as search;
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../global_widgets/paginated_list_view.dart';
import '../../../global_widgets/product_view.dart';
import '../controller/search_controller.dart' as search;

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<search.SearchController>(builder: (searchController) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Center(
              child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: PaginatedListView(
                    scrollController: _scrollController,
                    dataList: searchController.searchProductList,
                    perPage: 6,
                    onPaginate: (int? offset) async => searchController
                        .searchData(searchController.prodResultText, offset!),
                    itemView: ProductView(
                      isShop: false,
                      products: searchController.searchProductList,
                    ),
                  ))),
        );
      }),
    );
  }
}
