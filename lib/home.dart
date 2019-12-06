import 'package:flutter/material.dart';
import 'package:github_search/bloc/search_bloc.dart';
import 'package:github_search/models/search_item.dart';
import 'package:github_search/models/search_resut.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    _searchBloc = new SearchBloc();
    super.initState();
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: <Widget>[
          _fieldSearch(),
          _repositoriesList(),
        ],
      ),
    );
  }

  Widget _fieldSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: _searchBloc.searchEvent.add,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Digite o nome do repositório",
          labelText: "Pesquisa",
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _repositoriesList() {
    return Expanded(
      child: StreamBuilder<SearchResult>(
        stream: _searchBloc.apiResultFlux,
        builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _listTile(
                      item: snapshot.data.items[index],
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget _listTile({SearchItem item}) {
    return ListTile(
      title: Text(item.fullName),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.avatarUrl),
      ),
    );
  }
}
