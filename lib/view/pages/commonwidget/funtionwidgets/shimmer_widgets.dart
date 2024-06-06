 import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

Widget shimmerWidget1 (Size media){
  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: media.height * 0.08,
                              width: media.height * 0.08,
                              color: kwhiteColor,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: media.width * 0.5,
                                  height: 10,
                                  color: kwhiteColor,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: media.width * 0.3,
                                  height: 10,
                                  color:kwhiteColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: media.width,
                          height: media.width * 0.5,
                          color: kwhiteColor,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: media.width * 0.7,
                          height: 10,
                          color: kwhiteColor,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: media.width * 0.9,
                          height: 10,
                          color:kwhiteColor,
                        ),
                      ],
                    ),
                  );
}