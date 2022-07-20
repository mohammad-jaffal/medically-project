import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from './pages/Login';
import Home from './pages/Home';
import AddDomain from './pages/AddDomain';
import Requests from './pages/Requests';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path={"/"} element={<Login />}/>
        <Route path={"/home"} element={<Home />}/>
        <Route path={"/add-domain"} element={<AddDomain />}/>
        <Route path={"/requests"} element={<Requests />}/>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
