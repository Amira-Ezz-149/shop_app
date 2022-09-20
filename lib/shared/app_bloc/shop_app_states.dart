

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class EditPressedState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}



///=============== categories =========================
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}
