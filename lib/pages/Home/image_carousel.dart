import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class ImageCarousel extends StatelessWidget {
  const ImageCarousel({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      color: Colors.white,
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.23,
          aspectRatio: 16 / 9,
          viewportFraction: 0.97,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [1, 2, 3, 4, 5].map(
          (i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  child: Image.network(
                    'https://ik.imagekit.io/tannatsri/home-cr4__1LbvGvDrJA.jpeg?updatedAt=1630688393048',
                    width: MediaQuery.of(context).size.width * 1,
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