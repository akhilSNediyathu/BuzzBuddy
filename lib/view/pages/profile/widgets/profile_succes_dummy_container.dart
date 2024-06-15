import 'package:buzz_buddy/utils/constants.dart';

import 'package:flutter/material.dart';

Widget profileContainer (Size media,String profileImage,String coverImage,){
      return Container(
                                    height: 210,
                                    width: media.width,
                                    decoration: BoxDecoration(
                                      color: kwhiteColor,
                                      image: DecorationImage(
                                        image: NetworkImage(coverImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          bottom: -60,
                                          left: 20,
                                          child: Container(
                                            height: 180,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              color: kwhiteColor,
                                              border: Border.all(
                                                  width: 5, color: kwhiteColor),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    profileImage),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
}