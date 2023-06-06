import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem extends StatefulWidget {
  final YouTubeVideo video;
  final bool loading;

  const VideoItem({
    super.key,
    required this.video,
    required this.loading,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late Future<YouTubeVideo> _videoFuture;
  final ScrollController _scrollController = ScrollController();
  bool hovering = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _loadVideo() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.video.url))) {
      throw Exception('Could not launch ${widget.video.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          MouseRegion(
            onEnter: (event) => setState(() {
              hovering = true;
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(
                    seconds: 1,
                  ),
                  curve: Curves.easeInOut);
            }),
            onExit: (event) => setState(() {
              hovering = false;
              _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: Duration(
                    seconds: 1,
                  ),
                  curve: Curves.easeInOut);
            }),
            child: GestureDetector(
              onTap: _launchUrl,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                height: 175,
                width: hovering ? 280 : 260,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      height: 175,
                      width: hovering ? 280 : 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.loading
                                ? ''
                                : widget.video.thumbnail.high.url.toString(),
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 100,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [Colors.grey.withOpacity(0.0), Colors.black],
                          stops: [0.0, hovering ? 0.8 : 0.95],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                width: hovering ? 260 : 230,
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      width: hovering ? 260 : 230,
                                      child: AnimatedDefaultTextStyle(
                                        child: Text(
                                          widget.loading
                                              ? 'Loading'
                                              : widget.video.title,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        style: GoogleFonts.montserratAlternates(
                                          fontSize: hovering ? 11 : 13,
                                        ),
                                        duration: Duration(milliseconds: 75),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: hovering ? 20 : 25,
              ),
              Container(
                child: Text(
                  widget.video.channelTitle,
                  style: GoogleFonts.montserratAlternates(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
