import { useNavigate } from "react-router-dom";


const Navbar = () => {
    let navigate = useNavigate();



    function logoutFunction() {
        navigate("/", { replace: true });
    }
    return (
        <div className="navbar">
            <div className="navbar-title">Admin Panel</div>
            <ul className="navbar-menu">
                <li className="navbar-li" onClick={() => {}}><div>Home</div></li>
                <li className="navbar-li" onClick={() => {}}><div>Add Domain</div></li>
                <li className="navbar-li" onClick={() => { logoutFunction() }}><div>Logout</div></li>
            </ul>
        </div>
    );

}

export default Navbar;