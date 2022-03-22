import 'package:flutter/material.dart';

class StyleCard extends StatelessWidget {
  const StyleCard({Key? key, required this.image, required this.title})
      : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 150,
      child: Center(
        child: InkWell(
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(image),
                      ),
                    ),
                  );
                });
          },
          child: Card(
            child: Column(children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image(
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
                      image: NetworkImage(image))),
              const SizedBox(height: 10),
              Text(title, style: Theme.of(context).textTheme.bodyText2),
            ]),
          ),
        ),
      ),
    );
  }
}
