import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octi/channel_item.dart';
import 'package:octi/ui_elements/sidebar.dart';
import 'package:youtube_api/youtube_api.dart';

import 'ui_elements/video_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<YouTubeVideo>> _videoResultFuture;

  TextEditingController _searchController = TextEditingController();

  static String key = "AIzaSyAjHmNei9j5iBL5rnjz5l9Y5rc5u5UxRzo";
  String myQuery = "trending";

  YoutubeAPI youtube = YoutubeAPI(
    key,
    maxResults: 15,
  );

  List<YouTubeVideo> videoResult = [];

  Future<List<YouTubeVideo>> callAPI(String query) async {
    videoResult = await youtube.search(
      query,
      order: 'relevance',
      videoDuration: 'any',
    );

    return videoResult;
    // setState(() {});
    // if (videoResult.isEmpty) {
    //   isLoading = true;
    // } else {
    //   isLoading = false;
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  // void _onSearchChanged() {
  //   setState(() {
  //     query = _searchController.text;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _searchController.addListener(_onSearchChanged);
    _videoResultFuture = callAPI(myQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 40, 61, 1),
      body: Row(
        children: [
          MySidebar(
            index: 1,
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 100,
                width: MediaQuery.of(context).size.width - 95,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    // onChanged: _onSearchChanged(),
                    onChanged: (value) {
                      setState(() {
                        myQuery = value;
                        _videoResultFuture = callAPI(myQuery);

                        print('Query Changed to ${myQuery}');
                      });
                    },
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.montserratAlternates(
                        fontSize: 30,
                         color: Colors.white10,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width - 95,
                color: Colors.transparent,
                child: FutureBuilder(
                  future: _videoResultFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final videoResult = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 10,
                            ),
                        itemBuilder: ((context, index) {
                          if (index < videoResult.length) {
                            final video = videoResult[index];
                            if (video.kind == "channel") {
                              return Channeltem(video: video, loading: false);
                            } else {
                              return VideoItem(video: video, loading: false,);
                            }

                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
