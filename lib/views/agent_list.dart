import 'package:flutter/material.dart';
import 'package:responsi_prakmobile/controller/api_data_source.dart';
import 'package:responsi_prakmobile/model/agent_model.dart';
import 'package:responsi_prakmobile/views/agent_detail.dart';

class AgentList extends StatefulWidget {
  const AgentList({Key? key}) : super(key: key);

  @override
  State<AgentList> createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadListAgents(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            AgentsModel agentList = AgentsModel.fromJson(snapshot.data);
            return _buildSuccessSection(agentList);
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

  Widget _buildSuccessSection(AgentsModel agentList) {
    return ListView.builder(
      itemCount: agentList.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(agentList.data![index]);
      },
    );
  }

  Widget _buildItemUsers(Data agent) {
    return InkWell(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AgentDetail(id: agent.uuid!);
        }))
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(agent.bustPortrait!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(agent.displayName!), Text(agent.characterTags!)],
            ),
          ],
        ),
      ),
    );
  }
}
