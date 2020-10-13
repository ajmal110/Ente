import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _allProducts = [
    //THIS IS A DUMMY DATA. This should actually be an EMPTY LIST, then list must be Fetched from server using FETCHANDSET.
    Product(
      rating: 4.00,
      image: '',
      prodId: '29',
      category: 'Waxy',
      title: 'Chinese Evergreen',
      price: 19.99,
      description:
          '"Buy something that likes to live the way you do," advises Gwenn Fried, manager of the Horticulture Therapy program at NYU Langone. "If you\'re more of a waterer, an excellent plant is a Chinese evergreen." It\'s super forgiving if you overdo it on H2O, and it comes in tons of different varieties.',
      tags: ['Chinese Evergreen'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '1',
      category: 'Medicinal',
      title: 'Asparagus Fern',
      price: 13.99,
      description:
          'This fluffy plant tolerates a lot more abuse than other ferns — thanks to the fact that it\'s technically not a fern. Asparagus setaceus adapts to both bright spots and darker corners. Keep the soil moist and it\'ll thrive.',
      tags: ['Asparagus Fern'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '30',
      category: 'Medicinal',
      title: 'Philodendron Birkin',
      price: 24.00,
      description:
          'Add a dose of nature to your space with the philodendron birkin, an easy-to-care-for plant that enjoys medium to bright indirect sunlight along with regular waterings. Just be sure to keep them away from pets and children, as they\'re toxic.',
      tags: ['Philodendron Birkin'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '2',
      category: 'Waxy',
      title: 'Fiddle LeafFig',
      price: 12.19,
      description:
          'These trendy trees have more than just lush foliage going for them. Their hardy disposition can adapt to most bright locations (minus direct sunlight). Water generously in the summer and slow it down when winter comes.',
      tags: ['Fiddle LeafFig'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '3',
      category: 'Flowering',
      title: 'Guiana Chestnut',
      price: 31.99,
      description:
          'More commonly known as money tree, Pachira aquatica frequently features a braided trunk. You\'ll want to stick it in a spot with bright, indirect light and water frequently — its native habitat is a swamp.',
      tags: ['Guiana Chestnut'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '8',
      category: 'Decorative',
      title: 'Chinese Money Plant',
      price: 12.95,
      description:
          'Here\'s another plant with fortuitous associations, although it also goes by the adorable nickname "Pancake Plant." Pilea peperomioides prefers a shady spot (or winter windowsill) and weekly watering, according to The Little Book of House Plants and Other Greenery. Bonus: You can replant the offshoots that sprout from the base of the stem and keep money plants all over your house. ',
      tags: ['Chinese Money Plant'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '12',
      category: 'Decorative',
      title: 'Cast-Iron Plant',
      price: 20.88,
      description:
          'The sturdy cast-iron plant lives up to its name, surviving low light, poor-quality soil, spotty watering, and a wide range of temperatures. Aspidistra elatior is the scientific name; elatior is Latin for "taller," which is apropos thanks to foliage that grows up to 2 feet high. The dark-leaved stunner likes to be left alone, so don\'t be too attentive, warns Nejman.',
      tags: ['Cast-Iron Plant'],
    ),
    Product(
      rating: 4.00,
      image: '',
      prodId: '4',
      category: 'Flowering',
      title: 'Yucca',
      price: 17.19,
      description:
          'The recipe for a happy yucca is easy: sun, sun, and more sun. Water sparingly and plant in a deep container to prevent the top-heavy woody stems from toppling over.',
      tags: ['Yucca'],
    ),
  ];

  List<Product> _favProducts = [];

  List<String> _topPicks = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  List<String> _cart = [];

  List<Map<String, String>> _myCart = [];

  List<String> get cart {
    return [..._cart];
  }

  List<Map<String, String>> get myCart {
    return [..._myCart];
  }

  List<Product> get allProducts {
    return [..._allProducts];
  }

  List<Product> get favProducts {
    return [..._favProducts];
  }

  List<String> get topPicks {
    return [..._topPicks];
  }

  void toggleCart(String a) {
    if (_cart.contains(a)) {
      _cart.remove(a);
      _myCart.removeWhere((element) => element['prodId'] == a);
    } else {
      _cart.add(a);
      _myCart.add({'prodId': a, 'count': '1'});
    }
    notifyListeners();
  }

  void changeCartCount(bool isAdd, String prodId) {
    int index = _myCart.indexWhere((element) => element['prodId'] == prodId);
    if (isAdd) {
      _myCart[index]['count'] =
          (int.parse(_myCart[index]['count']) + 1).toString();
    } else {
      if (_myCart[index]['count'] == '1') {
        toggleCart(_myCart[index]['prodId']);
      } else {
        _myCart[index]['count'] =
            (int.parse(_myCart[index]['count']) - 1).toString();
      }
    }
    notifyListeners();
  }

  void removeCartItem(String prodId) {
    int index = _myCart.indexWhere((element) => element['prodId'] == prodId);
    _cart.remove(prodId);
    _myCart.removeAt(index);

    notifyListeners();
  }

  void toggleFav(Product a) {
    if (_favProducts.contains(a)) {
      _favProducts.remove(a);
    } else {
      _favProducts.add(a);
    }
    notifyListeners();
  }

  void emptyCart() {
    _myCart = [];
    _cart = [];

    notifyListeners();
  }

  List<Product> productOfCategory(String cat) {
    List<Product> list = [];
    _allProducts.forEach((prod) {
      if (prod.category == cat) {
        list.add(prod);
      }
    });
    return list;
  }
}
