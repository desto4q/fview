import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fview/components/popular.dart';
import 'package:fview/components/recent_releases.dart';
import 'package:fview/components/sub/hometitle.dart';
import 'package:fview/components/top_airing.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _itemCount(),
          itemBuilder: (context, index) {
            return KeepAliveWrapper(
              child: _buildItem(index),
            );
          },
        ),
      ),
    );
  }

  int _itemCount() {
    // Number of widgets plus the gaps between them
    return const [Hometitle(), PopularComp(),TopAiringComp(), RecentReleaseComp()].length *
            2 -
        1;
  }

  Widget _buildItem(int index) {
    const widgets = [
      Hometitle(),
      PopularComp(),
      TopAiringComp(),
      RecentReleaseComp(),
    ];
    if (index.isEven) {
      return widgets[index ~/ 2];
    } else {
      return const SizedBox(height: 10);
    }
  }
}

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({required this.child, Key? key}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
