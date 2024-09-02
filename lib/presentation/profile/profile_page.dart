import 'package:flutter/material.dart';
import 'package:petmaama/presentation/profile/add_pet_screen.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);
int randomIndex = 3;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          actions: const [Icon(Icons.more_vert)],
        ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              color: Colors.amber,
              height: 200,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>   const AddPetPage()),
                    );
                  },
                  shape: const CircleBorder(),child: const Icon(Icons.add,color: Colors.amber,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
