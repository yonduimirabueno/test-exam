import axios from "./axios";
const PARKING_LOTS_URL = "/parking_lots";

// PARKINGS
export async function getParkingLots(
  token: string | undefined,
) {
  const config = {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  };
  return axios
    .get(PARKING_LOTS_URL, config)
    .then((response: any) => {
      return response.data;
    })
    .catch((error: any) => {
      return error.response.data;
    });
}

export async function getParkingLot(
  token: string | undefined,
  id: number
) {
  const config = {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  };
  return axios
    .get(`${PARKING_LOTS_URL}/${id}`, config)
    .then((response: any) => {
      return response.data;
    })
    .catch((error: any) => {
      return error.response.data;
    });
}
