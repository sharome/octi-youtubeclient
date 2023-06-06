import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedBanner extends StatefulWidget {
  final YouTubeVideo video;
  const FeaturedBanner({super.key, required this.video});

  @override
  State<FeaturedBanner> createState() => _FeaturedBannerState();
}

class _FeaturedBannerState extends State<FeaturedBanner> {
  bool hovering = false;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.video.url))) {
      throw Exception('Could not launch ${widget.video.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        hovering = true;
      }),
      onExit: (event) => setState(() {
        hovering = false;
      }),
      child: GestureDetector(
        onTap: _launchUrl,
        child: Stack(
          children: [
            Container(
              height: 350,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.video.thumbnail.high.url.toString()),
                ),
              ),
            ),
            AnimatedContainer(
              height: 350,
              width: 301,
              duration: Duration(
                milliseconds: 100,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Colors.grey.withOpacity(0.0), Colors.black],
                  stops: [0.0, hovering ? 0.8 : 0.95],
                ),
              ),
            ),
            Container(
              height: 350,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 190,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: hovering ? 280 : 270,
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 50),
                          style: GoogleFonts.montserratAlternates(
                            color: Colors.white,
                            fontSize: hovering ? 10 : 12,
                          ),
                          child: Text(
                            widget.video.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
