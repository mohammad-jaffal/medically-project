

const Navbar = () => {

    return (
        <div className="navbar">
            <div className="main-logo">Admin Panel</div>
            <ul className="navbar-menu">
                <li className="navbar-li" onClick={() => {}}><div>Home</div></li>
                <li className="navbar-li" onClick={() => {}}><div>Add Domain</div></li>
                <li className="navbar-li" onClick={() => { logoutFunction() }}><div>Logout</div></li>
            </ul>
        </div>
    );

}

export default Navbar;