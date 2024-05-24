import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeWidgetMain extends StatelessWidget {
  const HomeWidgetMain({
    super.key,
    required this.media,
    required this.mainImage,
    required this.profileImage
  });
  final String profileImage;
  final String mainImage;

  final Size media;

  @override
  Widget build(BuildContext context) {
    return Container(
     
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                
                height: media.height*0.08,width:media.height*0.08,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(profileImage),fit: BoxFit.cover),
                  color: kwhiteColor,
                  borderRadius: kradius100
                ),
              ),
              kwidth,
              const Column( 
                children: [
                  Text('Name',style: TextStyle(fontWeight: FontWeight.w700),),
                  
                  Text('2d ago'),
                ],
              )
            ],
          ),
          kheight,
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('fgdgs', maxLines: 3,style: TextStyle(overflow: TextOverflow.ellipsis,),textAlign: TextAlign.left,),
          ),
           kheight,
          Container(
            color: Colors.blue,
            height: media.width*0.984,
            
            child: Image(image: NetworkImage(mainImage),fit: BoxFit.cover,width: media.width,),
            
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
    
                  }, icon: Image.asset(likeIcon,width: 65,fit: BoxFit.cover,)),const Text('1 like')
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: (){
    
                  }, icon: Image.asset(commentIcon,),),const Text('1 comment ')
                ],
              ),
              
              IconButton(onPressed: (){}, icon: Image.asset(savePostIcon))
            ],
          ),
          
        ],
      ),
      );
  }
}