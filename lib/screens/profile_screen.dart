import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'https://w0.peakpx.com/wallpaper/64/995/HD-wallpaper-aesthetic-skies-1-background-clouds-iphone-moon-pink-purple-sky-stars.jpg'),
            ),
            const SizedBox(height: 20),
            Text('Khalilul Afwan',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Veniam laborum ullamco aute amet minim veniam laboris.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.cake),
                    title: Text('Birth Date'),
                    subtitle: Text('05-08-2003'),
                  ),
                  ListTile(
                      leading: const Icon(Icons.web),
                      title: const Text('Website'),
                      subtitle: const Text('none'),
                      onTap: () {}),
                  const ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('khalilul@gmail.com'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Address'),
                    subtitle: Text('Tangerang, Banten'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () => {print("ini facebook")},
                  color: Colors.blue,
                  tooltip: 'Facebook',
                ),
                IconButton(
                  icon: const Icon(Icons.link),
                  onPressed: () {},
                  color: Colors.blue,
                  tooltip: 'LinkedIn',
                ),
                IconButton(
                  icon: const Icon(Icons.code),
                  onPressed: () {},
                  color: Colors.black,
                  tooltip: 'GitHub',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
