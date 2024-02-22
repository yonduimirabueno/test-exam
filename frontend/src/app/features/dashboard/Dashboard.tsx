import ParkingLot from "../parkinglot/ParkingLot"
import Grid from '@mui/material/Grid';
import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux';
import { AppDispatch, RootState } from '../../store';
import ParkingLots from "../parkinglot/ParkingLots";
import { parkingLots } from "../parkinglot/parkingLotsSlice";
import { parkingLot } from "../parkinglot/parkingLotSlice";

function Dashboard() {
  const accessToken = useSelector((state : RootState) => state.session.accessToken);
  const parkingLotsData = useSelector((state : RootState) => state.parkingLots.parkingLots);
  const dispatch = useDispatch<AppDispatch>();

  useEffect(() => {
    try {
      dispatch(parkingLots({token: accessToken}));
    } catch (error) {
      console.log(error);
    }
  }, [dispatch, accessToken])

  useEffect(() => {
    try {
      if (parkingLotsData) {
        dispatch(parkingLot({ token: accessToken, id: parkingLotsData[0].id }));
      }
    } catch (error) {
      console.log(error);
    }
  }, [dispatch, accessToken, parkingLotsData])

  return (
    <Grid container spacing={0} sx={{mt: 2}}>
      <Grid item md={4} lg={3} sx={{ display: { xs: "none", md: 'flex', lg: 'flex' } }}>
        <ParkingLots />
      </Grid>
      <Grid item xs={12} md={8} lg={6} sx={{px: 1}}>
        <ParkingLot />
      </Grid>
      <Grid item xs={12} md={4} lg={3}>
        TO DO: Generate Ticket and Invoice
      </Grid>
    </Grid>
  );
}

export default Dashboard