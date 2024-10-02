import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Color> _colors = [
    const Color(0xFFDAD3C8),
    const Color(0xFFFFE5DE),
    const Color(0xFFDCF6E6),
  ];

  final List<Image> _images = [
    Image.asset("assets/images/onboarding_one.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/onboarding_two.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/onboarding_three.jpg", fit: BoxFit.cover),
  ];

  final List<String> _titles = [
    "Unlock Your Style",
    "Complete Collection of Colors and Sizes",
    "Find the Most Suitable Outfit",
  ];

  final List<String> _subtitles = [
    "Discover a wide variety of products \nthat suit your needs, all in one place.",
    "Explore the full range of colors and sizes \nto find the perfect fit for your style.",
    "Browse through outfits that complement \nyour vibe and find your perfect match.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildOnboardingContent(),
    );
  }

  Widget _buildOnboardingContent() {
    return Column(
      children: [
        _buildPageView(),
        _buildBottomNavigation(),
      ],
    );
  }

  Widget _buildPageView() {
    return Flexible(
      flex: 1,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        itemCount: _images.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return _buildPage(index);
        },
      ),
    );
  }

  Widget _buildPage(int index) {
    return Container(
      color: _colors[index],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Consistent padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0), // Add rounded corners for a more modern feel
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: _images[index],
              ),
            ),
            const SizedBox(height: 25.0),
            Text(
              _titles[index],
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10.0),
            Text(
              _subtitles[index],
              style: const TextStyle(
                fontSize: 18.0, // Slightly smaller subtitle for contrast
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35.0),
            _buildDotsIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: _colors[_currentPage],
      child: Column(
        children: [
          _buildNavigationButtons(),
          const SizedBox(height: 35.0),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_images.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6.0),
          width: _currentPage == index ? 20.0 : 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: _currentPage == index ? Colors.black87 : Colors.black45,
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: _currentPage > 0 && _currentPage < _images.length - 1,
          child: GestureDetector(
            onTap: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Visibility(
          visible: _currentPage < _images.length - 1,
          child: GestureDetector(
            onTap: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _currentPage == _images.length - 1,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the main screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
