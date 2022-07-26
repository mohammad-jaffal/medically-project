import { useNavigate } from "react-router-dom";
import mainLogo from '../assets/adminlogo.png';
import hamIcon from '../assets/hamicon.png';

const Navbar = () => {
    let navigate = useNavigate();



    function logoutFunction() {
        localStorage.setItem('admin_token', "none");
        navigate("/", { replace: true });
    }
    return (
        <div className="navbar">
            {/* <div className="navbar-title">Admin Panel</div> */}
            <img src={mainLogo} className="navbar-logo" />
            <div className="hamburgur-menu">
                <img src={hamIcon} className="ham-icon" />
                <ul className="ham-list">
                    <li><p>Home</p></li>
                    <li><p>Requests</p></li>
                    <li><p>Add Domain</p></li>
                    <li><p>Logout</p></li>
                </ul>
            </div>

            <ul className="navbar-menu">
                <li className="navbar-li" onClick={() => { navigate("/home", { replace: true }) }}><div>Home</div></li>
                <li className="navbar-li" onClick={() => { navigate("/requests", { replace: true }) }}><div>Requests</div></li>
                <li className="navbar-li" onClick={() => { navigate("/add-domain", { replace: true }) }}><div>Add Domain</div></li>
                <li className="navbar-li" onClick={() => { logoutFunction() }}><div>Logout</div></li>
            </ul>
        </div>
    );

}

export default Navbar;