import React, { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { AppDispatch, RootState } from '../../store';
import { logoutUser } from './sessionSlice';

function Logout() {
  const navigate = useNavigate();
  const dispatch = useDispatch<AppDispatch>();
  const refreshToken = useSelector((state : RootState) => state.session.accessToken);

  useEffect(() => {
    if (refreshToken){
      dispatch(logoutUser(refreshToken));
    }
    navigate('/login');
  }, []);

  return (
    <div>Logout</div>
  )
}

export default Logout