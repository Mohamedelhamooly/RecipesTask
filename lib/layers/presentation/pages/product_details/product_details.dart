import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_task/Const/const.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/widgets/image_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.model});

  final RecipeModel model;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 7.0,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _counter > 0 ? _decrementCounter : null,
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: const Color(0xffD8D8D8))),
                          child: const Icon(
                            Icons.minimize_rounded,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        '$_counter',
                        style: kTextStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: kTitleColor),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      GestureDetector(
                        onTap: _incrementCounter,
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kSecondaryColor,
                              border: Border.all(color: kPrimaryColor)),
                          child: const Icon(
                            Icons.add,
                            color: kTitleColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: 50,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "add to cart",
                        style: kTextStyle.copyWith(
                            fontWeight: FontWeight.bold, color: kWhite),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                width: 40,
                height: 40,
                decoration:
                    const BoxDecoration(color: kWhite, shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: kTitleColor,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: ImageWidget(
                        data: widget.model.image ?? '',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: 30,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.name ?? "",
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.model.description ?? "",
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "fats",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.model.fats ?? "",
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "ingredients",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.model.ingredients.toString() ?? "",
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        const Divider(
                          thickness: 1,
                          color: kBorderColorTextField,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
