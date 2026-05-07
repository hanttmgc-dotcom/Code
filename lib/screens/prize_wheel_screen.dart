import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../models/prize.dart';
import '../widgets/prize_wheel_widget.dart';

class PrizeWheelScreen extends StatefulWidget {
  @override
  State<PrizeWheelScreen> createState() => _PrizeWheelScreenState();
}

class _PrizeWheelScreenState extends State<PrizeWheelScreen> {
  late StreamController<int> _controller;
  Prize? _selectedPrize;
  bool _isSpinning = false;

  final List<Prize> prizes = [
    Prize(
      name: 'Coupon 900K',
      couponValue: '900,000 VND',
      color: 0xFFFF6B6B,
    ),
    Prize(
      name: 'Coupon 50K',
      couponValue: '50,000 VND',
      color: 0xFF4ECDC4,
    ),
    Prize(
      name: 'Coupon 200K',
      couponValue: '200,000 VND',
      color: 0xFFFFE66D,
    ),
    Prize(
      name: '100% Discount',
      couponValue: 'Free',
      color: 0xFF95E1D3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
      _selectedPrize = null;
    });

    final randomIndex = (DateTime.now().millisecondsSinceEpoch % prizes.length);
    _controller.add(randomIndex);

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isSpinning = false;
        _selectedPrize = prizes[randomIndex];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lucky Prize Wheel',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              PrizeWheelWidget(
                prizes: prizes,
                controller: _controller,
              ),
              SizedBox(height: 30),
              if (_selectedPrize != null)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _selectedPrize!.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _selectedPrize!.couponValue,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isSpinning ? null : _spinWheel,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.orange,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: Text(
                  _isSpinning ? 'Spinning...' : 'SPIN THE WHEEL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
