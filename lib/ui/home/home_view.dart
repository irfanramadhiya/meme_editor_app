import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meme_editor_app/ui/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    Future.microtask(() {
      if (vm.allMemes.isEmpty && !vm.isLoading && vm.error.isEmpty) {
        vm.fetchMemes(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Editor'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: vm.updateSearch,
              decoration: InputDecoration(
                hintText: 'Search memes...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => vm.fetchMemes(context),
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : vm.error.isNotEmpty
            ? Center(child: Text('Error: ${vm.error}'))
            : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: vm.memes.length,
                itemBuilder: (context, index) {
                  final meme = vm.memes[index];
                  return InkWell(
                    onTap: () => context.push('/detail', extra: meme),
                    child: Image.file(
                      File(meme.localPath),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
