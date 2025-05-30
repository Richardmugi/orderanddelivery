import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AIZImage {
  static Widget basicImage(String url, {BoxFit fit = BoxFit.cover}) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      progressIndicatorBuilder: (context, string, progress) {
        return Image.asset(
          "assets/placeholder_rectangle.png",
          fit: BoxFit.cover,
        );
      },
      // placeholder:(BuildContext context,error){
      //   return Image.asset('assets/images/342x632.jpg',fit: BoxFit.cover,);
      // } ,
      // progressIndicatorBuilder: (context, url, downloadProgress) =>
      //     CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Image.asset(
        "assets/placeholder_rectangle.png",
        fit: BoxFit.cover,
      ),
    );
  }

  static Widget radiusImage(String? url, double radius,
      {BoxFit fit = BoxFit.cover, bool isShadow = true}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: isShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 20,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]
              : [],
        ),
        child: CachedNetworkImage(
          imageUrl: url ?? "",
          fit: fit,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
