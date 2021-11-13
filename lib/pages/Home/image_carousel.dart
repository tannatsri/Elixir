import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elixir/common/initializer.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    List<String> getSliderLinks() {
      List<String> carouselSlider = [];
      dynamic details = Init.resources.data;
      for (var i = 0; i < details.length; i++) {
        if (details[i]['resource_name'] == 'home_page_banner') {
          carouselSlider.add(details[i]['resource_image_url'].toString());
        }
      }
      return carouselSlider;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.29,
          aspectRatio: 16 / 9,
          viewportFraction: 0.98,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: getSliderLinks().map(
          (i) {
            return Builder(
              builder: (BuildContext context) {
///////////////////////////////////////////////////////////////////////////////
                // error to be resovled image carousel is building every time
                // print('buidling!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                   
                    fit: BoxFit.contain,
                    imageUrl: i,
                    progressIndicatorBuilder: (
                      context,
                      url,
                      downloadProgress,
                    ) =>
                        JumpingDotsProgressIndicator(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),

                );
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
