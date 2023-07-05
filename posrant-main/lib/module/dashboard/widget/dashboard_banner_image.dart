import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardBannerImage extends StatelessWidget {
  DashboardBannerImage({Key? key}) : super(key: key);

  final List<String> images = [
    "assets/images/banner-1.jpg",
    "assets/images/banner-2.jpeg",
    // Add more image paths here
  ];

  final List<String> text1 = [
    "Hi, welcome in",
    "Happy working",
    // Add more texts here
  ];

  final List<String> text2 = [
    "Cashier management posrant",
    "give the best for consumers",
    // Add more texts here
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        height: 180.0,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              Positioned(
                left: 20.0,
                top: 0.0,
                bottom: 0.0,
                child: SizedBox(
                  width: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text1[index],
                        style: GoogleFonts.oswald(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        text2[index],
                        style: GoogleFonts.oswald(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
