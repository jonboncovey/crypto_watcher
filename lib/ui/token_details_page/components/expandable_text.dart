import 'package:crypto_watcher/bloc/token/token_bloc.dart';
import 'package:crypto_watcher/ui/core/cw_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class ExpandableText extends StatelessWidget {
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    Key? key,
    this.maxLines = 6,
    this.style,
  }) : super(key: key);

  void _showFullText(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Html(data: text),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CwContainer(
      child: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
        if (state.status == TokenStateStatus.loading)
          return const Text('Loading...');
        if (state.status == TokenStateStatus.error) {
          return const Center(child: Text('Error Loading Description >.<'));
        }
        return InkWell(
          onTap: () => _showFullText(
              context, state.selectedToken.description ?? 'Loading...'),
          child: Text(
            state.selectedToken.description ?? 'Loading...',
            style: style,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }),
    );
  }
}
