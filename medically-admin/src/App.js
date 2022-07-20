import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from './pages/Login';
import Home from './pages/Home';
import AddDomain from './pages/AddDomain';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path={"/"} element={<Login />}/>
        <Route path={"/home"} element={<Home />}/>
        <Route path={"/add-domain"} element={<AddDomain />}/>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
