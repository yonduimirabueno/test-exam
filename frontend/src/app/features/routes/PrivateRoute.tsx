import React from 'react'

function PrivateRoute({ children }: any) {
  const accessToken = false;
  const loading = false;
  
  if (accessToken) { 
    return children;
  } else if (loading) {
    return <p>Loading...</p>
  } else if (!accessToken && !loading){
    return <p>You are not logged in</p>
  } else {
    return <p>Something went wrong</p>
  }

}

export default PrivateRoute
