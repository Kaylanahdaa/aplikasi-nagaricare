import 'package:flutter/material.dart';
import '/models/post_model.dart';
import '/screens/post_screen.dart';
import 'package:ionicons/ionicons.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: questions
            .map((question) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PostScreen(
                                  question: question,
                                )));
                  },
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.05),
                              offset: const Offset(0.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage(question.author.imageUrl),
                                      radius: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Text(
                                              question.question,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: .4),
                                            ),
                                          ),
                                          const SizedBox(height: 2.0),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                question.author.name,
                                                style: TextStyle(
                                                    color: Colors.red
                                                        .withOpacity(0.6)),
                                              ),
                                              const SizedBox(width: 15),
                                              Text(
                                                question.created_at,
                                                style: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.6)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Ionicons.bookmark,
                                  color: Colors.grey.withOpacity(0.6),
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                "${question.content.substring(0, 80)}..",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.8),
                                    fontSize: 16,
                                    letterSpacing: .3),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Ionicons.thumbs_up,
                                    color: Colors.grey.withOpacity(0.6),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "${question.votes} votes",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.6),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Ionicons.mail,
                                    color: Colors.grey.withOpacity(0.6),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "${question.repliesCount} replies",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.6)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Ionicons.eye,
                                    color: Colors.grey.withOpacity(0.6),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "${question.views} views",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.6)),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}
