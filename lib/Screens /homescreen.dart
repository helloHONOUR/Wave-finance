import 'dart:math';

import 'package:finance_app/main.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(child: CustomPaint(size: Size(25, 25), painter: Logo(0))),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('StockWave', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  TextButton(onPressed: () {}, child: Icon(size: 30, Icons.notifications, color: Colors.black)),
                ],
              ),

              // Next
              Container(
                padding: EdgeInsets.only(top: 31, bottom: 17),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Portfolio value', style: Theme.of(context).textTheme.displaySmall),
                            Text('\$13,240.11', style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.visibility_outlined, color: Colors.grey, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Next
              Container(
                width: MediaQuery.of(context).size.width,
                height: 75,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyShares.length,
                  itemBuilder: (BuildContext context, int index) {
                    Share currentshare = dummyShares[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(4),
                      width: 230,

                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 216, 212, 212)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentshare.shortName, style: Theme.of(context).textTheme.bodyMedium),
                              Text(
                                currentshare.fullName.length > 17
                                    ? '${currentshare.fullName.substring(0, 17)}...'
                                    : currentshare.fullName,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Text(
                            currentshare.recentChange,
                            style: Theme.of(context).textTheme.bodySmall?.apply(
                              color: currentshare.isPositive ? Colors.green : Colors.red,
                              fontWeightDelta: 30,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Next
              Container(
                padding: EdgeInsets.only(top: 42),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Wishlist', style: Theme.of(context).textTheme.titleMedium),
                        Icon(Icons.add_circle_outline_outlined, color: const Color.fromARGB(1000, 50, 66, 154)),
                      ],
                    ),

                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
