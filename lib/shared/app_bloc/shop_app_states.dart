

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class EditPressedState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {}
////////////////////////////////////
class ChangeTabs extends ShopStates {}



///=============== categories =========================
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}
