import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:octi/channel_item.dart';
import 'package:octi/ui_elements/sidebar.dart';
import 'package:octi/ui_elements/video_item.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:youtube_api/youtube_api.dart';

import 'ui_elements/featured_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // animCOntroller
  late final AnimationController _controller;
  late Future<List<YouTubeVideo>> _videoResultFuture;
  bool isLoading = false;

  static String key = "AIzaSyAjHmNei9j5iBL5rnjz5l9Y5rc5u5UxRzo";

  YoutubeAPI youtube = YoutubeAPI(
    key,
    maxResults: 17,
  );
  List<YouTubeVideo> videoResult = [];
  List<YouTubeVideo> trendingResult = [];

  Future<List<YouTubeVideo>> callAPI() async {
    String query = "";
    videoResult = await youtube.search(
      query,
      order: 'relevance',
      videoDuration: 'any',
    );

    trendingResult = await youtube.getTrends(regionCode: 'AU');

    return videoResult;
    // setState(() {});
    // if (videoResult.isEmpty) {
    //   isLoading = true;
    // } else {
    //   isLoading = false;
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoResultFuture = callAPI();
    print('Hello');
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('OCTI'),),
      body: Row(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: Color.fromRGBO(37, 40, 61, 1),
                  width: MediaQuery.of(context).size.width,
                ),
                FutureBuilder(
                  future: _videoResultFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final videoResult = snapshot.data!;
                      return Row(
                        children: [
                          SizedBox(
                            width: 95,
                          ),
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 95,
                                    height: 350,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                      if (index < videoResult.length) {
                                        final video = trendingResult[index];
                                        return FeaturedBanner(
                                            video: video, );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                                  ),
                                  Column(
                                    
                                    children: [
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(width: 15,),
                                          Text('Trending', style: GoogleFonts.montserratAlternates(color: Colors.white, fontSize: 29,),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width - 95,
                                height:
                                    MediaQuery.of(context).size.height - 390,
                                child: videoResult.isNotEmpty
                                    ? GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 0,
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 0,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (index < videoResult.length) {
                                            final video = videoResult[index];
                                            if (video.kind == "channel") {
                                              return Channeltem(video: video, loading: false);
                                            } else {
                                               return VideoItem(
                                                video: video, loading: false);
                                            }
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        })
                                    : Text('No Videos Found'),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                MySidebar(index: 0,),
              ],
            ),
            // child: Stack(
            //   children: [
            //     Container(
            //       // color: Color.fromRGBO(37,40,61, 1),
            //       decoration: BoxDecoration(
            //           color: Color.fromRGBO(37, 40, 61, 1),
            //           borderRadius: BorderRadius.only(
            //             topRight: Radius.circular(10),
            //             bottomRight: Radius.circular(10),
            //           )),
            //       width: 115,
            //       height: MediaQuery.of(context).size.height,
            //       child: Column(
            //         children: [
            //           Lottie.network(
            //               'https://assets6.lottiefiles.com/packages/lf20_XgtLMui9K6.json',
            //               controller: _controller,
            //               ),
            //           SizedBox(height: 20,),
            //           Container(color: Colors.red, height: 10, width: 10,)
            //         ],
            //       ),
            //     ),
          ),
        ],
      ),
    );
  }
}
