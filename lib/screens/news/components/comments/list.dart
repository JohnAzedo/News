import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/models/comment.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news.dart';

import 'card.dart';

class CommentList extends StatefulWidget {
  final News news;
  CommentList(this.news);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final NewsRepository repository = NewsRepository();
  final TextEditingController _controller = TextEditingController();
  List<Comment> comments;

  @override
  void initState() {
    super.initState();
    comments = widget.news.comments;
  }

  Future<void> _createComment(Comment comment) async {
    return repository.createComment(comment, widget.news).then((comment) {
      setState(() {
        comments.insert(0, comment);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Comentários',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 4.0,
          ),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Deixe seu comentário",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final comment = Comment(text: _controller.text);
                  if (comment.text != '') {
                    _createComment(comment);
                    _controller.text = '';
                  }
                },
                child: Text(
                  'Enviar',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 0.0,
          ),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (BuildContext context, index) {
              Comment comment = comments[index];
              return CardComment(comment: comment);
            },
          ),
        )
      ],
    );
  }
}
