import { configureStore, ThunkAction, Action } from "@reduxjs/toolkit";
import counterReducer from "./features/counter/counterSlice";
import sessionReducer from "./features/sessions/sessionSlice";
import parkingLotsReducer from "./features/parkinglot/parkingLotsSlice";
import parkingLotReducer from "./features/parkinglot/parkingLotSlice";

export const store = configureStore({
  reducer: {
    counter: counterReducer,
    session: sessionReducer,
    parkingLots: parkingLotsReducer,
    parkingLot: parkingLotReducer,
  },
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
