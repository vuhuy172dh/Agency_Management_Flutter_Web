import 'package:flutter/material.dart';

class NavBarItem extends StatefulWidget {
  final String title;
  final Function onTap;
  final bool selected;
  NavBarItem({
    required this.title,
    required this.onTap,
    required this.selected,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  late AnimationController _controller2;
  late Animation<Color?> _color;

  bool hovered = false;

  @override
  void initState() {
    super.initState();
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 275),
    );

    _color =
        ColorTween(end: Colors.red, begin: Colors.white).animate(_controller2);

    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      Future.delayed(Duration(milliseconds: 10), () {});
      _controller2.reverse();
    } else {
      _controller2.forward();
      Future.delayed(Duration(milliseconds: 10), () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 35),
          width: 202,
          color:
              hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 167,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: _color.value, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
