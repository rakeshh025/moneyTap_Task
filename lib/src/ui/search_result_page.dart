import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_search_app/src/blocs/search_bloc.dart';
import 'package:wiki_search_app/src/blocs/search_event.dart';
import 'package:wiki_search_app/src/blocs/search_state.dart';
import 'package:wiki_search_app/src/models/search_results.dart' as Page;
import 'package:wiki_search_app/src/ui/detail_page.dart';

class SearchResultPage extends StatefulWidget {
  /*String searchString;

  SearchResultPage({Key key, this.searchString}) : super(key: key);*/

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Wiki Search'),
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {

        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if(state is ShowLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if(state is GetSearchResultsFailed) {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: Center(
                    child: Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                    )),
              );
            }
            if (state is ShowSearchResults) {
              return buildList(state.items);
            }
            if(state is NoResults) {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.blue,
                child: Center(
                    child: Text(
                      'No results to display',
                      textAlign: TextAlign.center,
                    )),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildList(List<Page.Page> itemsList) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Theme(
            data: ThemeData(
              highlightColor: Colors.orange, //Does not work
            ),
            child: Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: GestureDetector(
                      child: ListTile(
                        leading: itemsList[index].thumbnail != null && itemsList[index].thumbnail.source != null ? CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            width: 70,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          imageUrl: itemsList[index].thumbnail.source,
                          errorWidget: (context, url, error) => getNoImageIcon(Image.asset('images/no_image_icon.png', width: 70,)),
                          width: 35,
                        ) : getNoImageIcon(Image.asset('images/no_image_icon.png', width: 70),),
                        title: Text('${itemsList[index].title}'),
                        subtitle: itemsList[index].terms != null && itemsList[index].terms.description != null
                            ? Text('${itemsList[index].terms.description[0]}')
                            : Text(''),
                        dense: true,
                      ),
                      onTap: () {
                        print('List item tapped');
                        if(itemsList[index].pageid != null && itemsList[index].pageid != 0) {
                          String url = 'https://en.wikipedia.org/?curid=${itemsList[index].pageid}';
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  item: itemsList[index],
                                  url: url,)),
                          );
                        }

                      },
                    ),
                  );
                },
                itemCount: itemsList.length,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getNoImageIcon(Widget icon) {
    return Container(
      width: 35,
      child: icon,
      color: Colors.grey,
    ) ;
  }

}
