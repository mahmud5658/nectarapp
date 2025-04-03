enum PageName {
  home,
  search,
  favorite,
  cart,
  ;

  bool get isHome => this == PageName.home;
  bool get isSearch => this == PageName.search;
  bool get isFavorite => this == PageName.favorite;
  bool get isCart => this == PageName.cart;
}
