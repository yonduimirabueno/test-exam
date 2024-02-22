import { Box, Container, MenuItem, MenuList, Typography } from '@mui/material'
import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import { ParkingLotData } from './parkingLotSlice';

function ParkingLots() {
  const loading = useSelector((state: RootState) => state.parkingLots.loading);
  const parkingLotsData = useSelector((state: RootState) => state.parkingLots.parkingLots);

  return (
    <Container >
      <Box sx={{ bgcolor: 'info.main' }}>
        <Typography variant="h6" textAlign="center" sx={{color: 'white', p: 2}}>Parking Lots</Typography>
      </Box>
      {
        loading ? <p>Loading...</p> :
        <MenuList>
            {
              parkingLotsData.map((parkingLotData: ParkingLotData) => (
              <MenuItem key={parkingLotData.id}>
                <Typography variant="inherit">{parkingLotData.name}</Typography>
              </MenuItem>
              ))
            }
        </MenuList>
      }
      
    </Container>
  )
}

export default ParkingLots
