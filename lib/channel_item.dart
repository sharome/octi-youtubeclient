import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:url_launcher/url_launcher.dart';

class Channeltem extends StatefulWidget {
  final YouTubeVideo video;
  final bool loading;

  const Channeltem({
    super.key,
    required this.video,
    required this.loading,
  });

  @override
  State<Channeltem> createState() => _ChanneltemState();
}

class _ChanneltemState extends State<Channeltem> {
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
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      height: 175,
                      width: hovering ? 280 : 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                        shape: BoxShape.circle,
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
                width: 100,
              ),
              Container(
                width: hovering ? 150 : 100,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 100),
                  style: GoogleFonts.montserratAlternates(
                    color: Colors.grey,
                    fontSize: hovering ? 10 : 12,
                  ),
                  child: Text(
                    widget.video.channelTitle,
                    overflow: TextOverflow.ellipsis,
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
