import 'package:flutter/material.dart';
import 'package:responsi_prakmobile/controller/api_data_source.dart';
import 'package:responsi_prakmobile/model/agentdetail_model.dart';

class AgentDetail extends StatefulWidget {
  final String id;
  const AgentDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<AgentDetail> createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Agent"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.getDetailAgent(widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            AgentsDetailModel agentList =
                AgentsDetailModel.fromJson(snapshot.data);
            return _buildItemUsers(agentList.data!);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Widget _buildSuccessSection(DetailFilms filmModel) {
  //   return ListView.builder(
  //     itemCount: 1,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildItemUsers(filmModel.search![index]);
  //     },
  //   );
  // }

  Widget _buildItemUsers(Data agent) {
    return InkWell(
      onTap: () => {},
      child: Card(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.Center,
          children: [
            Container(
              width: 100,
              child: Image.network(agent.fullPortrait!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(agent.description!),
                Text(agent.displayName!),
                Text(agent.role!.description!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
