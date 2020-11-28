import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/sub_reddit_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/sub_reddit_display_widget.dart';

class SubRedditPage extends StatelessWidget {
  const SubRedditPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SubReddit"),
      ),
      body: Container(
        child: buildBody(context),
      ),
    );
  }
}

BlocProvider<SubRedditBloc> buildBody(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return BlocProvider(
    create: (_) => sl<SubRedditBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<SubRedditBloc, SubRedditState>(
          builder: (context, state) {
            if (state is Loading) {
              BlocProvider.of<SubRedditBloc>(context).add(GetSubRedditPosts());
              return LoadingWidget(
                size: size,
              );
            } else if (state is Loaded) {
              return SubRedditDisplay(
                size: size,
                subReddit: state.subRedditModel,
              );
            } else if (state is Error) {
              return MessageDisplay(size: size, message: state.message);
            }
          },
        ),
      ),
    ),
  );
}
