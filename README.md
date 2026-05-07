# Prize Wheel Game - Flutter

A lucky prize wheel game built with Flutter featuring:
- 🎡 Interactive spinning wheel
- 🍗 Fried chicken themed background
- 🎁 Multiple prize options:
  - Coupon 900K
  - Coupon 50K
  - Coupon 200K
  - 100% Discount (Free)

## Features

✨ **Smooth Animations**: Realistic spinning wheel with easing animations

✨ **Prize Display**: Shows selected prize with congratulations message

✨ **Responsive Design**: Works on different screen sizes

✨ **Beautiful UI**: Colorful wheel with clear prize labels

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   └── prize_wheel_screen.dart  # Main game screen
├── widgets/
│   └── prize_wheel_widget.dart  # Wheel widget and painters
└── models/
    └── prize.dart            # Prize model class
```

## How to Run

1. Install Flutter dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

3. Click "SPIN THE WHEEL" to play!

## Prize Distribution

The wheel is divided into 4 equal segments, each with a 25% chance of winning:
- Red: Coupon 900K
- Teal: Coupon 50K
- Yellow: Coupon 200K
- Mint Green: 100% Discount

## Customization

### Change Background Image
Edit `lib/screens/prize_wheel_screen.dart` line with `NetworkImage` to use your own image URL.

### Add More Prizes
Add new `Prize` objects to the `prizes` list in `PrizeWheelScreen`.

### Adjust Spin Duration
Modify the `Duration(seconds: 5)` in the `AnimationController`.

## Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **CustomPaint**: For wheel drawing
- **Animation**: For smooth spinning effects

## License

MIT License
