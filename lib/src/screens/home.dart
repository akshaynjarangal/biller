import 'package:biller/src/data/models/home_model.dart';
import 'package:biller/src/logic/bottom_nav/bottom_nav_bloc.dart';
import 'package:biller/src/logic/home_grid/home_grid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            child: Image.asset('assets/ic_launcher.png'),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: BlocListener<BottomNavBloc, BottomNavState>(
        listener: (context, state) {
          
          if(state.index == 1){
            context.read<HomeGridBloc>().add(const ChangeGridIndex(index: 2));
          }
          if(state.index == 3){
            context.read<HomeGridBloc>().add(const ChangeGridIndex(index: 3));
          }
          if(state.index == 4){
            context.read<HomeGridBloc>().add(const ChangeGridIndex(index: 0));
          }
        },
        child: BlocBuilder<HomeGridBloc, HomeGridState>(
          builder: (context, state) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: homeGridItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<HomeGridBloc>()
                        .add(ChangeGridIndex(index: index));
                    if (index == 0) {
                      context
                          .read<BottomNavBloc>()
                          .add(const ChangeIndex(index: 4));
                    }
                    if (index == 1) {
                      context.push('/products');
                    }
                    if (index == 2) {
                      context
                          .read<BottomNavBloc>()
                          .add(const ChangeIndex(index: 1));
                    }
                    if (index == 3) {
                      context
                          .read<BottomNavBloc>()
                          .add(const ChangeIndex(index: 3));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: index == state.gridIndex
                          ? Colors.blue.shade900
                          : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.flip(
                          flipX: index == 3 ? true : false,
                          child: Icon(
                            index == state.gridIndex
                                ? homeGridItems[index].selectedIcon
                                : homeGridItems[index].icon,
                            size: 40,
                            color:
                                state.gridIndex == index ? Colors.white : null,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          homeGridItems[index].title,
                          style: TextStyle(
                            color:
                                index == state.gridIndex ? Colors.white : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
