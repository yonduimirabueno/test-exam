import * as React from 'react';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import { ParkingLotData } from './parkingLotSlice';

interface Column {
  id: 'id' | 'code' | 'population';
  label: string;
  minWidth?: number;
  align?: 'right';
  format?: (value: number) => string;
}

const columns: readonly Column[] = [
  { id: 'id', label: 'Parking Slot ID', minWidth: 170 },
  { id: 'code', label: 'ISO\u00a0Code', minWidth: 100 },
  {
    id: 'population',
    label: 'Population',
    minWidth: 170,
    align: 'right',
    format: (value: number) => value.toLocaleString('en-US'),
  }
];

interface Data {
  id: string;
  code: string;
  population: number;
}

function createData(
  id: string,
  code: string,
  population: number,
): Data {
  return { id, code, population };
}

export default function ParkingLot() {
  const loading = useSelector((state: RootState) => state.parkingLot.loading);
  const parkingLotData = useSelector((state: RootState) => state.parkingLot.parkingLot);

  const parkingLotColumns = (parkingLotData: ParkingLotData | undefined) => { 
    if (parkingLotData?.accessways) {
      return parkingLotData?.accessways
    }
    else { 
      return []
    }
  }

  const parkingLotRows = (parkingLotData: ParkingLotData | undefined) => { 
    if (parkingLotData?.parking_slots) {
      return parkingLotData?.parking_slots.map((parking_slot) => { 
        const distances: number[] = parking_slot.distances.map((distance) => distance.distance)
        distances.unshift(parking_slot.parking_slot.id)
        console.log("distances",distances)
        return distances
      });
    }
    else { 
      return []
    }
  }

  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(10);

  const handleChangePage = (event: unknown, newPage: number) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event: React.ChangeEvent<HTMLInputElement>) => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };
  
  return (
    <>
      {loading ? <p>Loading...</p> :
        parkingLotData ? 
        <Paper sx={{ width: '100%', overflow: 'hidden' }}>
          <TableContainer sx={{ maxHeight: 440 }}>
            <Table stickyHeader aria-label="sticky table">
              <TableHead>
                <TableRow>
                  <TableCell>
                    Parking Slot ID
                  </TableCell>
                  {parkingLotColumns(parkingLotData).map((column: any) => (
                    <TableCell key={column.id}>
                      Entrance {column.id} Distance
                    </TableCell>
                  ))}

                </TableRow>
              </TableHead>
              <TableBody>
                {
                    parkingLotRows(parkingLotData).map((row, i) => {
                    console.log("row and i",row, i)
                    return (
                      <TableRow hover role="checkbox" key={`${i}-rowdata`}>
                        {row.map((r: any, index: any) => {
                            console.log("r",r)
                          return (
                            <TableCell key={`${index}-row`}>
                              {r}
                            </TableCell>
                          );
                        })}
                      </TableRow>
                    );
                  })
              
                } 
              
              </TableBody>
            </Table>
          </TableContainer>
          <TablePagination
            rowsPerPageOptions={[10, 25, 100]}
            component="div"
            count={parkingLotColumns(parkingLotData).length}
            rowsPerPage={rowsPerPage}
            page={page}
            onPageChange={handleChangePage}
            onRowsPerPageChange={handleChangeRowsPerPage}
          />
          </Paper>
          : <p>No records</p>
      }
    </>
  );
}
